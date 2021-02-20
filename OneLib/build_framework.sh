#!/bin/sh

configuration="Release"
DEV_FLAG=""
VER_FLAG=""

for i in "$@"
do
PFLAG=`echo $i|cut -b1-2`
PPARAM=`echo $i|cut -b3-`
if [ $PFLAG == "-b" ]
then
DEV_FLAG=$PPARAM
elif [ $PFLAG == "-v" ]
then
VER_FLAG=$PPARAM
fi
done

if [[ ${DEV_FLAG} == "debug" ]] || [[ ${DEV_FLAG} == "Debug" ]]
then
configuration="Debug"
else
configuration="Release"
fi


PROJECT_WORKSPACE="../Demo/Demo.xcworkspace"
PROJECT_SCHEME="OneLib"
TARGET_NAME="OneLib"
TARGET_DEVICE="iphoneos"
TARGET_SIMULATOR="iphonesimulator"

INSTALL_DIR=$(pwd)/Products/${TARGET_NAME}.framework

WORK_DIR=build
DEVICE_DIR=${WORK_DIR}/${configuration}-iphoneos/${TARGET_NAME}.framework
SIMULATOR_DIR=${WORK_DIR}/${configuration}-iphonesimulator/${TARGET_NAME}.framework

if [ -d ${WORK_DIR} ]; then
rm -rf ${WORK_DIR}
fi


# 修改版本号和时间
build_time=`date "+%Y-%m-%d %H:%M"`

im_build_time="SDK_WIMLib_BuildTime @\"${build_time}\""
sed -i "" "s/SDK_WIMLib_BuildTime.*/${im_build_time}/g" ./OneLib/BuildVersion.h

im_version="SDK_WIMLib_Version @\"${VER_FLAG}\""
sed -i "" "s/SDK_WIMLib_Version.*/${im_version}/g" ./OneLib/BuildVersion.h


xcodebuild clean \
-workspace ${PROJECT_WORKSPACE} \
-scheme ${PROJECT_SCHEME} \
-configuration ${configuration} \
-sdk ${TARGET_SIMULATOR} \
-UseModernBuildSystem=YES

xcodebuild clean \
-workspace ${PROJECT_WORKSPACE} \
-scheme ${PROJECT_SCHEME} \
-configuration ${configuration} \
-sdk ${TARGET_DEVICE} \
-UseModernBuildSystem=YES


echo "***开始build iphonesimulator文件${configuration}***"

xcodebuild build \
-workspace ${PROJECT_WORKSPACE} \
-scheme ${PROJECT_SCHEME} \
-configuration ${configuration} \
-sdk ${TARGET_SIMULATOR} -arch x86_64 \
-UseModernBuildSystem=YES \
 ONLY_ACTIVE_ARCH=NO \
 DEPLOYMENT_POSTPROCESSING=YES \
 GCC_GENERATE_DEBUGGING_SYMBOLS=NO \
 GCC_SYMBOLS_PRIVATE_EXTERN=YES \
 STRIP_STYLE="non-global" \
 COPY_PHASE_STRIP=YES \
 SYMROOT=build

echo "***开始build iphoneos文件***${configuration}"

xcodebuild build \
-workspace ${PROJECT_WORKSPACE} \
-scheme ${PROJECT_SCHEME} \
-configuration ${configuration} \
-sdk ${TARGET_DEVICE} \
-UseModernBuildSystem=YES \
 ONLY_ACTIVE_ARCH=NO \
 DEPLOYMENT_POSTPROCESSING=YES \
 GCC_GENERATE_DEBUGGING_SYMBOLS=NO \
 GCC_SYMBOLS_PRIVATE_EXTERN=YES \
 STRIP_STYLE="non-global" \
 COPY_PHASE_STRIP=YES \
 SYMROOT=build


if [ -d ${INSTALL_DIR} ]
then
rm -rf ${INSTALL_DIR}
fi
mkdir -p ${INSTALL_DIR}

cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"
cp -R "${SIMULATOR_DIR}/" "${INSTALL_DIR}/"

lipo -create "${DEVICE_DIR}/${TARGET_NAME}" "${SIMULATOR_DIR}/${TARGET_NAME}" -output "${INSTALL_DIR}/${TARGET_NAME}"
rm -r ${WORK_DIR}

# 自动移动到 Demo SDK 目录
DST_DIR="../Frameworks"
if [ ! -d $DST_DIR ]; then
mkdir -p "$DST_DIR"
fi
rm -rf "${DST_DIR}/*"
cp -af ${INSTALL_DIR} ${DST_DIR}

#rm -r $(pwd)/Products

echo "***完成Build ${TARGET_NAME}静态库${configuration}****"

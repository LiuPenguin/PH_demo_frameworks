#!/bin/sh

#  bulid-imlib.sh
#  WChatIMLib
#
#  Created by huipeng on 2020/09/03.
#  Copyright © 2020 WChat. All rights reserved.


# eg 终端进入此工程目录 运行 sh -x autobuild.sh -bRelease -vx.x.x.xx

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

if [ ${DEV_FLAG} == "Debug" ]
then
configuration="Debug"
else
configuration="Release"
fi

rm -rf bin/*
rm -rf build/*

PROJECT_WORKSPACE="../Demo/Demo.xcworkspace"
PROJECT_NAME="OneLib.xcodeproj"
PROJECT_SCHEME="OneLib"
TARGET_NAME="OneLib"
TARGET_DEVICE="iphoneos"
TARGET_SIMULATOR="iphonesimulator"


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
 DEPLOYMENT_POSTPROCESSING=YES \
 GCC_GENERATE_DEBUGGING_SYMBOLS=NO \
 GCC_SYMBOLS_PRIVATE_EXTERN=YES \
 STRIP_STYLE="non-global" \
 COPY_PHASE_STRIP=YES \
 SYMROOT=build |xcpretty

echo "***开始build iphoneos文件***${configuration}"

xcodebuild build \
-workspace ${PROJECT_WORKSPACE} \
-scheme ${PROJECT_SCHEME} \
-configuration ${configuration} \
-sdk ${TARGET_DEVICE} \
-UseModernBuildSystem=YES \
 DEPLOYMENT_POSTPROCESSING=YES \
 GCC_GENERATE_DEBUGGING_SYMBOLS=NO \
 GCC_SYMBOLS_PRIVATE_EXTERN=YES \
 STRIP_STYLE="non-global" \
 COPY_PHASE_STRIP=YES \
 SYMROOT=build |xcpretty


# 导出sdk地址
exportSdkPath="../Demo/3rdFrameworks/OneLibSDK"

if [ ! -d $exportSdkPath ]; then
mkdir -p $exportSdkPath;
fi

# 获取工程当前所在路径
project_path=$(pwd)

# 编译文件路径
buildPath=${project_path}/build
# 真机sdk路径
iphoneos_path=${buildPath}/${configuration}-iphoneos/${TARGET_NAME}.framework/${TARGET_NAME}
# 模拟器sdk路径
simulator_path=${buildPath}/${configuration}-iphonesimulator/${TARGET_NAME}.framework/${TARGET_NAME}
# 合并后sdk路径
merge_path=${exportSdkPath}/${TARGET_NAME}.framework/${TARGET_NAME}
# 合并模拟器和真机.framework包
lipo -create ${iphoneos_path} ${simulator_path} -output ${merge_path}
# 拷贝framework到目标文件夹
cp -R ${buildPath}/${configuration}-iphoneos/${TARGET_NAME}.framework ${exportSdkPath}

# 移除一些编译中间文件
rm -rf build

echo "***完成Build ${TARGET_NAME}静态库${configuration}****"


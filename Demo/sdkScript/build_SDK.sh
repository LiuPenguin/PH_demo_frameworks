#!/bin/sh

DEV_FLAG="debug"
VER_FLAG="v1.0"
VER_FLAG_Demo="0.0.0.0"
Need_Zip="0"
Need_ShowLogic="0" # 默认不开源Logic
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
elif [ $PFLAG == "-t" ]
then
Need_Tag=$PPARAM
elif [ $PFLAG == "-z" ]
then
Need_Zip=$PPARAM
elif [ $PFLAG == "-s" ]
then
Need_ShowLogic=$PPARAM
elif [ $PFLAG == "-x" ]
then
VER_FLAG_Demo=$PPARAM
fi
done

cd ..
cd ..

cd OneLib
echo "***开始编译OneLib层****-v${VER_FLAG}"
sh autobuild.sh -b${DEV_FLAG} -v${VER_FLAG}
echo "***结束编译OneLib层****"
cd ..

cd TwoLin
echo "***开始编译TwoLin层****-v${VER_FLAG}"
sh autobuild.sh -b${DEV_FLAG} -v${VER_FLAG}
echo "***结束编译TwoLin层****"
cd ..


cd Demo/sdkScript

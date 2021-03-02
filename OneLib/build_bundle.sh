#!/bin/sh

BUNDLE_DIR=${TARGET_BUILD_DIR}/OneLibBundle.bundle

echo "================================"
echo "拷贝 ${BUNDLE_DIR} "
echo "================================"

# 自动移动到 Demo SDK 目录
DST_DIR="../Demo/3rdFrameworks/OneLibSDK"
if [ ! -d $DST_DIR ]; then
mkdir -p "$DST_DIR"
fi
rm -rf "${DST_DIR}/*"
cp -af ${BUNDLE_DIR} ${DST_DIR}

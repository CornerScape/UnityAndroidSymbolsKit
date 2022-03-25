#!/bin/bash

if [ "$1" == "" ]
then
	echo "Usage: syms4gplay.sh UnityDebugSymbols.zip"
	exit
fi


ZIPLOC="$TMPDIR""syms4gplay"
ZIPFILE=${1/symbols/syms4gplay}
WD=`pwd`

echo "Extracting $1 with native release symbols to TMP..."
unzip "$1" -d "$ZIPLOC" -x "*.so.debug"

ARM64="$ZIPLOC/arm64-v8a"
ARM32="$ZIPLOC/armeabi-v7a"
mv "$ARM64/libunity.sym.so" "$ARM64/libunity.so"
mv "$ARM64/libil2cpp.sym" "$ARM64/libil2cpp.so"
mv "$ARM32/libunity.sym.so" "$ARM32/libunity.so"
mv "$ARM32/libil2cpp.sym" "$ARM32/libil2cpp.so"

echo "Creating new $ZIPFILE..."
cd "$ZIPLOC"
zip -FS -r "$WD/$ZIPFILE" . -x ".*" -x "__MACOSX"
cd "$WD"

echo "Cleaning up..."
rm -r "$ZIPLOC"

echo "Script Complete!"

#!/usr/bin/env bash

[ $# -eq 0 ] && { echo "Usage: $0 path [version]"; exit 1; }
ZPATH=$1
VERSION=${2:-0.8.1}
cd ${ZPATH}
wget -O zeppelin.tar.gz https://github.com/apache/zeppelin/archive/v${VERSION}.tar.gz
tar --strip-components=1 -xvf zeppelin.tar.gz zeppelin-${VERSION}/conf
rm zeppelin.tar.gz


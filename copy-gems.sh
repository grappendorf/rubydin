#!/bin/bash
DST=${1:-root@server}
echo $(find . -iname "*.gem") $DST: | xargs scp
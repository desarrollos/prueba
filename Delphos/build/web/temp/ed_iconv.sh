#!/bin/bash
#echo "El primer nombre es: $1"
iconv -c -f $1 -t utf-8 $2 > $2.utf8

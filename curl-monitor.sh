#!/bin/bash

url=$1
val0=""
logCurlResponse(){
 tmpfile=$(mktemp) && tmpfile1=$(mktemp)
 curl --dump-header $tmpfile $url > $tmpfile1
 newVar=$(head -1 $tmpfile)
 if [ "$val0" = "" ]; then
   val0=${newVar#HTTP/1.1} && val1=6
 elif [ "$val0" != "${newVar#HTTP/1.1}" ]; then
   val0=${newVar#HTTP/1.1} && val1=15
 fi
 tput cup 5 $val1 && echo $val0 
 tput cup 7 0 && head -1 $tmpfile1
}

val2=1
while [ $val2 -le $2 ]; do 
 sleep 1 && tput cup 5 0 && echo $val2
 tput cup 1 0 && logCurlResponse && ((val2++))
done

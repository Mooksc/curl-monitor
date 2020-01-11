#!/bin/bash

URL=$1
val0=""
getCurlResponse(){
 tmpfile0=$(mktemp) && tmpfile1=$(mktemp)
 curl --dump-header $tmpfile0 $URL > $tmpfile1
 IFS=' ' && read -ra code <<< $(head -1 $tmpfile0)
 if [ "$val0" = "" ]; then
   val0="${code[1]} ${code[2]}" && codePos=4 && counterPos=0
 elif [ "$val0" != "${code[1]} ${code[2]}" ]; then
   val0="${code[1]} ${code[2]}" && codePos=16 && counterPos=12
 fi
}
counter=1
while [ $counter -le $2 ]; do
 tput cup 1 0 && getCurlResponse
 tput cup 5 $counterPos && echo $counter
 tput cup 5 $codePos && echo $val0
 tput cup 7 0 && head -1 $tmpfile1
 sleep 1 && ((counter++))
done

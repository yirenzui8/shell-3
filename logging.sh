#!/bin/bash
# Author: chuantong.haung@gmail.com
# Date: 2014-07-01@wps.cn
# usage like this in other shell:
#	 . logging.sh
#	 var=123
#	 info "this is an information. can use any $var."
#	 err "error...."

_now()
{
  currTime=`date +"%Y-%m-%d %H:%M:%S"`
  echo `date -d "$currTime" +%s`
}

_LastTime=`_now`
_log(){
  currTime=`_now`
  printf  "%s [%4d] %s\n" "$(date +'%y-%m-%d %H:%M:%S')" $(($currTime - $_LastTime)) "$*"
  _LastTime=$currTime
}

warn (){
  _log "[WARNING] $*"
}

info() {
  _log "[INFO] $*"
}

err() {
  _log "[ERROR] $*"
}

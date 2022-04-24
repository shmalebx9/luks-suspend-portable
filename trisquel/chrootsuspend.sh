#!/bin/bash
export PATH=/bin:/usr/bin:/sbin:/usr/sbin

cryptroot=$1
echo "Alpine chroot suspending $cryptroot"

function do_suspend() {
#	/usr/sbin/pm-suspend
echo -n "mem" > /sys/power/state
}

function unlock() {
   cryptsetup luksResume "$cryptroot"
}

function do_lockunlock() {
   sync
   cryptsetup luksSuspend "$cryptroot" && echo "disk now locked"
   sync

   echo "Attempting to suspend from chroot"
   do_suspend &
   sleep 1
   echo "- Attempting to unlock..."
   unlock
   while [ $? -ne 0 ]; do
       unlock
   done
}

sleep 2
do_lockunlock

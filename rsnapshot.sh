#!/bin/bash

## Source: https://wiki.archlinux.org/index.php/Rsync

## Ilya Prokin, isprokin (a) gmail DOT com, https://github.com/iprokin
## my own rsync-based snapshot-style backup procedure slightly modified from the
## one of marcio rps AT gmail.com
## I have added check up if backup drive is connected and date formatting

# config vars

SRC="/home/ilya/" #dont forget trailing slash!
SNAP="/run/media/ilya/BACKUPHDDNAME/backup/ilya"
OPTS="-rltgoi --delay-updates --delete --chmod=a-w"
MINCHANGES=20
DATEFORMAT="+%Y-%m-%d--%H-%M"


if [ -d "$SNAP" ] ; then

  # run this process with real low priority

  ionice -c 3 -p $$
  renice +12  -p $$

  # sync

  rsync $OPTS $SRC $SNAP/latest >> $SNAP/rsync.log

  # check if enough has changed and if so
  # make a hardlinked copy named as the date

  COUNT=$( wc -l $SNAP/rsync.log|cut -d" " -f1 )
  if [ $COUNT -gt $MINCHANGES ] ; then
    DATETAG=$(date $DATEFORMAT)
    if [ ! -e $SNAP/$DATETAG ] ; then
      cp -al $SNAP/latest $SNAP/$DATETAG
      chmod u+w $SNAP/$DATETAG
      mv $SNAP/rsync.log $SNAP/$DATETAG
      chmod u-w $SNAP/$DATETAG
    fi
  fi

else
	echo "Sorry, the backup folder $SNAP not found"
fi

#!/usr/bin/env bash

echo $1
if [ "$1" == "" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$2" == "" ]; then
  printf " -------\nTELETIME or SSTRPIPE: a very Simple Script To Run Programs In a Past Environment\n(c) Ilya Prokin, isprokin@gmail.com, https://github.com/iprokin\n -------\nThis script redefines environmental variables so your HOME replaced with its backup. The later allows you to go back in time, i.e. to run programs so they see files from the past. \n\nTake a look at the source it's very simple. \n\nUsage:\n bash teletime.sh BACKUPNAME COMMAND\n\nE.g.:\n bash teletime.sh 2015-08-28-00:59 bash\n bash teletime.sh 2015-08-28-00:59 python\n"
else
  export HOLD="$HOME" # the shortcut to your actual home folder, to allow you to do e.g. "cd $HOLD"
  BACKUPS="/run/media/ilya/BACKUPHDDNAME/backup/ilya" # folder with backups of your home folder
  export HOME="$BACKUPS/$1"
  # whatever env variables you need
  export PYTHONPATH="$HOME/Dropbox/MyPy"
  eval $2
fi

#!/usr/bin/env bash

BACKUPS="/media/BACKUPHDDNAME/backup/ilya" # folder with backups of your home folder
VARIABLES='export PYTHONPATH="$HOME/MyPy"' # define here whatever env variables you need

HELP=" -------\nTELETIME or SSTRPIPE: a very Simple Script To Run Programs In a Past Environment\n(c) Ilya Prokin, isprokin@gmail.com, https://github.com/iprokin\n -------\nThis script redefines environmental variables so your HOME replaced with its backup. The later allows you to go back in time, i.e. to run programs so they see files from the past. \n\nTake a look at the source it's very simple. \n\nUsage:\n bash teletime.sh BACKUPNAME COMMAND\n\nE.g.:\n bash teletime.sh 2015-08-28--00-59 bash\n bash teletime.sh 2015-08-28--00-59 python\nbash teletime.sh 2015-08-28--10-09 'cd ~/YourPathTo/FolderOfChoice && ipython notebook'\n"

if [ "$1" == "" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ "$2" == "" ]; then
  printf $HELP
  exit 0
else
  echo "Going back to $1"
  export HOLD="$HOME" # the shortcut to your actual home folder, to allow you to do e.g. "cd $HOLD"
  export HOME="$BACKUPS/$1"
  eval $VARIABLES
  eval $2
fi

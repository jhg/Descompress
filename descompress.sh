#!/bin/bash

##############################################################################
##                                                                          ##
## Decompress is a script for linux that add news users from csv file.      ##
##                                                                          ##
## decompress.sh (C) 2011 Jesús Hernández Gormaz.                           ##
##                                                                          ##
##   This program is free software; you can redistribute it and/or          ##
##     modify it under the terms of the GNU General Public License as       ##
##     published by the Free Software Foundation; either version 3, or      ##
##     (at your option) any later version.                                  ##
##     This program is distributed in the hope that it will be useful,      ##
##     but WITHOUT ANY WARRANTY; without even the implied warranty of       ##
##     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the         ##
##     GNU General Public License for more details.                         ##
##     You should have received a copy of the GNU General Public License    ##
##     along with this program; if not, write to the Free Software          ##
##     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.            ##
##                                                                          ##
##############################################################################

# Help
if [ "$1" = "--help" ]
then
  cat <<HELP
Descompress (C) 2012 Jesús Hernández Gormaz
  This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 3, or
    (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

Descompresses any compressed file by checking type. To use:
$ ./descompress.sh <file>
HELP
  exit
fi

# Version
if [ "$1" = "--version" ]
then
  cat <<VERSION
Descompress 0.0.0
VERSION
  exit
fi

# Check if file exist and can read
if [ ! -r $1 ]
then
  echo "File no exist."
  exit
else
  # Check with file and grep by trial and error the file type
  tipo=$(file -i $1 | grep zip:)
  if [ ${#tipo} != 0 ]
  then
    unzip $1
  fi
  tipo=$(file -i $1 | grep tar:)
  if [ ${#tipo} != 0 ]
  then
    tar -xvf $1
  fi
  tipo=$(file -i $1 | grep gz:)
  if [ ${#tipo} != 0 ]
  then
    tipo=$(file -i $1 | grep .tar.gz:)
    if [ ${#tipo} != 0 ]
    then
      tar -xzvf $1
    else
      tipo=$(file -i $1 | grep .tgz:)
      if [ ${#tipo} != 0 ]
      then
        tar -xzvf $1
      else
        gzip -d $1
      fi
    fi
  fi
  tipo=$(file -i $1 | grep bz2)
  if [ ${#tipo} != 0 ]
  then
    tipo=$(file -i $1 | grep .tar.bz2:)
    if [ ${#tipo} != 0 ]
    then
      bzip2 -dc $1 | tar -xv
    else
      bzip2 -d $1
    fi
  fi
  tipo=$(file -i $1 | grep .lzma)
  if [ ${#tipo} != 0 ]
  then
    lha -x $1
  fi
  tipo=$(file -i $1 | grep .rar)
  if [ ${#tipo} != 0 ]
  then
    rar -x $1
  fi
  echo "Descompress finish."
fi

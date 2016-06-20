#!/bin/bash -e

SYNC_DIR="/vagrant"
ROOT_DIR="/root"

SETUP_CONF=$SYNC_DIR/vagrant/setup.conf
SETUP_SCRIPT=$SYNC_DIR/vagrant/setup.sh

# lib functions
function add_to_file_if_not_already {
	FILE=$1
	LINE=$2
	(grep "$LINE" $FILE) || (echo -e "$LINE" >> $FILE)
}

function edit_file_if_not_already {
	FILE=$1
	FROM_LINE=$2
	TO_LINE=$3
	(egrep "$FROM_LINE" $FILE) || (sed -i "s/$FROM_LINE/$TO_LINE/g" $FILE)
}

pushd $ROOT_DIR

. $SETUP_CONF
. $SETUP_SCRIPT

popd

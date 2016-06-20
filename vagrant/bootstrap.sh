#!/bin/bash -e

SYNC_DIR="/vagrant"
ROOT_DIR="/root"

SETUP_CONF=$SYNC_DIR/vagrant/setup.conf
SETUP_SCRIPT=$SYNC_DIR/vagrant/setup.sh


pushd $ROOT_DIR

. $SETUP_CONF
. $SETUP_SCRIPT

popd

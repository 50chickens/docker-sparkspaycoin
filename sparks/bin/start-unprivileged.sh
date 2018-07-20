#!/bin/bash
set -x

COMPONENT=$1
COIN_BINARY=$2
EXECUTABLE=/opt/$COMPONENT/bin/$COIN_BINARY

echo "Initialization completed successfully"

exec $EXECUTABLE

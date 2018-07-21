#!/bin/bash
set -x

USER=$2

chown -R ${USER} .
exec gosu ${USER} "$@"

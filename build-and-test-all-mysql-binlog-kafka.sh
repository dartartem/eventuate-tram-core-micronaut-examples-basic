#! /bin/bash

set -e

export DATABASE=mysql
export MODE=binlog
export BROKER=kafka

. ./set-env-mysql-binlog.sh

./_build-and-test-all.sh

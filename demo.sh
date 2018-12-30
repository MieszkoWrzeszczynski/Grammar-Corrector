#!/bin/bash

set -ue
set -o pipefail

echo "Unpacking far ..."
tar xf ./src/bin/corrector.tar.gz -C ./src/bin
./src/corrector.rb --f

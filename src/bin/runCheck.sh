#!/bin/bash

echo $1 | thraxrewrite-tester --far=./src/bin/corrector.far --rules=corrector --noutput=3

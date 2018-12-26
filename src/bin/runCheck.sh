#!/bin/bash

echo $1 | thraxrewrite-tester --far=./bin/corrector.far --rules=corrector --noutput=3

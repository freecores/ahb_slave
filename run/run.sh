#!/bin/bash

../../../robust ../src/base/ahb_slave.v -od out -I ../src/gen -list list.txt -listpath -header ${@}

echo Completed RobustVerilog ahb slave run - results in run/out/

#!/bin/bash
# Usage: ./synth.sh <top_module_name>
# Example: ./synth.sh decoder
# Assumes verilog/<top_module_name>.v exists in the current design root
# (run from /foss/designs/monitor-ic)

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <top_module_name>"
    exit 1
fi

TOP=$1

LIB_FILE="/foss/pdks/ciel/gf180mcu/versions/8f2d1529c86235d726979eb9ecb7e9628108590b/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/lib/gf180mcu_fd_sc_mcu7t5v0__tt_025C_3v30.lib"

if [ ! -f "$LIB_FILE" ]; then
    echo "ERROR: Liberty file not found at:"
    echo "  $LIB_FILE"
    echo "Ciel's versioned hash directory may have changed — re-run the find command to confirm the path."
    exit 1
fi

if [ ! -f "verilog/${TOP}.v" ]; then
    echo "ERROR: verilog/${TOP}.v not found"
    exit 1
fi

mkdir -p netlist/nl

yosys -p "
read_verilog -I verilog verilog/${TOP}.v
synth -top ${TOP}
dfflibmap -liberty ${LIB_FILE}
abc -liberty ${LIB_FILE}
clean
write_verilog netlist/nl/${TOP}.nl.v
"

echo ""
echo "Done. Gate-level netlist written to netlist/nl/${TOP}.nl.v"
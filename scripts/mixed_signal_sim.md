# Preparing Verilog files for mixed signal simulation
For sake of clarity, I'll be running this with `decoder.v` as an example. Applies the same to other Verilog files, but note that they should have a similar logic to `decoder.v`.

> [!NOTE]
> Running `vlog2Verilog` directly on a file that contains `include "monitor_misc.v"` (or any macro-only include) can segfault the tool outright, rather than erroring cleanly. 

All commands assume you're working inside the IIC-OSIC-TOOLS container (noVNC desktop).

0. Install the `/scripts` folder in this repository (contains `synth.sh` and `spi2xspice.py`).

1. Check if the files come back clean (optional).
```
iverilog -tnull -I. decoder.v
```
2. Synthesis with Yosys:

```
cd /foss/designs/monitor-ic
chmod +x scripts/synth.sh
./scripts/synth.sh decoder
```

Confirm each .nl.v file contains real gate instantiations, not just dangling wires. If it comes out
empty or black-boxed, the top module name passed to synth.sh doesn't match the module name inside the .v file, or the file wasn't picked up.

3. Running with qflow:
```
mkdir xspice
vlog2Verilog netlist/nl/decoder.nl.v > xspice/decoder.vp
```

4. 
```
cd xspice
vlog2Spice decoder.vp > decoder.spice
```
> [!WARNING]
> `vlog2Verilog` only understands structural Verilog, not assign/behavioral statements. On raw RTL it won't error, it'll silently emit an empty black-box stub. This is why synthesis (step 2) is not optional.

You'll likely see warnings like:

```
Warning: No SPICE subcircuit for gf180mcu_fd_sc_mcu7t5v0__clkinv_1. Pin order will be arbitrary.
```

These are expected. `vlog2Spice` lacks transistor-level models for these cells, which is fine since we're heading to XSPICE. Just confirm the gate instances are still present in `decoder.spice` (the warning means pin order isn't guaranteed, not that the cell was dropped) before continuing.


5. 
```
python3 ../scripts/spi2xspice.py -vdd=3.3 /foss/pdks/ciel/gf180mcu/versions/8f2d1529c86235d726979eb9ecb7e9628108590b/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/lib/gf180mcu_fd_sc_mcu7t5v0__tt_025C_3v30.lib decoder.spice decoder.xspice
```

## Inside Xschem
1. Check the port order in the `.xspice` file before building the symbol:
```
   grep -A2 "^.subckt" decoder.xspice
```
2. Build the Xschem symbols by `File → New Symbol`
3. Check each `.xspice` file's port order 
```
grep -A2 "^.subckt" decoder.xspice
```
3. Place pins in the same exact order as the aforementioned `.subckt` line.  Example, for `window_detector.v`: `comp_low`, `comp_high`, `in_window alert_set`, `alert_reset`

4. `Right-click → Properties` on the symbol placed in a schematic, or edit the `.sym` text directly:
```
value="XSPICE model here"
spice_ignore=false
format="@name @pinlist @symname"
```
5. In the top-level testbench schematic, add:
```
include xspice/decoder.xspice
```
then reference the subcircuit by name from the schematic.


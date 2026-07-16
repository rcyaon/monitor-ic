# Preparing Verilog files for mixed signal simulation
For sake of clarity, I'll be running this with `decoder.v` as an example.

0. Install the `scripts` folder in this repository.

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
5. 
```
cd ../scripts
python3 spi2xspice.py -vdd=3.3 /foss/pdks/ciel/gf180mcu/versions/8f2d1529c86235d726979eb9ecb7e9628108590b/gf180mcuD/libs.ref/gf180mcu_fd_sc_mcu7t5v0/lib/gf180mcu_fd_sc_mcu7t5v0__tt_025C_3v30.lib ../xspice/decoder.spice decoder.xspice
```

## Inside Xschem
1. Check port order inside of the `.xspice` files
2. Build the Xschem symbols by `File → New Symbol`
3. Check each `.xspice` file's port order 
```
grep -A2 "^.subckt" decoder.xspice
```
3. Place pins in the same exact order as the aforementioned `.subckt` line
    
    a. For example, `window_detector.v`: `comp_low` `comp_high` `in_window alert_set` `alert_reset`

4. `Right-click → Properties` on the symbol placed in a schematic, or edit the `.sym` text directly
```
value="XSPICE model here"
spice_ignore=false
format="@name @pinlist @symname"
```
5. Place a `include xspice/decoder.xspice` line in top testbench schematic, then reference the subcircuit by name
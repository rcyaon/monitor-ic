## About
IC monitors a water-quality sensor and generates an alert when the measured conductivity moves outside a desired range. The purpose is to provide a simple, low-power interface between a conductivity sensor and a digital monitoring system.

## Architecture 

```
monitor_ic/
├── README.md
├── simulations/
│   ├── conductivity_sweep.spice
│   ├── monte_carlo.spice
│   ├── corner_analysis.spice
│   └── transient_response.spice
├── sensor_models/
│   ├── conductivity_probe.spice
│   ├── contamination_cases.spice
│   └── temperature_variation.spice
├── schematics/
│   ├── top_level/
│   │   └── water_quality_monitor.sch
│   ├── reference/
│   │   ├── bandgap_reference.sch
│   │   └── bias_generator.sch
│   └── blocks/
│       ├── current_source.sch
│       ├── sensor_buffer.sch
│       ├── programmable_gain_amp.sch
│       ├── switched-resistors.sch
│       ├── strongarm.sch
│       ├── comparator_low.sch
│       ├── comparator_high.sch
│       ├── sr_latch.sch
│       ├── alert_logic.sch
│       └── output_driver.sch
├── verilog/
│   ├── decoder.v
│   ├── window_detector.v
│   ├── t_gate_driver.v
│   └── monitor_misc.v
├── layout/
│   ├── current_source/
│   ├── pga/
│   ├── comparator/
│   ├── bandgap/
│   ├── digital/
│   └── top_level/
└── testbenches/
    ├── tb_current_source.sch
    ├── tb_pga.sch
    ├── tb_comparator.sch
    ├── tb_window_detector.sch
    └── tb_top_level.sch
```


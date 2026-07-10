## About
Enable autonomous, low-power environmental monitoring nodes that detect contamination, salinity changes, or abnormal conductivity without requiring continuous ADC sampling or cloud processing.

## Architecture 

```
water_quality_monitor_ic/
├── README.md
├── docs/
│   ├── project_overview.pdf
│   ├── architecture.png
│   └── specifications.md
│
├── simulations/
│   ├── conductivity_sweep.spice
│   ├── monte_carlo.spice
│   ├── corner_analysis.spice
│   └── transient_response.spice
│
├── schematics/
│   ├── top_level/
│   │   └── water_quality_monitor.sch
│   │
│   ├── reference/
│   │   ├── bandgap_reference.sch
│   │   └── bias_generator.sch
│   │
│   ├── analog/
│   │   ├── current_source.sch
│   │   ├── sensor_buffer.sch
│   │   ├── programmable_gain_amp.sch
│   │   ├── comparator_low.sch
│   │   └── comparator_high.sch
│   │
│   └── digital/
│       ├── sr_latch.sch
│       ├── alert_logic.sch
│       └── output_driver.sch
│
├── layout/
│   ├── current_source/
│   ├── pga/
│   ├── comparator/
│   ├── bandgap/
│   ├── digital/
│   └── top_level/
│
├── testbenches/
│   ├── tb_current_source.sch
│   ├── tb_pga.sch
│   ├── tb_comparator.sch
│   ├── tb_window_detector.sch
│   └── tb_top_level.sch
│
└── sensor_models/
    ├── conductivity_probe.spice
    ├── contamination_cases.spice
    └── temperature_variation.spice
```

### Blocks to design
* Bandgap / Voltage Reference
* Bias Generator
* Precision Current Source
* Sensor Buffer
* Programmable Gain Amplifier (PGA)
* Low Threshold Comparator
* High Threshold Comparator
* Window Detector Logic
* SR Latch
* Output Driver

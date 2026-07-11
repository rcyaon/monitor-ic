## About
IC monitoring a water-quality sensor and generates an alert when the measured conductivity moves outside a desired range. The purpose is to provide a simple, low-power interface between a conductivity sensor and a digital monitoring system.

## Architecture 

```
water_quality_monitor_ic/
├── README.md
├── simulations/
│   ├── conductivity_sweep.spice
│   ├── monte_carlo.spice
│   ├── corner_analysis.spice
│   └── transient_response.spice
├── schematics/
│   ├── top_level/
│   │   └── water_quality_monitor.sch
│   ├── reference/
│   │   ├── bandgap_reference.sch
│   │   └── bias_generator.sch
│   ├── analog/
│   │   ├── current_source.sch
│   │   ├── sensor_buffer.sch
│   │   ├── programmable_gain_amp.sch
│   │   ├── comparator_low.sch
│   │   └── comparator_high.sch
│   └── digital/
│       ├── sr_latch.sch
│       ├── alert_logic.sch
│       └── output_driver.sch
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

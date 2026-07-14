//========================================================================
// monitor-misc
//========================================================================

`ifndef MONITOR_MISC_V
`define MONITOR_MISC_V

//------------------------------------------------------------------------
// WATER_QUALITY_MONITOR_UNUSED
//------------------------------------------------------------------------
`define MONITOR_UNUSED( signal_ )
  logic [$bits(signal_)-1:0] \signal_``_unused ;
  assign \signal_``_unused = signal_;
  if (1)

//------------------------------------------------------------------------
// WATER_QUALITY_MONITOR_UNDRIVEN
//------------------------------------------------------------------------
`define MONITOR_UNDRIVEN( signal_ )
  assign signal_ = 'z;
  if (1)

`endif /* MONITOR_MISC_V */
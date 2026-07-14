module window_detector (
    input  wire comp_low,     // 1 = above low threshold
    input  wire comp_high,    // 1 = below high threshold
    output wire in_window,    // 1 = measured value inside safe window
    output wire alert_set,    // pulses/level high on out-of-window -> SR latch SET
    output wire alert_reset   // level high when back in-window -> SR latch RESET (if auto-clear wanted)
);

    assign in_window   = comp_low & comp_high;
    assign alert_set    = ~in_window;
    assign alert_reset  = in_window;

    // For a latch-until-ack alert instead of auto-clear:
    //   assign alert_reset = in_window & ext_ack;

endmodule
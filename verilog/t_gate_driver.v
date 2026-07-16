//========================================================================
// transmission gate driver
//========================================================================

`ifndef T_GATE_DRIVER_V
`define T_GATE_DRIVER_V

module t_gate_driver (
    input  wire sN_n,
    output wire nmos_gate,
    output wire pmos_gate
);

    assign nmos_gate = sN_n;
    assign pmos_gate = ~sN_n;

endmodule

`endif /* T_GATE_DRIVER_V */
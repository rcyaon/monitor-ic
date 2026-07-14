//========================================================================
// decoder
//========================================================================

`ifndef DECODER_V
`define DECODER_V

`include "monitor_misc.v"

module decoder (
    input  wire       en,
    input  wire [1:0] gain_sel,
    output wire       s1_n,
    output wire       s2_n,   
    output wire       s3_n,   
    output wire       s4_n 
);

    wire [3:0] one_hot;

    assign one_hot[0] = (gain_sel == 2'b00);
    assign one_hot[1] = (gain_sel == 2'b01);
    assign one_hot[2] = (gain_sel == 2'b10);
    assign one_hot[3] = (gain_sel == 2'b11);

    assign s1_n = en & one_hot[0];
    assign s2_n = en & one_hot[1];
    assign s3_n = en & one_hot[2];
    assign s4_n = en & one_hot[3];

endmodule

`endif /* DECODER_V */
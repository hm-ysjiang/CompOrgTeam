
`timescale 1ns/1ps

module IF_ID(
    input           	 clk_i,
	input           	 rst_i,
    input       [31:0]   PC,
	input       [31:0]   INSTR,
    output wire [31:0]   PC_O,
    output wire [31:0]   INSTR_O
    );

    assign PC_O = PC;
    assign INSTR_O = INSTR;


endmodule

`timescale 1ns/1ps

module MEM_WB(
    input           	 clk_i,
	input           	 rst_i,
    input                REG_WRITE,
    input                MEM_TO_REG,
    input       [31:0]   READ_DATA,
    input       [31:0]   ALU_RESULT,

    output wire          REG_WRITE_O,
    output wire          MEM_TO_REG_O,
    output wire [31:0]   READ_DATA_O,
    output wire [31:0]   ALU_RESULT_O
    );

    assign REG_WRITE_O = REG_WRITE;
    assign MEM_TO_REG_O = MEM_TO_REG;
    assign READ_DATA_O = READ_DATA;
    assign ALU_RESULT_O = ALU_RESULT;


endmodule
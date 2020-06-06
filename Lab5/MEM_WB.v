
`timescale 1ns/1ps

module MEM_WB(
    input           	 clk_i,
	input           	 rst_i,
    input                MEM_WB__REG_WRITE,
    input                MEM_WB__MEM_TO_REG,
    input       [31:0]   MEM_WB__READ_DATA,
    input       [31:0]   MEM_WB__ALU_RESULT,

    output wire          MEM_WB__REG_WRITE_O,
    output wire          MEM_WB__MEM_TO_REG_O,
    output wire [31:0]   MEM_WB__READ_DATA_O,
    output wire [31:0]   MEM_WB__ALU_RESULT_O,
    );

    assign MEM_WB__REG_WRITE_O = MEM_WB__REG_WRITE;
    assign MEM_WB__MEM_TO_REG_O = MEM_WB__MEM_TO_REG;
    assign MEM_WB__READ_DATA_O = MEM_WB__READ_DATA;
    assign MEM_WB__ALU_RESULT_O = MEM_WB__ALU_RESULT;


endmodule
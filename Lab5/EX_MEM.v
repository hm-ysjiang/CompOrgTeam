
`timescale 1ns/1ps

module EX_MEM(
    input           	 clk_i,
	input           	 rst_i,
    input                EX_MEM__REG_WRITE,
    input                EX_MEM__MEM_TO_REG,
    input                EX_MEM__MEMREAD,
    input                EX_MEM__MEMWRITE,
    input       [31:0]   EX_MEM__PC_JUMP,
    input                EX_MEM__ZERO,
    input                EX_MEM__ALU_RESULT,
    input       [31:0]	 EX_MEM__WRITE_DATA,
    input       [4:0]	 EX_MEM__RD,

    output wire          EX_MEM__REG_WRITE_O,
    output wire          EX_MEM__MEM_TO_REG_O,
    output wire          EX_MEM__MEMREAD_O,
    output wire          EX_MEM__MEMWRITE_O,
    output wire [31:0]   EX_MEM__PC_JUMP_O,
    output wire          EX_MEM__ZERO_O,
    output wire          EX_MEM__ALU_RESULT_O,
    output wire [31:0]	 EX_MEM__WRITE_DATA_O,
    output wire [4:0]	 EX_MEM__RD_O
    );

    assign EX_MEM__REG_WRITE_O = EX_MEM__REG_WRITE;
    assign EX_MEM__MEM_TO_REG_O = EX_MEM__MEM_TO_REG;
    assign EX_MEM__MEMREAD_O = EX_MEM__MEMREAD;
    assign EX_MEM__MEMWRITE_O = EX_MEM__MEMWRITE;
    assign EX_MEM__PC_JUMP_O = EX_MEM__PC_JUMP;
    assign EX_MEM__ZERO_O = EX_MEM__ZERO;
    assign EX_MEM__ALU_RESULT_O = EX_MEM__ALU_RESULT;
    assign EX_MEM__WRITE_DATA_O = EX_MEM__WRITE_DATA;
    assign EX_MEM__RD_O = EX_MEM__RD;

endmodule
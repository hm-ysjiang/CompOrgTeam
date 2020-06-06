
`timescale 1ns/1ps

module EX_MEM(
    input           	 clk_i,
	input           	 rst_i,
    input                REG_WRITE,
    input                MEM_TO_REG,
    input                MEMREAD,
    input                MEMWRITE,
    input       [31:0]   PC_JUMP,
    input                ZERO,
    input                ALU_RESULT,
    input       [31:0]	 WRITE_DATA,
    input       [4:0]	 RD,

    output wire          REG_WRITE_O,
    output wire          MEM_TO_REG_O,
    output wire          MEMREAD_O,
    output wire          MEMWRITE_O,
    output wire [31:0]   PC_JUMP_O,
    output wire          ZERO_O,
    output wire          ALU_RESULT_O,
    output wire [31:0]	 WRITE_DATA_O,
    output wire [4:0]	 RD_O
    );

    assign REG_WRITE_O = REG_WRITE;
    assign MEM_TO_REG_O = MEM_TO_REG;
    assign MEMREAD_O = MEMREAD;
    assign MEMWRITE_O = MEMWRITE;
    assign PC_JUMP_O = PC_JUMP;
    assign ZERO_O = ZERO;
    assign ALU_RESULT_O = ALU_RESULT;
    assign WRITE_DATA_O = WRITE_DATA;
    assign RD_O = RD;

endmodule
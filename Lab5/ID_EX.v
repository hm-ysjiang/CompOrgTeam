
`timescale 1ns/1ps

module ID_EX(
    input           	 clk_i,
	input           	 rst_i,
    
    input                REG_WRITE,
    input                MEM_TO_REG,
    input                MEMREAD,
    input                MEMWRITE,
    input                ALU_SRC,
    input       [1:0] 	 ALU_OP,
    input       [31:0]   PC,
    input       [31:0]   DATA1,
    input       [31:0]   DATA2,
    input       [31:0]   IMM,
    input       [4:0]    RS1,
    input       [4:0]    RS2,
    input       [4:0]    RD,

    output wire          REG_WRITE_O,
    output wire          MEM_TO_REG_O,
    output wire          MEMREAD_O,
    output wire          MEMWRITE_O,
    output wire          ALU_SRC_O,
    output wire [1:0] 	 ALU_OP_O,
    output wire [31:0]   PC_O,
    output wire [31:0]   DATA1_O,
    output wire [31:0]   DATA2_O,
    output wire [31:0]   IMM_O,
    output wire [4:0]    RS1_O,
    output wire [4:0]    RS2_O,
    output wire [4:0]    RD_O
    );

    assign REG_WRITE_O = rst_i & REG_WRITE;
    assign MEM_TO_REG_O = rst_i & MEM_TO_REG;
    assign MEMREAD_O = rst_i & MEMREAD;
    assign MEMWRITE_O = rst_i & MEMWRITE;
    assign ALU_SRC_O = rst_i & ALU_SRC;
    assign ALU_OP_O = rst_i & ALU_OP;
    assign PC_O = rst_i & PC;
    assign DATA1_O = rst_i & DATA1;
    assign DATA2_O = rst_i & DATA2;
    assign IMM_O = rst_i & IMM;
    assign RS1_O = rst_i & RS1;
    assign RS2_O = rst_i & RS2;
    assign RD_O = rst_i & RD;


endmodule
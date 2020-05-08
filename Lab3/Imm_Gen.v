/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

	wire	[7-1:0]		opcode;
	wire	[3-1:0]		funct3;
	assign opcode = instr_i[6:0];
	assign funct3 = instr_i[14:12];

	assign Imm_Gen_o = 	(opcode == 7'b0010011 || opcode == 7'b0000011 || (opcode == 7'b1100111 && funct3 == 3'b000))? 	{{20{instr_i[31]}}, instr_i[31:20]}: (
						(opcode == 7'b0100011)																		?	{{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]}: (
						(opcode == 7'b1100011)																		?	{{20{instr_i[31]}}, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8]}: (
						(opcode == 7'b0110111 || opcode == 7'b0010111)												?	{instr_i[31:12], 12'b0}: (
						(opcode == 7'b1101111)																		?	{{12{instr_i[31]}}, instr_i[31], instr_i[19:12], instr_i[20], instr_i[30:21]}:(
																														32'b0)))));

endmodule
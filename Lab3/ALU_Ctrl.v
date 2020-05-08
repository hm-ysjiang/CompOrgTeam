/***************************************************
Student Name: Wei-Jie Huang
Student ID: 0716222
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,	// instrucion[30, 14-12]
	input	[2-1:0]	ALUOp,
	output	[4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */

assign	ALU_Ctrl_o = (ALUOp==2'b00)?			4'b0010:(		// ld, sd
					 (ALUOp==2'b01)?			4'b0110:(		// b-type
					 (instr[3:0]==4'b0000)?		4'b0010:(		// add
					 (instr[3:0]==4'b0001)?		4'b0100:(		// sll
					 (instr[3:0]==4'b0010)?		4'b0111:(		// slt
					 (instr[3:0]==4'b0100)?		4'b0011:(		// xor
					 (instr[3:0]==4'b0110)?		4'b0001:(		// or
					 (instr[3:0]==4'b0111)?		4'b0000:(		// and
					 (instr[3:0]==4'b1000)?		4'b0110:(		// sub
					 (instr[3:0]==4'b1101)?		4'b0101:(		// sra
					 							0))))))))))		// else


endmodule
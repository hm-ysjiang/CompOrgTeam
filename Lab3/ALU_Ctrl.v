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
					 (ALUOp[0]==1'b1)?			4'b0110:(		// beq
					 (instr[3:0]==4'b0000)?		4'b0010:(		// add
					 (instr[2:0]==3'b000)?		4'b0110:( 		// subtract
					 (instr[0]==1'b1)?			4'b0000:(		// and
												4'b0001)))))	// or


endmodule
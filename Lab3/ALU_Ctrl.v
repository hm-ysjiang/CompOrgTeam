/***************************************************
Student Name: Wei-Jie Huang
Student ID: 0716222
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,	// instrucion[30, 14-12]
	input	[2-1:0]	ALUOp,
	input	[3-1:0]	TYPE,
	output	[4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */

assign	ALU_Ctrl_o = (ALUOp==2'b00)?						4'b0010:(		// ld, sd
					 (ALUOp==2'b01 && instr[0]==1'b0)?		4'b0110:(		// beq
					 (ALUOp==2'b01 && instr[0]==1'b1)?		4'b1110:(		// bne
					 (instr[3:0]==4'b1000 && TYPE==1)?		4'b0110:(		// sub
					 (instr[3:0]==4'bx000)?					4'b0010:(		// add, addi
					 (instr[3:0]==4'b0001)?					4'b0100:(		// sll, slli
					 (instr[3:0]==4'bx010)?					4'b0111:(		// slt, slti
					 (instr[3:0]==4'b0100)?					4'b0011:(		// xor
					 (instr[3:0]==4'bx110)?					4'b0001:(		// or, ori
					 (instr[3:0]==4'bx111)?					4'b0000:(		// and, andi
					 (instr[3:0]==4'bx101)?					4'b0101:(		// sra, srai
															4'b0)))))))))));// else

endmodule
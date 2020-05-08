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

	assign ALU_Ctrl_o = (ALUOp==2'b00)?							4'b0010:(		// ld, sd
						(ALUOp==2'b01 && instr[0]==1'b0)?		4'b0110:(		// beq
						(ALUOp==2'b01 && instr[0]==1'b1)?		4'b1110:(		// bne
						(instr[3:0]==4'b1000 && TYPE==0)?		4'b0110:(		// sub
						(instr[2:0]==3'b000)?					4'b0010:(		// add, addi
						(instr[3:0]==4'b0001)?					4'b0100:(		// sll, slli
						(instr[2:0]==3'b010)?					4'b0111:(		// slt, slti
						(instr[3:0]==4'b0100)?					4'b0011:(		// xor
						(instr[2:0]==3'b110)?					4'b0001:(		// or, ori
						(instr[2:0]==3'b111)?					4'b0000:(		// and, andi
						(instr[2:0]==3'b101)?					4'b0101:(		// sra, srai
																4'b0)))))))))));// else
	
	// always @ (*) begin
	// 				$display("instr = %4b, ALUOp = %2b, TYPE = %3b, ALUctrl = %4b\n",
	//           instr, ALUOp, TYPE, ALU_Ctrl_o
	// 		  );
	// end

endmodule
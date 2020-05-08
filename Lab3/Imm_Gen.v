/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

	reg		[31:0]		temp;

	wire	[7-1:0]		opcode;
	wire	[3-1:0]		funct3;
	assign opcode = instr_i[6:0];
	assign funct3 = instr_i[14:12];
	assign Imm_Gen = temp;

	always @ (*) begin
		// R-type
		if (opcode == 7'b0110011) begin
			temp = 32'b0;
		end

		// I-type
		if (opcode == 7'b0010011) begin
			temp[11:0]  = instr_i[31:20];
			temp[31:12] = {20{instr_i[31]}};
		end
		// I-type (LW)
		if (opcode == 7'b0000011) begin
			temp[11:0]  = instr_i[31:20];
			temp[31:12] = {20{instr_i[31]}};
		end
		// I-type (JALR)
		if (opcode == 7'b1100111 && funct3 == 3'b000) begin
			temp[11:0]  = instr_i[31:20];
			temp[31:12] = {20{instr_i[31]}};
		end

		// S-type
		if (opcode == 7'b0100011) begin
			temp[4:0]   = instr_i[11:7];
			temp[11:5]  = instr_i[31:25];
			temp[31:12] = {20{instr_i[31]}};
		end

		// B-type
		if (opcode == 7'b1100011) begin
			temp[3:0]   = instr_i[11:8];
			temp[9:4]   = instr_i[30:25];
			temp[10]    = instr_i[7];
			temp[11]    = instr_i[31];
			temp[31:12] = {20{instr_i[31]}};
		end

		// U-type (LUI)
		if (opcode == 7'b0110111) begin
			temp[11:0]  = 12'b0;
			temp[31:12] = instr_i[31:12];
		end
		// U-type (AUIPC)
		if (opcode == 7'b0010111) begin
			temp[11:0]  = 12'b0;
			temp[31:12] = instr_i[31:12];
		end

		// J-type (JAL)
		if (opcode == 7'b1101111) begin
			temp[9:0]  = instr_i[30:21];
			temp[10]    = instr_i[20];
			temp[18:11] = instr_i[19:12];
			temp[19]    = instr_i[31];
			temp[31:20] = {12{instr_i[31]}};
		end
	end

endmodule
/***************************************************
Student Name: 黃偉傑、江岳勳
Student ID: 0716222、0716214
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [32-1:0] 	instr_i,
	output wire			ALUSrc,
	output wire			RegWrite,
	output wire			Branch,
	output wire [2-1:0]	ALUOp
	);
	
	//Internal Signals
	wire	[7-1:0]		opcode;
	wire 	[3-1:0]		funct3;
	wire	[9-1:0]		Ctrl_o;
	wire	[3-1:0]		Instr_field;

	assign opcode = instr_i[6:0];
	assign funct3 = instr_i[14:12];

	// Check Instr. Field
	// 0:R-type, 1:I-type, 2:S-type, 3:B-type					 
	assign Instr_field= (opcode==7'b1100011)?3:(
						(opcode==7'b0100011)?2:((
						(opcode==7'b1100111 && funct3==3'b000) ||	//JALR
						(opcode==7'b0010011 && funct3==3'b000) ||	//ADDI
						(opcode==7'b0010011 && funct3==3'b010) ||	//SLTI
						(opcode==7'b0010011 && funct3==3'b100) ||	//XORI
						(opcode==7'b0010011 && funct3==3'b110) ||	//ORI
						(opcode==7'b0010011 && funct3==3'b111))?1:(//ANDI
						(opcode==7'b0110011)?0:
						1)));
						
	assign Ctrl_o = (Instr_field==0 && opcode[5]==0)?9'b010100010:(
					(Instr_field==0)?9'b000100010:(
					(Instr_field==1 && opcode==7'b0000011)?9'b011110000:( //LW
					(Instr_field==1)?9'b010100010:(
					(Instr_field==2)?9'b010001000:(
					(Instr_field==3)?9'b000000101:(
					0))))));
					
	assign ALUSrc 	= Ctrl_o[7];
	assign RegWrite = Ctrl_o[5];
	assign Branch	= Ctrl_o[2];
	assign ALUOp 	= (Instr_field==1 && opcode!=7'b0000011)?2'b11:{Ctrl_o[1:0]};
	// always @ (*) begin
	// 	$display("Instr_field = %1d, ALUOp = %2b\n",
	//         Instr_field, ALUOp
	// 	);
	// end

endmodule





                    
                    
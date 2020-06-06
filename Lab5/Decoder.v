/***************************************************
Student Name: 黃偉傑、江岳勳
Student ID: 0716222、0716214
***************************************************/

`timescale 1ns/1ps

module Decoder(
	input [31:0] 	instr_i,
	output          ALUSrc,
	output          MemtoReg,
	output          RegWrite,
	output          MemRead,
	output          MemWrite,
	output          Branch,
	output [1:0]	ALUOp,
	output [1:0]	Jump
	);
	
	//Internal Signals
	wire	[7-1:0]		opcode;
	wire 	[3-1:0]		funct3;
	wire	[14-1:0]	Ctrl_o;
	wire	[3-1:0]		Instr_field;

	assign opcode = instr_i[6:0];
	assign funct3 = instr_i[14:12];

	// Check Instr. Field
	// 0:R-type, 1:I-type, 2:S-type, 3:B-type, 4:J-type
	assign Instr_field= (opcode==7'b1100011)?3:(
						(opcode==7'b0100011)?2:((
						(opcode==7'b1100111 && funct3==3'b000) ||	//JALR
						(opcode==7'b0010011 && funct3==3'b000) ||	//ADDI
						(opcode==7'b0010011 && funct3==3'b010) ||	//SLTI
						(opcode==7'b0010011 && funct3==3'b100) ||	//XORI
						(opcode==7'b0010011 && funct3==3'b110) ||	//ORI
						(opcode==7'b0010011 && funct3==3'b111))?1:( //ANDI
						(opcode==7'b1101111)?4:(					//JAL
						(opcode==7'b0110011)?0:						//R-type
						1))));
						
	assign Ctrl_o = (Instr_field==0)?						14'b01000000100010:(
					(Instr_field==1 && opcode==7'b0000011)? 14'b11100011110000:( //LW
					(Instr_field==1 && opcode==7'b1100111)?	14'b01001010100011:( //JALR
					(Instr_field==1)?						14'b01000010100011:(
					(Instr_field==2)?						14'b00010010001000:(
					(Instr_field==3)?						14'b00000000000101:(
					(Instr_field==4)?						14'b01000100100000:(
					0)))))));
					
	assign MemtoReg = Ctrl_o[13];
	assign RegWrite = Ctrl_o[12];
	assign MemRead 	= Ctrl_o[11];
	assign MemWrite = Ctrl_o[10];
	assign Jump 	= Ctrl_o[9:8];

	assign ALUSrc 	= Ctrl_o[7];
	assign Branch	= Ctrl_o[2];
	assign ALUOp 	= {Ctrl_o[1:0]};
	// always @ (*) begin
	// 	$display("Instr_field = %1d, ALUOp = %2b\n",
	//         Instr_field, ALUOp
	// 	);
	// end

endmodule





                    
                    
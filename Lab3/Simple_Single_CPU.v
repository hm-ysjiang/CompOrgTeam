/***************************************************
Student Name: 黃偉傑、江岳勳
Student ID: 0716222、0716214
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

	wire [31:0] pc_i;
	wire [31:0] pc_o;
	wire [31:0] instr;
	wire [31:0] ALUresult;
	wire RegWrite;
	wire [31:0] RSdata_o;
	wire [31:0] RTdata_o;
	wire ALUSrc;
	wire Branch;
	wire [1:0] ALUOp;

	wire [31:0] PC_PLUS4;
	wire [31:0] IMM;
	wire [31:0] IMM_SHIFT1;
	wire [31:0] ALU_SRC2;
	wire [3:0]  ALU_CTRL;
	wire [31:0] PC_JUMP;
	wire 		ZERO;
	wire 		OVERFLOW;
	wire 		COUT;
	wire 		PC_SRC;

	assign PC_SRC = (instr[12] == 1'b0 ? ZERO : ~ZERO) & Branch;

			
	ProgramCounter PC(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.pc_i(pc_i),
			.pc_o(pc_o)
			);

	Instr_Memory IM(
			.addr_i(pc_o),
			.instr_o(instr)
			);
			
	Reg_File RF(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.RSaddr_i(instr[19:15]),
			.RTaddr_i(instr[24:20]),
			.RDaddr_i(instr[11:7]),
			.RDdata_i(ALUresult),
			.RegWrite_i(RegWrite),
			.RSdata_o(RSdata_o),
			.RTdata_o(RTdata_o)
			);
			
	Decoder Decoder(
			.instr_i(instr),
			.ALUSrc(ALUSrc),
			.RegWrite(RegWrite),
			.Branch(Branch),
			.ALUOp(ALUOp)
			);	

	// PC + 4
	Adder Adder1(
			.src1_i(pc_o),
			.src2_i(4),
			.sum_o(PC_PLUS4)
			);
			
	Imm_Gen ImmGen(
			.instr_i(instr),
			.Imm_Gen_o(IMM)
			);
		
	Shift_Left_1 SL1(
			.data_i(IMM),
			.data_o(IMM_SHIFT1)
			);
		
	MUX_2to1 Mux_ALUSrc(
			.data0_i(RTdata_o),
			.data1_i(IMM),
			.select_i(ALUSrc),
			.data_o(ALU_SRC2)
			);
				
	ALU_Ctrl ALU_Ctrl(
			.instr({instr[30],instr[14:12]}),
			.ALUOp(ALUOp),
			.ALU_Ctrl_o(ALU_CTRL)
			);
			
	Adder Adder2(
			.src1_i(pc_o),
			.src2_i(IMM_SHIFT1),
			.sum_o(PC_JUMP)
			);
			
	alu alu(
			.rst_n(rst_i),
			.src1(RSdata_o),
			.src2(ALU_SRC2),
			.ALU_control(ALU_CTRL),
			.zero(ZERO),
			.result(ALUresult),
			.cout(COUT),
			.overflow(OVERFLOW)
			);

	MUX_2to1 Mux_PCSrc(
			.data0_i(PC_PLUS4),
			.data1_i(PC_JUMP),
			.select_i(PC_SRC),
			.data_o(pc_i)
			);

endmodule
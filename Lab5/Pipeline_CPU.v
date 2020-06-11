/***************************************************
Student Name: 黃偉傑、江岳勳
Student ID: 0716222、0716214
***************************************************/

`timescale 1ns/1ps
module Pipeline_CPU(
	input clk_i,
	input rst_i
	);

	///////////////////////////////////////////////IF
	wire [31:0] pc_i;
	wire [31:0] pc_o;
	wire [31:0] PC_PLUS4;
	wire [31:0] instr;

	assign pc_i = PC_PLUS4;
	///////////////////////////////////////////////IF
	wire [31:0] INSTR_ID;
	///////////////////////////////////////////////ID
	wire [31:0] RSdata_o;
	wire [31:0] RTdata_o;

	wire		ALUSrc;
	wire		Branch;
	wire [ 1:0]	Jump;
	wire      	MemtoReg;
	wire      	RegWrite;
	wire      	MemRead;
	wire      	MemWrite;

	wire [ 1:0] ALUOp;
	wire [ 3:0] ALU_CTRL;

	wire [31:0] IMM;

	wire [31:0] RSdata_o_ICCTRFSIPTH;
	wire [31:0] RTdata_o_ICCTRFSIPTH;
	///////////////////////////////////////////////ID
	wire 		RegWrite_EX;
	wire		ALUSrc_EX;
	wire [ 3:0] ALU_CTRL_EX;
	wire [31:0] RSdata_o_EX;
	wire [31:0] RTdata_o_EX;
	wire [31:0] IMM_EX;
	wire [ 4:0] RS_EX;
	wire [ 4:0] RT_EX;
	wire [ 4:0] RD_EX;
	///////////////////////////////////////////////EX
	wire [31:0] ALU_SRC2;
	wire [31:0] ALUresult;
	wire 		ZERO;
	wire 		OVERFLOW;
	wire 		COUT;
	///////////////////////////////////////////////EX
	wire 		RegWrite_MEM;
	wire [31:0] ALUresult_MEM;
	wire [ 4:0] RD_MEM;

	wire [31:0] RSdata_o_FORWARDED;
	wire [31:0] RTdata_o_FORWARDED;
	wire [ 1:0] FORWARD_SRC1;
	wire [ 1:0] FORWARD_SRC2;
	///////////////////////////////////////////////MEM
	wire [31:0] DM_o;
	///////////////////////////////////////////////MEM
	wire 		RegWrite_WB;
	wire [31:0] ALUresult_WB;
	wire [ 4:0] RD_WB;
	///////////////////////////////////////////////WB

	///////////////////////////////////////////////WB

	/***************************************************/

	////////////////////////////////////////////////////////////////////////////	IF stage

	ProgramCounter PC(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.pc_i(pc_i),
			.pc_o(pc_o)
			);

	// PC + 4
	Adder Adder1(
			.src1_i(pc_o),
			.src2_i(4),
			.sum_o(PC_PLUS4)
			);

	Instr_Memory IM(
			.addr_i(pc_o),
			.instr_o(instr)
			);

	////////////////////////////////////////////////////////////////////////////	IF stage
	IF_ID IF_ID(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.INSTR(instr),
			.INSTR_O(INSTR_ID)
			);
	////////////////////////////////////////////////////////////////////////////	ID stage
	
	Reg_File RF(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.RSaddr_i(INSTR_ID[19:15]),
			.RTaddr_i(INSTR_ID[24:20]),
			.RDaddr_i(INSTR_ID[11:7]),
			.RDdata_i(ALUresult_WB),
			.RegWrite_i(RegWrite_WB),
			.RSdata_o(RSdata_o),
			.RTdata_o(RTdata_o)
			);
			
	Decoder Decoder(
			.instr_i(INSTR_ID),
			.ALUSrc(ALUSrc),
			.MemtoReg(MemtoReg),
			.RegWrite(RegWrite),
			.MemRead(MemRead),
			.MemWrite(MemWrite),
			.Branch(Branch),
			.ALUOp(ALUOp),
			.Jump(Jump)
			);	
			
	Imm_Gen ImmGen(
			.instr_i(INSTR_ID),
			.Imm_Gen_o(IMM)
			);

	ICantChangeTheRegFileSoIPutThisHere_module ICCTRFSIPTH(
			.dataRS_i(RSdata_o),
			.dataRT_i(RTdata_o),
			.data_WB(ALUresult_WB),
			.rs(INSTR_ID[19:15]),
			.rt(INSTR_ID[24:20]),
			.RD_WB(RD_WB),
			.RegWrite_WB(RegWrite_WB),
			.dataRS_o(RSdata_o_ICCTRFSIPTH),
			.dataRT_o(RTdata_o_ICCTRFSIPTH)
	);
				
	ALU_Ctrl ALU_Ctrl(
			.instr({INSTR_ID[30],INSTR_ID[14:12]}),
			.ALUOp(ALUOp),
			.ALU_Ctrl_o(ALU_CTRL)
			);

	////////////////////////////////////////////////////////////////////////////	ID stage
	ID_EX ID_EX(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.REG_WRITE(RegWrite),
			.ALU_SRC(ALUSrc),
			.ALU_CTRL(ALU_CTRL),
			.DATA1(RSdata_o_ICCTRFSIPTH),
			.DATA2(RTdata_o_ICCTRFSIPTH),
			.IMM(IMM),
			.RS(INSTR_ID[19:15]),
			.RT(INSTR_ID[24:20]),
			.RD(INSTR_ID[11:7]),
			.REG_WRITE_O(RegWrite_EX),
			.ALU_SRC_O(ALUSrc_EX),
			.ALU_CTRL_O(ALU_CTRL_EX),
			.DATA1_O(RSdata_o_EX),
			.DATA2_O(RTdata_o_EX),
			.IMM_O(IMM_EX),
			.RS_O(RS_EX),
			.RT_O(RT_EX),
			.RD_O(RD_EX)
			);
	////////////////////////////////////////////////////////////////////////////	EX stage

	MUX_3to1 Mux_ForwardRS(
			.data0_i(RSdata_o_EX),
			.data1_i(ALUresult_MEM),
			.data2_i(ALUresult_WB),
			.select_i(FORWARD_SRC1),
			.data_o(RSdata_o_FORWARDED)
			);

	MUX_3to1 Mux_ForwardRT(
			.data0_i(RTdata_o_EX),
			.data1_i(ALUresult_MEM),
			.data2_i(ALUresult_WB),
			.select_i(FORWARD_SRC2),
			.data_o(RTdata_o_FORWARDED)
			);
		
	MUX_2to1 Mux_ALUSrc(
			.data0_i(RTdata_o_FORWARDED),
			.data1_i(IMM_EX),
			.select_i(ALUSrc_EX),
			.data_o(ALU_SRC2)
			);
			
	alu alu(
			.rst_n(rst_i),
			.src1(RSdata_o_FORWARDED),
			.src2(ALU_SRC2),
			.ALU_control(ALU_CTRL_EX),
			.zero(ZERO),
			.result(ALUresult),
			.cout(COUT),
			.overflow(OVERFLOW)
			);
	
	ForwardingUnit ForwardingUnit(
			.ID_EX__RS1(RS_EX),
			.ID_EX__RS2(RT_EX),
			.EX_MEM__RD(RD_MEM),
			.MEM_WB__RD(RD_WB),
			.EX_MEM__REG_WRITE(RegWrite_MEM),
			.MEM_WB__REG_WRITE(RegWrite_WB),
			.SRC1(FORWARD_SRC1),
			.SRC2(FORWARD_SRC2)
			);
	
	////////////////////////////////////////////////////////////////////////////	EX stage
	EX_MEM EX_MEM(
    		.clk_i(clk_i),
			.rst_i(rst_i),
    		.REG_WRITE(RegWrite_EX),
    		.ALU_RESULT(ALUresult),
    		.RD(RD_EX),
    		.REG_WRITE_O(RegWrite_MEM),
    		.ALU_RESULT_O(ALUresult_MEM),
    		.RD_O(RD_MEM)
			);
	////////////////////////////////////////////////////////////////////////////	MEM stage

	Data_Memory Data_Memory(
			.clk_i(clk_i),
			.addr_i(ALUresult_MEM),
			.data_i(RTdata_o),
			.MemRead_i(1'b0),
			.MemWrite_i(1'b0),
			.data_o(DM_o)
			);

	////////////////////////////////////////////////////////////////////////////	MEM stage
	MEM_WB MEM_WB(
			.clk_i(clk_i),
			.rst_i(rst_i),
			.REG_WRITE(RegWrite_MEM),
			.ALU_RESULT(ALUresult_MEM),
    		.RD(RD_MEM),
			.REG_WRITE_O(RegWrite_WB),
			.ALU_RESULT_O(ALUresult_WB),
    		.RD_O(RD_WB)
			);
	////////////////////////////////////////////////////////////////////////////	WB stage

	////////////////////////////////////////////////////////////////////////////	WB stage




endmodule
/***************************************************
Student Name: 黃偉傑、江岳勳
Student ID: 0716222、0716214
***************************************************/

`timescale 1ns/1ps

module ICantChangeTheRegFileSoIPutThisHere_module(
	input  [31:0] dataRS_i,
	input  [31:0] dataRT_i,
	input  [31:0] data_WB,
	input  [ 4:0] rs,
	input  [ 4:0] rt,
	input  [ 4:0] RD_WB,
	input		  RegWrite_WB,
	output [31:0] dataRS_o,
	output [31:0] dataRT_o
    );		   

	assign dataRS_o = ((RegWrite_WB == 1'b1 && RD_WB == rs) ? data_WB : dataRS_i);
	assign dataRT_o = ((RegWrite_WB == 1'b1 && RD_WB == rt) ? data_WB : dataRT_i);

endmodule      

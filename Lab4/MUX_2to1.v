/***************************************************
Student Name: 黃偉傑、江岳勳
Student ID: 0716222、0716214
***************************************************/

`timescale 1ns/1ps

module MUX_2to1(
	input  [32-1:0] data0_i,       
	input  [32-1:0] data1_i,
	input       	select_i,
	output [32-1:0] data_o
               );

	assign data_o = (select_i == 1'b0) ? data0_i : data1_i;

endmodule      

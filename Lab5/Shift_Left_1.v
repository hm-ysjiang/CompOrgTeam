/***************************************************
Student Name: 黃偉傑、江岳勳
Student ID: 0716222、0716214
***************************************************/

`timescale 1ns/1ps

module Shift_Left_1(
    input  [32-1:0] data_i,
    output [32-1:0] data_o
    );

    assign data_o = {data_i[30:0], 1'b0};

endmodule
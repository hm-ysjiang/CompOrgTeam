/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Shift_Left_1(
    input  [32-1:0] data_i,
    output [32-1:0] data_o
    );

    always @ (*) begin
        data_o = data_i << 1;
    end

endmodule
/***************************************************
Student Name: 黃偉傑、江岳勳
Student ID: 0716222、0716214
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

	// reg [32-1:0] sum;
	// reg [32-1:0] B;

	always @ (*) begin

		case(ALU_control)
			4'b0000: begin // AND
				result = src1 & src2;
			end
			4'b0001: begin // OR
				result = src1 | src2;
			end
			4'b0010: begin // add
				result = src1 + src2;
			end
			4'b0011: begin // xor (user-defined)
				result = src1 ^ src2;
			end
			4'b0100: begin // sll (user-defined)
				result = src1 << src2;
			end

			/* Need more info about sra and srli */
			4'b0101: begin // sra (user-defined)
				result = src1 >>> src2;
			end
			4'b0110: begin // subtract
				result = src1 - src2;
			end
			4'b0111: begin // set less than
				result = (src1 < src2) ? 1 : 0;
			end
			4'b1100: begin // nor
				result = ~(src1 | src2);
			end
			4'b1101: begin // nand
				result = ~(src1 & src2);
			end
			4'b1111: begin // srli (user-defined)
				result = src1 >> src2;
			end
			default: begin
				result = 0;
			end
		endcase

		zero = (result==0) ? 1 : 0;
		// B = (ALU_control[2]==1) ? ~src2 : src2;
		// {cout, sum} = src1 + B;
		// cout = cout & ALU_control[1] & ~ALU_control[0];
		// overflow = (src1[31] ^~ B[31]) & (src1[31] ^ sum[31]) & ALU_control[1] & ~ALU_control[0];

		// $display("src1 = %3d, src2 = %3d, result = %3d, aluctrl = %4b\n",
	    //     src1, src2, result, ALU_control
		// );
	end


endmodule

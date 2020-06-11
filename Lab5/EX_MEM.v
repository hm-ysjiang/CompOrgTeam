
`timescale 1ns/1ps

module EX_MEM(
    input           	 clk_i,
	input           	 rst_i,
    input                REG_WRITE,
    input       [31:0]   ALU_RESULT,
    input       [4:0]	 RD,

    output wire          REG_WRITE_O,
    output wire [31:0]   ALU_RESULT_O,
    output wire [4:0]	 RD_O
    );

    reg                  reg_write;
    reg         [31:0]   alu_result;
    reg         [4:0]    rd;

    assign REG_WRITE_O = reg_write;
    assign ALU_RESULT_O = alu_result;
    assign RD_O = rd;

    always@(posedge clk_i) begin
        if(!rst_i) begin
            reg_write = 0;
            alu_result = 0;
            rd = 0;
        end
        else begin
            reg_write = REG_WRITE;
            alu_result = ALU_RESULT;
            rd = RD;
        end
    end

endmodule
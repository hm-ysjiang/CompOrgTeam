
`timescale 1ns/1ps

module IF_ID(
    input           	 clk_i,
	input           	 rst_i,
    input       [31:0]   PC,
	input       [31:0]   INSTR,
    output wire [31:0]   PC_O,
    output wire [31:0]   INSTR_O
    );

    reg         [31:0]   pc;
    reg         [31:0]   instr;
    assign PC_O = pc;
    assign INSTR_O = instr;

    always@(posedge clk_i) begin
        if(!rst_i) begin
            pc = 0;
            instr = 0;
        end
        else begin
            pc = PC;
            instr = INSTR;
        end
    end



endmodule
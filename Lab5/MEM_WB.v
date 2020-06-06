
`timescale 1ns/1ps

module MEM_WB(
    input           	 clk_i,
	input           	 rst_i,
    input                REG_WRITE,
    input                MEM_TO_REG,
    input       [31:0]   READ_DATA,
    input       [31:0]   ALU_RESULT,

    output wire          REG_WRITE_O,
    output wire          MEM_TO_REG_O,
    output wire [31:0]   READ_DATA_O,
    output wire [31:0]   ALU_RESULT_O
    );

    reg                 reg_write;
    reg                 mem_to_reg;
    reg         [31:0]  read_data;
    reg         [31:0]  alu_result;

    assign REG_WRITE = reg_write;
    assign MEM_TO_REG = mem_to_reg;
    assign READ_DATA = read_data;
    assign ALU_RESULT = alu_result;

    always@(posedge clk_i) begin
        if(!rst_i) begin
            reg_write = 0;
            mem_to_reg = 0;
            memread = 0;
            memwrite = 0;
            pc_jump = 0;
            zero = 0;
            alu_result = 0;
            write_data = 0;
            rd = 0;
        end
        else begin
            reg_write = REG_WRITE;
            mem_to_reg = MEM_TO_REG;
            memread = MEMREAD;
            memwrite = MEMWRITE;
            pc_jump = PC_JUMP;
            zero = ZERO;
            alu_result = ALU_RESULT;
            write_data = WRITE_DATA;
            rd = RD;
        end
    end


endmodule
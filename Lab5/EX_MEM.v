
`timescale 1ns/1ps

module EX_MEM(
    input           	 clk_i,
	input           	 rst_i,
    input                REG_WRITE,
    input                MEM_TO_REG,
    input                MEMREAD,
    input                MEMWRITE,
    input       [31:0]   PC_JUMP,
    input                ZERO,
    input                ALU_RESULT,
    input       [31:0]	 WRITE_DATA,
    input       [4:0]	 RD,

    output wire          REG_WRITE_O,
    output wire          MEM_TO_REG_O,
    output wire          MEMREAD_O,
    output wire          MEMWRITE_O,
    output wire [31:0]   PC_JUMP_O,
    output wire          ZERO_O,
    output wire          ALU_RESULT_O,
    output wire [31:0]	 WRITE_DATA_O,
    output wire [4:0]	 RD_O
    );

    reg                  reg_write;
    reg                  mem_to_reg;
    reg                  memread;
    reg                  memwrite;
    reg         [31:0]   pc_jump;
    reg                  zero;
    reg                  alu_result;
    reg         [31:0]   write_data;
    reg         [4:0]    rd;

    assign REG_WRITE_O = reg_write;
    assign MEM_TO_REG_O = mem_to_reg;
    assign MEMREAD_O = memread;
    assign MEMWRITE_O = memwrite;
    assign PC_JUMP_O = pc_jump;
    assign ZERO_O = zero;
    assign ALU_RESULT_O = alu_result;
    assign WRITE_DATA_O = write_data;
    assign RD_O = rd;

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
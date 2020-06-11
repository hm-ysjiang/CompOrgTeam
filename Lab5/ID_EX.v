
`timescale 1ns/1ps

module ID_EX(
    input           	 clk_i,
	input           	 rst_i,
    
    input                REG_WRITE,
    input                ALU_SRC,
    input       [1:0] 	 ALU_OP,
    input       [31:0]   DATA1,
    input       [31:0]   DATA2,
    input       [31:0]   IMM,
    input       [4:0]    RS,
    input       [4:0]    RT,
    input       [4:0]    RD,

    output wire          REG_WRITE_O,
    output wire          ALU_SRC_O,
    output wire [1:0] 	 ALU_OP_O,
    output wire [31:0]   DATA1_O,
    output wire [31:0]   DATA2_O,
    output wire [31:0]   IMM_O,
    output wire [4:0]    RS_O,
    output wire [4:0]    RT_O,
    output wire [4:0]    RD_O
    );


    reg                  reg_write;
    reg                  alu_src;
    reg         [1:0]    alu_op;
    reg         [31:0]   data1;
    reg         [31:0]   data2;
    reg         [31:0]   imm;
    reg         [4:0]    rs;
    reg         [4:0]    rt;
    reg         [4:0]    rd;

    assign REG_WRITE_O = reg_write;
    assign ALU_SRC_O = alu_src;
    assign ALU_OP_O = alu_op;
    assign DATA1_O = data1;
    assign DATA2_O = data2;
    assign IMM_O = imm;
    assign RS_O = rs;
    assign RT_O = rt;
    assign RD_O = rd;

    always@(posedge clk_i) begin
        if(!rst_i) begin
            reg_write = 0;
            alu_src = 0;
            alu_op = 0;
            data1 = 0;
            data2 = 0;
            imm = 0;
            rs = 0;
            rt = 0;
            rd = 0;
        end
        else begin
            reg_write = REG_WRITE;
            alu_src = ALU_SRC;
            alu_op = ALU_OP;
            data1 = DATA1;
            data2 = DATA2;
            imm = IMM;
            rs = RS;
            rt = RT;
            rd = RD;
        end
    end



endmodule
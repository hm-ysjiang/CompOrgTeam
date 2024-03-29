
`timescale 1ns/1ps

module ID_EX(
    input           	 clk_i,
	input           	 rst_i,
    
    input                REG_WRITE,
    input                ALU_SRC,
    input       [3:0] 	 ALU_CTRL,
    input       [31:0]   DATA1,
    input       [31:0]   DATA2,
    input       [31:0]   IMM,
    input       [4:0]    RS,
    input       [4:0]    RT,
    input       [4:0]    RD,

    output wire          REG_WRITE_O,
    output wire          ALU_SRC_O,
    output wire [3:0] 	 ALU_CTRL_O,
    output wire [31:0]   DATA1_O,
    output wire [31:0]   DATA2_O,
    output wire [31:0]   IMM_O,
    output wire [4:0]    RS_O,
    output wire [4:0]    RT_O,
    output wire [4:0]    RD_O
    );


    reg                  reg_write;
    reg                  alu_src;
    reg         [3:0]    alu_ctrl;
    reg         [31:0]   data1;
    reg         [31:0]   data2;
    reg         [31:0]   imm;
    reg         [4:0]    rs;
    reg         [4:0]    rt;
    reg         [4:0]    rd;

    assign REG_WRITE_O = reg_write;
    assign ALU_SRC_O = alu_src;
    assign ALU_CTRL_O = alu_ctrl;
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
            alu_ctrl = 0;
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
            alu_ctrl = ALU_CTRL;
            data1 = DATA1;
            data2 = DATA2;
            imm = IMM;
            rs = RS;
            rt = RT;
            rd = RD;
            // $display("IDEX: ctrl=%4b, rs=%2d, rt=%2d, rd=%2d, imm=%5d, data1=%5d, data2=%5d, rw=%1b"
            // , alu_ctrl, rs, rt, rd, imm, data1, data2, reg_write);
        end
    end



endmodule
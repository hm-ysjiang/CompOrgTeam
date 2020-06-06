
`timescale 1ns/1ps

module ID_EX(
    input           	 clk_i,
	input           	 rst_i,
    
    input                REG_WRITE,
    input                MEM_TO_REG,
    input                MEMREAD,
    input                MEMWRITE,
    input                ALU_SRC,
    input       [1:0] 	 ALU_OP,
    input       [31:0]   PC,
    input       [31:0]   DATA1,
    input       [31:0]   DATA2,
    input       [31:0]   IMM,
    input       [4:0]    RS1,
    input       [4:0]    RS2,
    input       [4:0]    RD,

    output wire          REG_WRITE_O,
    output wire          MEM_TO_REG_O,
    output wire          MEMREAD_O,
    output wire          MEMWRITE_O,
    output wire          ALU_SRC_O,
    output wire [1:0] 	 ALU_OP_O,
    output wire [31:0]   PC_O,
    output wire [31:0]   DATA1_O,
    output wire [31:0]   DATA2_O,
    output wire [31:0]   IMM_O,
    output wire [4:0]    RS1_O,
    output wire [4:0]    RS2_O,
    output wire [4:0]    RD_O
    );


    reg                  reg_write;
    reg                  mem_to_reg;
    reg                  memread;
    reg                  memwrite;
    reg                  alu_src;
    reg         [1:0]    alu_op;
    reg         [31:0]   pc;
    reg         [31:0]   data1;
    reg         [31:0]   data2;
    reg         [31:0]   imm;
    reg         [4:0]    rs1;
    reg         [4:0]    rs2;
    reg         [4:0]    rd;

    assign REG_WRITE_O = reg_write;
    assign MEM_TO_REG_O = mem_to_reg;
    assign MEMREAD_O = memread;
    assign MEMWRITE_O = memwrite;
    assign ALU_SRC_O = alu_src;
    assign ALU_OP_O = alu_op;
    assign PC_O = pc;
    assign DATA1_O = data1;
    assign DATA2_O = data2;
    assign IMM_O = imm;
    assign RS1_O = rs1;
    assign RS2_O = rs2;
    assign RD_O = rd;

    always@(posedge clk_i) begin
        if(!rst_i) begin
            reg_write = 0;
            mem_to_reg = 0;
            memread = 0;
            memwrite = 0;
            alu_src = 0;
            alu_op = 0;
            pc = 0;
            data1 = 0;
            data2 = 0;
            imm = 0;
            rs1 = 0;
            rs2 = 0;
            rd = 0;
        end
        else begin
            reg_write = REG_WRITE;
            mem_to_reg = MEM_TO_REG;
            memread = MEMREAD;
            memwrite = MEMWRITE;
            alu_src = ALU_SRC;
            alu_op = ALU_OP;
            pc = PC;
            data1 = DATA1;
            data2 = DATA2;
            imm = IMM;
            rs1 = RS1;
            rs2 = RS2;
            rd = RD;
        end
    end



endmodule
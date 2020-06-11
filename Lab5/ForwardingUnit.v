`timescale 1ns/1ps

module ForwardingUnit(
	input        [4:0]    IF_ID__RS1,
	input        [4:0]    IF_ID__RS2,
	input        [4:0]    EX_MEM__RD,
	input        [4:0]    MEM_WB__RD,
	input                 EX_MEM__REG_WRITE,
	input                 MEM_WB__REG_WRITE,
    output wire  [1:0]    SRC1,
    output wire  [1:0]    SRC2,
	);

    // 0 : original signal, 1 : EX/MEM, 2 : MEM/WB

    assign SRC1 = (IF_ID__RS1==EX_MEM__RD && EX_MEM__REG_WRITE) ? 1 : (
                  (IF_ID__RS1==MEM_WB__RD && MEM_WB__REG_WRITE) ? 2 : 
                                                                  0   );

    assign SRC2 = (IF_ID__RS2==EX_MEM__RD && EX_MEM__REG_WRITE) ? 1 : (
                  (IF_ID__RS2==MEM_WB__RD && MEM_WB__REG_WRITE) ? 2 : 
                                                                  0   );



endmodule
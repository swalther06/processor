// This file is auto-generated. Do not edit directly.

`ifndef CONSTANTS_SVH
`define CONSTANTS_SVH

localparam INSTR_LEN = 32;
localparam NUM_REGS = 32;
localparam REG_SIZE = 32;
localparam PC_SIZE = 32;
localparam NUM_INSTRS = 11;
localparam OPCODE_SIZE = 5;
localparam REG_ADDR_SIZE = 5;
localparam ALU_OP_SIZE = 8;
localparam ADDRESS_SPACE_B = 4294967296;
localparam BYTE_SIZE = 8;
localparam WORD_SIZE_BITS = 32;
localparam WORD_SIZE_BYTES = 4;
localparam ADDRESS_SPACE_W = 1073741824;
localparam OP_ADD = 0;
localparam OP_SUB = 1;
localparam OP_AND = 2;
localparam OP_ORR = 3;
localparam OP_NOR = 4;
localparam OP_XOR = 5;
localparam OP_LDW = 6;
localparam OP_LDB = 7;
localparam OP_STW = 8;
localparam OP_STB = 9;
localparam OP_LSL = 10;
localparam OP_LSR = 11;
localparam OP_BNE = 12;
localparam OP_BLT = 13;
localparam OP_BST = 14;
localparam OP_NOP = 15;
localparam OP_MOV = 16;
localparam OP_ADDI = 17;
localparam OP_SUBI = 18;
localparam ALU_ADD = 0;
localparam ALU_SUB = 1;
localparam ALU_AND = 2;
localparam ALU_ORR = 3;
localparam ALU_NOR = 4;
localparam ALU_XOR = 5;
localparam ALU_LSL = 8;
localparam ALU_LSR = 9;
localparam UNUSED_START = 31;
localparam UNUSED_END = 31;
localparam OPCODE_START = 30;
localparam OPCODE_END = 26;
localparam R_RS_START = 25;
localparam R_RS_END = 21;
localparam R_RT_START = 20;
localparam R_RT_END = 16;
localparam R_RD_START = 15;
localparam R_RD_END = 11;
localparam R_SHAMT_START = 10;
localparam R_SHAMT_END = 6;
localparam R_FUNCT_START = 5;
localparam R_FUNCT_END = 0;
localparam I_IMM_START = 15;
localparam I_IMM_END = 0;
localparam J_ADDR_START = 25;
localparam J_ADDR_END = 0;

`endif // CONSTANTS_SVH

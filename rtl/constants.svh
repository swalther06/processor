`ifndef CONSTANTS_SVH
`define CONSTANTS_SVH



// ARCHITECTURE DEFINITIONS
localparam INSTR_LEN = 'd32;
localparam NUM_REGS = 'd32;
localparam REG_SIZE = 'd32;
localparam PC_SIZE = REG_SIZE;
localparam NUM_INSTRS = 'd11;


// BIT DEFINITIONS
localparam OPCODE_SIZE = $clog2(NUM_INSTRS);
localparam REG_ADDR_SIZE = $clog2(NUM_REGS);
localparam ALU_OP_SIZE = 8;


// MEMORY
localparam ADDRESS_SPACE_B = 2 ** REG_SIZE;
localparam BYTE_SIZE = 'd8;
localparam WORD_SIZE_BITS = 'd32;
localparam WORD_SIZE_BYTES = 'd4;
localparam ADDRESS_SPACE_W = ADDRESS_SPACE_B / WORD_SIZE_BYTES;


// OPCODES
localparam OP_ADD = 0;      // add
localparam OP_SUB = 1;      // sub
localparam OP_AND = 2;      // bitwise and
localparam OP_ORR = 3;      // bitwise or
localparam OP_NOR = 4;      // bitwise nor
localparam OP_XOR = 5;      // bitwise xor
localparam OP_LDW = 6;      // load word
localparam OP_LDB = 7;      // load byte
localparam OP_STW = 8;      // store word
localparam OP_STB = 9;      // store byte
localparam OP_LSL = 10;     // logical shift left
localparam OP_LSR = 11;     // logical shift right
localparam OP_BNE = 12;     // (conditional) branch not equal
localparam OP_BLT = 13;     // (conditional) branch if less than
localparam OP_BST = 14;     // (unconditional) branch and store addr
localparam OP_NOP = 15;     // no operation
localparam OP_MOV = 16;     // move value to register


// ALU OPERATIONS
localparam ALU_ADD = 0;
localparam ALU_SUB = 1;
localparam ALU_AND = 2;
localparam ALU_ORR = 3;
localparam ALU_NOR = 4;
localparam ALU_XOR = 5;
localparam ALU_LSL = 8;
localparam ALU_LSR = 9;


// INSTRUCTION FIELDS
localparam UNUSED_START = 31;
localparam UNUSED_END = 31;
localparam OPCODE_START = 30;
localparam OPCODE_END = 26;
// R-type
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
// I-type
localparam I_RS_START = 25; 
localparam I_RS_END = 21;
localparam I_RT_START = 20;
localparam I_RT_END = 16;
localparam I_IMM_START = 15;
localparam I_IMM_END = 0;
// J-type
localparam J_ADDR_START = 25;
localparam J_ADDR_END = 0;


`endif
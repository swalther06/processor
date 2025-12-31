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
localparam OPCODE_START = 'd31;
localparam OPCODE_END = OPCODE_START - OPCODE_SIZE + 1;
localparam REG_ADDR_SIZE = $clog2(NUM_REGS);
localparam ALU_OP_SIZE = 8;


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



`endif
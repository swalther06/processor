`include "constants.svh"
`include "processor_control.sv"

typedef struct packed {
    logic [PC_SIZE - 1:0] pc_plus4;
    logic [INSTR_LEN -1 :0] instr;
    control_t ctrl;

} IF_ID;        // IF_ID pipeline register

typedef struct packed {
    logic [PC_SIZE - 1:0] pc_plus4;
    logic [INSTR_LEN - 1:0] instr;
    logic [REG_SIZE - 1:0] regA_data;
    logic [REG_SIZE - 1:0] regB_data;
    logic [31:0] offset; // to do
    control_t ctrl;

} ID_EX;        // ID_EX pipeline register

typedef struct packed {
    logic [PC_SIZE - 1:0] pc_plus4;
    logic [INSTR_LEN - 1:0] instr;
    logic [REG_SIZE - 1:0] alu_result;
    logic                   alu_eq;
    logic [REG_SIZE - 1:0] valB;
    logic [PC_SIZE - 1:0] branch_target;
    control_t ctrl;

} EX_MEM;       // EX_MEM pipeline register

typedef struct packed {
    logic [INSTR_LEN - 1:0] instr;
    logic [REG_SIZE - 1:0] wb_val;
    control_t ctrl;

} MEM_WB;       // MEM_WB pipeline register

typedef struct packed {
    logic [INSTR_LEN - 1:0] instr;
    logic [REG_SIZE - 1:0] wb_val;
    control_t ctrl;

} WB_END;       // WB_END pipeline register (for forwarding)
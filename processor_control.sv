`include "constants.svh"

typedef struct packed {
    logic regWrEn;                      // allows writing to regfile
    logic memEn;                        // allows memory access
    logic memRW;                        // 0 = read, 1 = write
    logic SEL_valB;                     // mux for valB 
    logic SEL_wrData;                   // mux for writeData
    logic SEL_destReg;                  // mux for destReg
    logic is_branch;                    // if branch inst
    logic [ALU_OP_SIZE - 1:0] alu_op;

} control_t;


module control (
    input logic [INSTR_LEN - 1:0] instr,
    output control_t ctrl
);

    logic [OPCODE_SIZE - 1:0] opcode = instr[OPCODE_START : OPCODE_END];

    always_comb begin
        case (opcode)
            OP_ADD: 
            begin
                ctrl.regWrEn = 1;
                ctrl.memEn = 0;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_ADD;
            end
            OP_SUB:
            begin
                ctrl.regWrEn = 1;
                ctrl.memEn = 0;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_SUB;
            end
            OP_AND:
            begin
                ctrl.regWrEn = 1;
                ctrl.memEn = 0;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_AND;
            end
            OP_ORR:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 0;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_ORR;
            end
            OP_NOR:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 0;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_NOR;
            end
            OP_XOR:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 0;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_XOR;
            end
            OP_LDW:
            begin
                ctrl.regWrEn = 1;
                ctrl.memEn = 1;
                ctrl.memRW = 0;
                ctrl.SEL_valB = 1;
                ctrl.SEL_wrData = 1;
                ctrl.SEL_destReg = 1;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_ADD;
            end
            OP_LDB:
            begin
                ctrl.regWrEn = 1;
                ctrl.memEn = 1;
                ctrl.memRW = 0;
                ctrl.SEL_valB = 1;
                ctrl.SEL_wrData = 1;
                ctrl.SEL_destReg = 1;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_ADD;
            end
            OP_STW:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 1;
                ctrl.memRW = 1;
                ctrl.SEL_valB = 1;
                ctrl.SEL_destReg = 1;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_ADD;
            end
            OP_STB:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 1;
                ctrl.memRW = 1;
                ctrl.SEL_valB = 1;
                ctrl.SEL_destReg = 1;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_ADD;
            end
            OP_LSL:
            begin
                ctrl.regWrEn = 1;
                ctrl.memEn = 0;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_LSL;
            end
            OP_LSR:
            begin
                ctrl.regWrEn = 1;
                ctrl.memEn = 0;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_LSR;
            end
            OP_BNE:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 0;
                ctrl.is_branch = 1;
                ctrl.alu_op = ALU_AND;
            end
            OP_BLT:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 0;
                ctrl.is_branch = 1;
                ctrl.alu_op = ALU_AND; // should be ALU_LT
            end
            OP_BST:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 0;
                ctrl.is_branch = 1;
                ctrl.alu_op = ALU_AND;
            end
            OP_NOP:
            begin
                ctrl.regWrEn = 0;
                ctrl.memEn = 0;
                ctrl.is_branch = 0;
            end
            OP_MOV: // come back to this
            begin
                ctrl.regWrEn = 1;
                ctrl.SEL_valB = 0;
                ctrl.SEL_wrData = 0;
                ctrl.SEL_destReg = 0;
                ctrl.is_branch = 0;
                ctrl.alu_op = ALU_SUB;
            end
            
        endcase
    end

endmodule
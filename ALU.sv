`include "constants.svh"

module ALU (
    input  logic [REG_SIZE - 1:0]  A,         // 32-bit input A
    input  logic [REG_SIZE - 1:0]  B,         // 32-bit input B
    input  logic [OPCODE_SIZE - 1:0]   ALU_Op,    // ALU operation select
    output logic [REG_SIZE - 1:0]  ALU_Out,   // 32-bit ALU output
    output logic         Zero       // Zero flag
);

    always_comb begin
        case (ALU_Op)
            ALU_AND: ALU_Out = A & B;          // AND
            ALU_ORR: ALU_Out = A | B;          // OR
            ALU_ADD: ALU_Out = A + B;          // ADD
            ALU_SUB: ALU_Out = A - B;          // SUB
            ALU_XOR: ALU_Out = A ^ B;          // XOR
            ALU_NOR: ALU_Out = ~(A | B);       // NOR
            ALU_LSL: ALU_Out = A << B[4:0];    // LSL
            ALU_LSR: ALU_Out = A >> B[4:0];    // LSR
            // need less than op too
            default: ALU_Out = 0;           
        endcase
    end

    // Set Zero flag if ALU_Out is zero
    assign Zero = (ALU_Out == 0);

endmodule
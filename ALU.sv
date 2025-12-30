module ALU (
    input  logic [31:0]  A,         // 32-bit input A
    input  logic [31:0]  B,         // 32-bit input B
    input  logic [2:0]   ALU_Op,    // ALU operation select
    output logic [31:0]  ALU_Out,   // 32-bit ALU output
    output logic         Zero       // Zero flag
);

    always_comb begin
        case (ALU_Op)
            3'b000: ALU_Out = A & B;          // AND
            3'b001: ALU_Out = A | B;          // OR
            3'b010: ALU_Out = A + B;          // ADD
            3'b011: ALU_Out = A - B;          // SUB
            3'b100: ALU_Out = A ^ B;          // XOR
            3'b101: ALU_Out = ~(A | B);       // NOR
            3'b110: ALU_Out = A << B[4:0];    // LSL
            3'b111: ALU_Out = A >> B[4:0];    // LSR
        endcase
    end

    // Set Zero flag if ALU_Out is zero
    assign Zero = (ALU_Out == 32'd0) ? 1'b1 : 1'b0;

endmodule
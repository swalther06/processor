module regfile (
    input  logic        clk,            // Clock signal
    input  logic        WriteEnable,    // Write enable signal
    input  logic [4:0]  RegA,           // First register number
    input  logic [4:0]  RegB,           // Second register number
    input  logic [4:0]  WriteReg,       // Register number to write to
    input  logic [31:0] WriteData,      // Data to write to the register
    output logic [31:0] Data1,          // Data output from first register
    output logic [31:0] Data2           // Data output from second register
);

    logic [31:0] registers [31:0]; // 32 registers of 32 bits each

    always_comb begin : read_process
        Data1 = registers[RegA]; // Read data from the first register
        Data2 = registers[RegB]; // Read data from the second register
    end

    always_ff @(posedge clk) begin : write_process
        if (WriteEnable) begin
            registers[WriteReg] <= WriteData; // Write data to the specified register
        end
    end


endmodule
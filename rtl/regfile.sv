`ifndef REGFILE_SV
`define REGFILE_SV

`include "rtl/constants.svh"

module regfile (
    input  logic                        clk,            // Clock signal
    input  logic                        WriteEnable,    // Write enable signal
    input  logic [REG_ADDR_SIZE - 1:0]  RegA,           // First register addres
    input  logic [REG_ADDR_SIZE - 1:0]  RegB,           // Second register address
    input  logic [REG_ADDR_SIZE - 1:0]  WriteReg,       // Register adderss to write to
    input  logic [REG_SIZE - 1:0]       WriteData,      // Data to write to the register
    output logic [REG_SIZE - 1:0]       Data1,          // Data output from first register
    output logic [REG_SIZE - 1:0]       Data2           // Data output from second register
);

    logic [REG_SIZE - 1:0] registers [NUM_REGS - 1:0]; // 32 registers of 32 bits each

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

`endif
`ifndef MEMORY_SV
`define MEMORY_SV

`include "isa/constants.svh"



module memory (
    input  logic                    clk,
    input  logic                    mem_EN,
    input  logic                    mem_RW,
    input  logic [REG_SIZE - 1:0]   addr,
    input  logic [REG_SIZE - 1:0]   wdata,
    output logic [REG_SIZE - 1:0]   rdata
);
    logic [REG_SIZE - 1: 0] mem_arr [0:ADDRESS_SPACE_W - 1];



    always_ff @(posedge clk) begin : mem_access
        case (mem_RW)
            0:  rdata <= mem_EN ? mem_arr[addr] : rdata;
            1:  mem_arr[addr] <= mem_EN ? wdata : mem_arr[addr] ;
        endcase
    end

endmodule

`endif
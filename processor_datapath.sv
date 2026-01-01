`include "constants.svh"
`include "pipeline_registers.sv"
`include "processor_control.sv"


module datapath (
    input logic clk
);

    IF_ID reg_ifid;
    ID_EX reg_idex;
    EX_MEM reg_exmem;
    MEM_WB reg_memwb;
    WB_END reg_wbend;



    


endmodule



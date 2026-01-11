`include "rtl/datapath.sv"

module processor_toplevel ();

    logic clk;
    logic rst;

    initial begin
        clk = 0;
        rst = 1;
        #50 rst = 0;
    end

    always #5 clk = ~clk;

    datapath dp (
        .clk(clk),
        .rst(rst)
    );

endmodule
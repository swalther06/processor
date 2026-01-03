`include "constants.svh"
`include "pipeline_registers.sv"
`include "processor_control.sv"


module datapath (
    input logic clk
);
    logic [PC_SIZE - 1:0] pc;
    initial pc = 0;

    // Pipeline Registers
    IF_ID reg_ifid;
    ID_EX reg_idex;
    EX_MEM reg_exmem;
    MEM_WB reg_memwb;
    WB_END reg_wbend;


    // Data and Instruction Memory
    logic memEN, memRW, addr, wdata, rdata;
    logic instr;
    memory data_memory (
        .clk(clk),
        .mem_EN(memEN),
        .mem_RW(memRW),
        .addr(addr),
        .wdata(wdata),
        .rdata(rdata)
    );

    memory instr_memory (
        .clk(clk),
        .mem_EN(1'b1),
        .mem_RW(1'b0),
        .addr(pc),
        .wdata(32'd0),
        .rdata(instr)
    );


    // Control Unit
    control_t ctrl_ID;
    processor_control control_unit (
        .instr(reg_ifid.instr),
        .ctrl(ctrl_ID)
    );


    // ALU
    logic [REG_SIZE - 1:0]  alu_result;
    logic                   alu_zero;
    logic [REG_SIZE - 1:0]  alu_A, alu_B;
    logic                   alu_op;
    ALU alu_unit (
        .A(alu_A),
        .B(alu_B),
        .ALU_Op(reg_idex.ctrl.alu_op),
        .ALU_Out(alu_result),
        .Zero(alu_zero)
    );


    // Register File
    logic [REG_ADDR_SIZE - 1:0] regA_addr, regB_addr, write_addr;
    logic [REG_SIZE - 1:0] regA_data, regB_data, write_data;
    logic write_en;
    regfile register_file (
        .clk(clk),
        .read_addr1(reg_idex.regA_addr),
        .read_addr2(reg_idex.regB_addr),
        .write_addr(write_addr),
        .write_data(write_data),
        .write_en(write_en)
    );


    // IF
    always_ff @(posedge clk) begin : if_stage
        pc <= (reg_exmem.ctrl.is_branch & reg_exmem.alu_zero) ? reg_exmem.branch_target : pc + 4;
        reg_ifid.pc_plus4 <= pc + 4;
        reg_ifid.instr <= instr;
    end


    // ID
    always_comb begin
        regA_addr = reg_ifid.instr[R_RS_START:R_RS_END];
        regB_addr = reg_ifid.instr[R_RT_START:R_RT_END];
    end
    always_ff @(posedge clk) begin : id_stage
        reg_idex.pc_plus4 <= reg_ifid.pc_plus4;
        reg_idex.instr <= reg_ifid.instr;
        reg_idex.ctrl <= ctrl_ID;

        reg_idex.regA_data <= regA_data;
        reg_idex.regB_data <= regB_data;
        reg_idex.offset <= {{(I_IMM_START-I_IMM_END){reg_ifid.instr[I_IMM_START]}}, 
                            reg_ifid.instr[I_IMM_START:I_IMM_END]}; // sign-extend immediate
    end


    // EX
    always_comb begin
        alu_A = reg_idex.regA_data;
        alu_B = reg_idex.ctrl.SEL_valB ? reg_idex.offset : reg_idex.regB_data;
    end
    always_ff @(posedge clk) begin : ex_stage
        reg_exmem.pc_plus4 <= reg_idex.pc_plus4;
        reg_exmem.instr <= reg_idex.instr;
        reg_exmem.ctrl <= reg_idex.ctrl;

        reg_exmem.alu_result <= alu_result;
        reg_exmem.alu_zero <= alu_zero;
        reg_exmem.valB <= reg_idex.regB_data;
        reg_exmem.branch_target <= reg_idex.pc_plus4 + (reg_idex.offset << 2);
        
    end


    // MEM
    always_ff @(posedge clk) begin : mem_stage
        reg_memwb.instr <= reg_exmem.instr;
        reg_memwb.ctrl <= reg_exmem.ctrl;
        
        if (reg_exmem.ctrl.memEn & reg_exmem.ctrl.memRW) begin
            addr <= reg_exmem.alu_result;
            wdata <= reg_exmem.valB;
        end 
        
        reg_memwb.wb_val <= reg_exmem.ctrl.SEL_wrData ? rdata : reg_exmem.alu_result;
    end 


    // WB
    always_comb begin
        write_addr = reg_memwb.ctrl.SEL_destReg ? 
                     reg_memwb.instr[R_RD_START:R_RD_END] : reg_memwb.instr[R_RT_START:R_RT_END];
        write_data = reg_memwb.wb_val;
        write_en = reg_memwb.ctrl.regWrEn;
    end
    always_ff @(posedge clk) begin : wb_stage
        reg_wbend.instr <= reg_memwb.instr;
        reg_wbend.ctrl <= reg_memwb.ctrl;
        reg_wbend.wb_val <= reg_memwb.wb_val;
    end


endmodule


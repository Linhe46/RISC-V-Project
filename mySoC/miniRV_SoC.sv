// Add your code here, or replace this file.
`include "defines.sv"
module miniRV_SoC (
    input  logic         fpga_clk,
    input  logic         fpga_rst,

    // Interface to IROM
    
    // Interface to DRAM

    output wire        debug_wb_have_inst,   // WB阶段是否有指令 (对单周期CPU，可在复位后恒为1)
    output wire [31:0] debug_wb_pc,          // WB阶段的PC (若wb_have_inst=0，此项可为任意值)
    output wire        debug_wb_ena,         // WB阶段的寄存器写使能 (若wb_have_inst=0，此项可为任意值)
    output wire [ 4:0] debug_wb_reg,         // WB阶段写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
    output wire [31:0] debug_wb_value        // WB阶段写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)
);

    // my cpu design 
    logic clk = fpga_clk;
    logic rst = fpga_rst;
    // TODO: regard data memory as non-core module
    // otherwise no output 

    // stall signals
    logic[`STALL_WIDTH-1:0] stall;

    /* if stage */
    logic[`MEM_ADDR_WIDTH-1:0]  pc_if;
    logic[`REG_DATA_WIDTH-1:0]  inst_if;
    // PC reg <-> IF stage signals
    logic[`MEM_ADDR_WIDTH-1:0]  pc_reg;
    logic   pc_wr_en;

    // inst mem <-> IF stage signals
    logic[`REG_DATA_WIDTH-1:0] inst_imem;
    logic   imem_rd_en;

    /* id stage */
    logic[`MEM_ADDR_WIDTH-1:0]  pc_id;
    logic[`REG_DATA_WIDTH-1:0]  inst_id;
    logic                       rs1_rd_en_id;
    logic                       rs2_rd_en_id;
    logic[`REG_DATA_WIDTH-1:0]  rs1_data_reg;
    logic[`REG_DATA_WIDTH-1:0]  rs2_data_reg;
    logic[`REG_ADDR_WIDTH-1:0]  rs1_addr_id;
    logic[`REG_ADDR_WIDTH-1:0]  rs2_addr_id;
    logic[`REG_ADDR_WIDTH-1:0]  rd_addr_id;
    logic[`REG_DATA_WIDTH-1:0]  imm_id;
    logic                       is_branch_id;
    logic                       branch_taken_id;
    logic[`MEM_ADDR_WIDTH-1:0]  branch_addr_id;
    logic[`FORWARD_WIDTH-1:0]   forward_op1_id;
    logic[`FORWARD_WIDTH-1:0]   forward_op2_id;
    logic[`ALU_OP_WIDTH-1:0]    alu_op_id;
    logic                       alu_src_id;
    logic                       mem_read_id;
    logic                       mem_write_id;
    logic[`MASK_WIDTH-1:0]      mask_id;
    logic                       unsigned_load_id;
    logic                       reg_write_id;
    logic                       mem_to_reg_id;

    /* ex stage */
    logic[`REG_DATA_WIDTH-1:0]  rs1_data_ex;
    logic[`REG_DATA_WIDTH-1:0]  rs2_data_ex;
    logic[`REG_DATA_WIDTH-1:0]  imm_ex;
    logic[`FORWARD_WIDTH-1:0]   forward_op1_ex;
    logic[`FORWARD_WIDTH-1:0]   forward_op2_ex;
    //logic[`REG_DATA_WIDTH-1:0]  forward_data_mem;   
    //logic[`REG_DATA_WIDTH-1:0]  forward_data_wb; moved to mem and wb, for id also use them
    logic[`ALU_OP_WIDTH-1:0]    alu_op_ex;
    logic                       alu_src_ex;
    logic[`REG_DATA_WIDTH-1:0]  alu_res_ex;
    logic[`REG_DATA_WIDTH-1:0]  bypass_op2_ex;

    /* id/ex pipeline regfile bypass to ex/mem */
    logic                       rs1_rd_en_ex;
    logic                       rs2_rd_en_ex;
    logic[`REG_ADDR_WIDTH-1:0]  rs1_addr_ex;
    logic[`REG_ADDR_WIDTH-1:0]  rs2_addr_ex;
    logic[`REG_ADDR_WIDTH-1:0]  rd_addr_ex;
    logic                       mem_read_ex;
    logic                       mem_write_ex;
    logic[`MASK_WIDTH-1:0]      mask_ex;
    logic                       unsigned_load_ex;
    logic                       reg_write_ex;
    logic                       mem_to_reg_ex;

    /* mem stage */
    logic[`REG_DATA_WIDTH-1:0]  alu_res_mem;
    logic[`REG_DATA_WIDTH-1:0]  bypass_op2_mem;
    logic                       mem_read_mem;
    logic                       mem_write_mem;
    logic[`MASK_WIDTH-1:0]      mask_mem;
    logic                       unsigned_load_mem;
    // memory signals begin
    logic[`REG_DATA_WIDTH-1:0]  dmem_rd_data;
    logic[`MEM_ADDR_WIDTH-1:0]  dmem_addr;
    logic[`REG_DATA_WIDTH-1:0]  dmem_wr_data;
    logic                       dmem_wr_en;
    logic                       dmem_rd_en;
    logic[`MASK_WIDTH-1:0]      dmem_mask;
    // memory signals end
    logic[`REG_DATA_WIDTH-1:0]  mem_data_mem;
    logic[`REG_DATA_WIDTH-1:0]  alu_data_mem;
    logic[`REG_DATA_WIDTH-1:0]  forward_data_mem;   // from mem stage

    /* ex/mem pipeline regfile bypass to mem/wb*/
    logic[`REG_ADDR_WIDTH-1:0]  rd_addr_mem;
    logic                       reg_write_mem;
    logic                       mem_to_reg_mem;

    /* wb stage */
    logic[`REG_DATA_WIDTH-1:0]  mem_data_wb;
    logic[`REG_DATA_WIDTH-1:0]  alu_data_wb;
    logic[`REG_ADDR_WIDTH-1:0]  rd_addr_wb;
    logic                       reg_write_wb;
    logic                       mem_to_reg_wb;
    // outputs to regfile
    logic                       reg_wr_en_wb;
    logic[`REG_ADDR_WIDTH-1:0]  reg_wr_addr_wb;
    logic[`REG_DATA_WIDTH-1:0]  reg_wr_data_wb;
    logic[`REG_DATA_WIDTH-1:0]  forward_data_wb;    // from wb stage
    // reg file signals begin

    /* no bypass at mem/wb pipeline regfile */
    // if has inst ?
    logic                       has_inst_id;
    logic                       has_inst_ex;
    logic                       has_inst_mem;
    logic                       has_inst_wb;
    // If has inst, what's the PC ?
    logic[`REG_DATA_WIDTH-1:0]  inst_pc_id;
    logic[`REG_DATA_WIDTH-1:0]  inst_pc_ex;
    logic[`REG_DATA_WIDTH-1:0]  inst_pc_mem;
    logic[`REG_DATA_WIDTH-1:0]  inst_pc_wb;

    if_ if_stage(
        .rst(rst),
        .stall(stall),
        .pc_in(pc_reg),
        .inst_imem(inst_imem),
        // outputs
        .pc_wr_en(pc_wr_en),
        .imem_rd_en(imem_rd_en),
        .pc_out(pc_if),
        .inst(inst_if)
    );

    if_id_reg if_id_regfile(
        .clk(clk),
        .rst(rst),
        .stall(stall),
        .branch_taken(branch_taken_id),
        .PC_if(pc_if),
        .inst_if(inst_if),
        // outputs
        .PC_id(pc_id),
        .inst_id(inst_id),

        .has_inst_id(has_inst_id)
    );
    assign inst_pc_id = pc_id;

    id id_stage(
        // inputs
        .rst(rst),
        .pc(pc_id),
        .inst(inst_id),
        .rs1_data_reg(rs1_data_reg),
        .rs2_data_reg(rs2_data_reg),
        .forward_op1(forward_op1_id),
        .forward_op2(forward_op2_id),
        .forward_data_mem(forward_data_mem),
        .forward_data_wb(forward_data_wb),
        // outputs
        .rs1_rd_en(rs1_rd_en_id),
        .rs2_rd_en(rs2_rd_en_id),
        .rs1_addr(rs1_addr_id),
        .rs2_addr(rs2_addr_id),
        .rd_addr(rd_addr_id),
        .imm(imm_id),
        .is_branch(is_branch_id),
        .branch_taken(branch_taken_id),
        .branch_addr(branch_addr_id),
        .alu_op(alu_op_id),
        .alu_src(alu_src_id),
        .mem_read(mem_read_id),
        .mem_write(mem_write_id),
        .mask(mask_id),
        .unsigned_load(unsigned_load_id),
        .reg_write(reg_write_id),
        .mem_to_reg(mem_to_reg_id)
    );

    id_ex_reg id_ex_regfile(
        .clk(clk),
        .rst(rst), 
        .stall(stall),
        .rs1_data_reg(rs1_data_reg), 
        .rs2_data_reg(rs2_data_reg),
        .imm_id(imm_id), 
        .rs1_rd_en_id(rs1_rd_en_id), 
        .rs2_rd_en_id(rs2_rd_en_id),
        .rs1_addr_id(rs1_addr_id), 
        .rs2_addr_id(rs2_addr_id), 
        .rd_addr_id(rd_addr_id),
        .alu_op_id(alu_op_id),
        .alu_src_id(alu_src_id),
        .mem_read_id(mem_read_id),
        .mem_write_id(mem_write_id),
        .mask_id(mask_id),
        .unsigned_load_id(unsigned_load_id),
        .reg_write_id(reg_write_id),
        .mem_to_reg_id(mem_to_reg_id),
        // outputs
        .rs1_data(rs1_data_ex),
        .rs2_data(rs2_data_ex),
        .imm_ex(imm_ex),
        .rs1_rd_en_ex(rs1_rd_en_ex),
        .rs2_rd_en_ex(rs2_rd_en_ex),
        .rs1_addr_ex(rs1_addr_ex),
        .rs2_addr_ex(rs2_addr_ex),
        .rd_addr_ex(rd_addr_ex),
        .alu_op_ex(alu_op_ex),
        .alu_src_ex(alu_src_ex),
        .mem_read_ex(mem_read_ex),
        .mem_write_ex(mem_write_ex),
        .mask_ex(mask_ex),
        .unsigned_load_ex(unsigned_load_ex),
        .reg_write_ex(reg_write_ex),
        .mem_to_reg_ex(mem_to_reg_ex),

        .has_inst_id(has_inst_id),
        .inst_pc_id(inst_pc_id),
        .has_inst_ex(has_inst_ex),
        .inst_pc_ex(inst_pc_ex)
    );

    ex ex_stage(
        .rst(rst),
        .rs1_data(rs1_data_ex),
        .rs2_data(rs2_data_ex),
        .imm(imm_ex),
        .forward_op1(forward_op1_ex),
        .forward_op2(forward_op2_ex),
        .forward_data_mem(forward_data_mem),
        .forward_data_wb(forward_data_wb),
        .alu_op(alu_op_ex),
        .alu_src(alu_src_ex),
        .alu_res(alu_res_ex),
        .bypass_op2(bypass_op2_ex)
    );

    ex_mem_reg ex_mem_regfile(
        .clk(clk),
        .rst(rst),
        .alu_res_ex(alu_res_ex),
        .bypass_op2_ex(bypass_op2_ex),
        .rd_addr_ex(rd_addr_ex),
        .mem_read_ex(mem_read_ex),
        .mem_write_ex(mem_write_ex),
        .mask_ex(mask_ex),
        .unsigned_load_ex(unsigned_load_ex),
        .reg_write_ex(reg_write_ex),
        .mem_to_reg_ex(mem_to_reg_ex),
        // outputs
        .alu_res_mem(alu_res_mem),
        .bypass_op2_mem(bypass_op2_mem),
        .rd_addr_mem(rd_addr_mem),
        .mem_read_mem(mem_read_mem),
        .mem_write_mem(mem_write_mem),
        .mask_mem(mask_mem),
        .unsigned_load_mem(unsigned_load_mem),
        .reg_write_mem(reg_write_mem),
        .mem_to_reg_mem(mem_to_reg_mem),

        .has_inst_ex(has_inst_ex),
        .inst_pc_ex(inst_pc_ex),
        .has_inst_mem(has_inst_mem),
        .inst_pc_mem(inst_pc_mem)
    );

    mem mem_stage(
        .rst(rst),
        .alu_res(alu_res_mem),
        .bypass_op2(bypass_op2_mem),
        .mem_read(mem_read_mem),
        .mem_write(mem_write_mem),
        .mask(mask_mem),
        .unsigned_load(unsigned_load_mem),
        // output to memory begin
        .dmem_rd_data(dmem_rd_data),
        .dmem_addr(dmem_addr),
        .dmem_wr_data(dmem_wr_data),
        .dmem_wr_en(dmem_wr_en),
        .dmem_rd_en(dmem_rd_en),
        .dmem_mask(dmem_mask),
        // output to memory end
        .mem_data(mem_data_mem),
        .alu_data(alu_data_mem),
        .forward_data(forward_data_mem)
    );

    mem_wb_reg mem_wb_regfile(
        .clk(clk),
        .rst(rst),
        .mem_data_mem(mem_data_mem),
        .alu_data_mem(alu_data_mem),
        .rd_addr_mem(rd_addr_mem),
        .reg_write_mem(reg_write_mem),
        .mem_to_reg_mem(mem_to_reg_mem),
        // outputs
        .mem_data_wb(mem_data_wb),
        .alu_data_wb(alu_data_wb),
        .rd_addr_wb(rd_addr_wb),
        .reg_write_wb(reg_write_wb),
        .mem_to_reg_wb(mem_to_reg_wb),

        .has_inst_mem(has_inst_mem),
        .inst_pc_mem(inst_pc_mem),
        .has_inst_wb(has_inst_wb),
        .inst_pc_wb(inst_pc_wb)
    );

    wb wb_stage(
        .rst(rst),
        .mem_data(mem_data_wb),
        .alu_data(alu_data_wb),
        .rd_addr(rd_addr_wb),
        .reg_write(reg_write_wb),
        .mem_to_reg(mem_to_reg_wb),
        // outputs
        .reg_wr_en(reg_wr_en_wb),
        .reg_wr_addr(reg_wr_addr_wb),
        .reg_wr_data(reg_wr_data_wb),
        .forward_data(forward_data_wb)
    );

    PC pc_u(
        .clk(clk),
        .rst(rst),
        .wr_en(pc_wr_en),
        .branch_taken(branch_taken_id),
        .branch_addr(branch_addr_id),
        .PC_out(pc_reg)
    );

    registers register_file(
        .clk(clk),
        .rst(rst),
        .wr_en(reg_wr_en_wb),
        .rs1_rd_en(rs1_rd_en_id),
        .rs2_rd_en(rs2_rd_en_id),
        .rd1_addr(rs1_addr_id),
        .rd2_addr(rs2_addr_id),
        .wr_addr(reg_wr_addr_wb),
        .wr_data(reg_wr_data_wb),
        // outputs
        .rd1_data(rs1_data_reg),
        .rd2_data(rs2_data_reg)
    );

// --------- Using provided IP cores to replace handcraft mems ----------
/*
    inst_memory imem(
        .rd_en(imem_rd_en),
        .addr(pc_if),
        // outputs
        .inst(inst_imem)
    );
*/
    logic[`MEM_ADDR_WIDTH-1:0] i_addr = (pc_if >> 2); // IROM is aligned by lower 2 bits
    IROM irom(
        .a(i_addr),
        .spo(inst_imem)
    );

/*
    data_memory dmem(
        .clk(clk),
        .rst(rst),
        .rd_en(dmem_rd_en),
        .wr_en(dmem_wr_en),
        .mask(dmem_mask),
        .addr(dmem_addr),
        .wr_data(dmem_wr_data),
        // output
        .rd_data(dmem_rd_data)
    );
*/
    DRAM dmem(
        .clk(clk),
        .a(dmem_addr),
        .we(dmem_wr_en),
        .d(dmem_wr_data),
        .spo(dmem_rd_data)
    );

    forward_unit_ex forward_ex_u(
        .rst(rst),
        .rs1_rd_en_ex(rs1_rd_en_ex),
        .rs2_rd_en_ex(rs2_rd_en_ex),
        .rs1_addr_ex(rs1_addr_ex),
        .rs2_addr_ex(rs2_addr_ex),
        //.rd_addr_ex(rd_addr_ex),
        .rd_addr_mem(rd_addr_mem),
        .reg_write_mem(reg_write_mem),
        .rd_addr_wb(rd_addr_wb),
        .reg_write_wb(reg_write_wb),
        // outputs
        .forward_op1(forward_op1_ex),
        .forward_op2(forward_op2_ex)
    );

    forward_unit_id forward_id_u(
        .rst(rst),
        .is_branch(is_branch_id),
        .rs1_rd_en_id(rs1_rd_en_id),
        .rs2_rd_en_id(rs2_rd_en_id),
        .rs1_addr_id(rs1_addr_id),
        .rs2_addr_id(rs2_addr_id),
        .rd_addr_mem(rd_addr_mem),
        .reg_write_mem(reg_write_mem),
        .rd_addr_wb(rd_addr_wb),
        .reg_write_wb(reg_write_wb),
        // outputs
        .forward_op1(forward_op1_id),
        .forward_op2(forward_op2_id)
    );

    stall_unit stall_u(
        .rst(rst),
        .is_branch(is_branch_id),
        .rs1_rd_en_id(rs1_rd_en_id),
        .rs2_rd_en_id(rs2_rd_en_id),
        .rs1_addr_id(rs1_addr_id),
        .rs2_addr_id(rs2_addr_id),
        .mem_read_ex(mem_read_ex),
        .mem_read_mem(mem_read_mem),
        .reg_write_ex(reg_write_ex),
        .rd_addr_ex(rd_addr_ex),
        .rd_addr_mem(rd_addr_mem),
        // outputs
        .stall(stall)
    );
    // TODO: 完成你自己的单周期CPU设计
    
    // Debug Interface
    assign debug_wb_have_inst = has_inst_wb;
    assign debug_wb_pc        = inst_pc_wb;
    assign debug_wb_ena       = reg_wr_en_wb;
    assign debug_wb_reg       = reg_wr_addr_wb;
    assign debug_wb_value     = reg_wr_data_wb;

endmodule
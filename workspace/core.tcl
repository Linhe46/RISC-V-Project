
set global_input {
    TOP.clk
    TOP.rst
}

set PC_U TOP.core.pc_u
set pc_output "
    $PC_U.PC_next
"

set IF TOP.core.if_stage
set if_signal "
    $IF.stall
    $IF.pc_wr_en
    $IF.pc_out
    $IF.inst
"

set ID TOP.core.id_stage
set id_signal "
    $ID.pc
    $ID.inst
    $ID.rs1_data_reg
    $ID.rs2_data_reg
    $ID.forward_op1
    $ID.forward_op2
    $ID.forward_data_mem
    $ID.forward_data_wb
    $ID.rs1_rd_en
    $ID.rs2_rd_en
    $ID.rs1_addr
    $ID.rs2_addr
    $ID.rd_addr
    $ID.imm
    $ID.is_branch
    $ID.branch_taken
    $ID.branch_addr
    $ID.alu_op
    $ID.alu_src
    $ID.mem_read
    $ID.mem_write
    $ID.mask
    $ID.unsigned_load
    $ID.reg_write
    $ID.mem_to_reg

    $ID.bra_op1
    $ID.bra_op2
    $ID.pc_bra
    $ID.rs1_eq_rs2
    $ID.rs1_ne_rs2
    $ID.rs1_lt_rs2
    $ID.rs1_ge_rs2
    $ID.rs1_ltu_rs2
    $ID.rs1_geu_rs2
"

set STALL TOP.core.stall_u
set stall_signal "
    $STALL.stall
"

gtkwave::nop
gtkwave::/Edit/Set_Trace_Max_Hier 0
gtkwave::/View/Show_Filled_High_Values 1
gtkwave::/View/Show_Wave_Highlight 1
gtkwave::/View/Show_Mouseover 1

# view global input 
gtkwave::addSignalsFromList $global_input
gtkwave::highlightSignalsFromList $global_input
gtkwave::addSignalsFromList $stall_signal
gtkwave::highlightSignalsFromList $stall_signal
gtkwave::/Edit/Color_Format/Green
gtkwave::/Edit/UnHighlight_All

# view pc output
gtkwave::addSignalsFromList $pc_output
gtkwave::highlightSignalsFromList $pc_output
gtkwave::/Edit/Color_Format/Orange
gtkwave::/Edit/UnHighlight_All

# view if signal
gtkwave::addSignalsFromList $if_signal
gtkwave::highlightSignalsFromList $if_signal
gtkwave::/Edit/Color_Format/Yellow
gtkwave::/Edit/UnHighlight_All

# view id signal
gtkwave::addSignalsFromList $id_signal
gtkwave::highlightSignalsFromList $id_signal
gtkwave::/Edit/Color_Format/Blue
gtkwave::/Edit/UnHighlight_All
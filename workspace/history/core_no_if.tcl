
set global_input {
    TOP.clk
    TOP.rst
    TOP.pc
    TOP.inst
}

set id_signals {
    TOP.core_no_if.id_stage.rs1_data_reg
    TOP.core_no_if.id_stage.rs2_data_reg
    TOP.core_no_if.id_stage.rs1_rd_en
    TOP.core_no_if.id_stage.rs2_rd_en
    TOP.core_no_if.id_stage.rs1_addr
    TOP.core_no_if.id_stage.rs2_addr
    TOP.core_no_if.id_stage.rd_addr
    TOP.core_no_if.id_stage.imm
}

set ex_signals {
    TOP.core_no_if.ex_stage.rs1_data
    TOP.core_no_if.ex_stage.rs2_data
    TOP.core_no_if.ex_stage.imm
    TOP.core_no_if.ex_stage.forward_op1
    TOP.core_no_if.ex_stage.forward_op2
    TOP.core_no_if.ex_stage.forward_data_mem
    TOP.core_no_if.ex_stage.forward_data_wb
    TOP.core_no_if.ex_stage.alu_op
    TOP.core_no_if.ex_stage.alu_src
    # outputs
    TOP.core_no_if.ex_stage.alu_res
    TOP.core_no_if.ex_stage.bypass_op2
    # outputs
}

gtkwave::nop
gtkwave::/Edit/Set_Trace_Max_Hier 0
gtkwave::/View/Show_Filled_High_Values 1
gtkwave::/View/Show_Wave_Highlight 1
gtkwave::/View/Show_Mouseover 1

gtkwave::addSignalsFromList $global_input
gtkwave::highlightSignalsFromList $global_input
gtkwave::/Edit/Color_Format/Green
gtkwave::/Edit/UnHighlight_All

gtkwave::addSignalsFromList $id_signals
gtkwave::highlightSignalsFromList $id_signals
gtkwave::/Edit/Color_Format/Orange
gtkwave::/Edit/UnHighlight_All

gtkwave::addSignalsFromList $ex_signals
gtkwave::highlightSignalsFromList $ex_signals
gtkwave::/Edit/Color_Format/Indigo
gtkwave::/Edit/UnHighlight_All

gtkwave::setZoomFactor 10
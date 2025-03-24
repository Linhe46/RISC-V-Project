# gtkwave::addSignalsFromFile "./wave_dir/id_tb.vcd"

# set signals to be added
set global_input {
    TOP.clk
    TOP.rst
}

set inst_input {
    TOP.pc
    TOP.inst
}

set ex_mem_reg_output {
    TOP.ex_tb.ex_mem_reg_u.alu_res_mem
    TOP.ex_tb.ex_mem_reg_u.bypass_op2_mem
    TOP.ex_tb.ex_mem_reg_u.mem_read_mem
    TOP.ex_tb.ex_mem_reg_u.mem_write_mem
    TOP.ex_tb.ex_mem_reg_u.mask_mem
    TOP.ex_tb.ex_mem_reg_u.unsigned_load_mem
    TOP.ex_tb.ex_mem_reg_u.reg_write_mem
    TOP.ex_tb.ex_mem_reg_u.mem_to_reg_mem
}

set ex_input {
    TOP.ex_tb.ex_u.rs1_data
    TOP.ex_tb.ex_u.rs2_data
    TOP.ex_tb.ex_u.imm
    TOP.ex_tb.ex_u.rs1_rd_en
    TOP.ex_tb.ex_u.rs2_rd_en
    TOP.ex_tb.ex_u.rs1_addr
    TOP.ex_tb.ex_u.rs2_addr
    TOP.ex_tb.ex_u.rd_addr
    TOP.ex_tb.ex_u.alu_op
    TOP.ex_tb.ex_u.alu_src
}

set ex_inner {
    TOP.ex_tb.ex_u.oprand1
    TOP.ex_tb.ex_u.oprand2
    TOP.ex_tb.ex_u.alu_op1
    TOP.ex_tb.ex_u.alu_op2
}

gtkwave::nop
gtkwave::/Edit/Set_Trace_Max_Hier 0
gtkwave::/View/Show_Filled_High_Values 1
gtkwave::/View/Show_Wave_Highlight 1
gtkwave::/View/Show_Mouseover 1

# view global input 
gtkwave::addSignalsFromList $global_input
gtkwave::highlightSignalsFromList $global_input
gtkwave::/Edit/Color_Format/Violet
gtkwave::/Edit/UnHighlight_All

gtkwave::addSignalsFromList $inst_input
gtkwave::highlightSignalsFromList $inst_input
gtkwave::/Edit/Color_Format/Violet
gtkwave::/Edit/UnHighlight_All

# view signals in ex stage
gtkwave::addSignalsFromList $ex_input
gtkwave::highlightSignalsFromList $ex_input
gtkwave::/Edit/Color_Format/Orange
gtkwave::/Edit/UnHighlight_All

# view signals in ex stage
gtkwave::addSignalsFromList $ex_inner
gtkwave::highlightSignalsFromList $ex_inner
gtkwave::/Edit/Color_Format/Green
gtkwave::/Edit/UnHighlight_All


# view signals in ex/mem regfile
gtkwave::addSignalsFromList $ex_mem_reg_output
gtkwave::highlightSignalsFromList $ex_mem_reg_output
gtkwave::/Edit/Color_Format/Yellow
gtkwave::/Edit/UnHighlight_All

gtkwave::setZoomFactor 10
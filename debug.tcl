
set global_input {
    TOP.fpga_clk
    TOP.fpga_rst
}

set debug_output {
    TOP.debug_wb_ena
    TOP.debug_wb_have_inst
    TOP.debug_wb_pc
    TOP.debug_wb_reg
    TOP.debug_wb_value
}

set inst_info {
    TOP.miniRV_SoC.pc_if
    TOP.miniRV_SoC.inst_if
    TOP.miniRV_SoC.inst_pc_id
    TOP.miniRV_SoC.inst_id
    TOP.miniRV_SoC.inst_pc_ex
    TOP.miniRV_SoC.inst_pc_mem
}

gtkwave::nop
gtkwave::/Edit/Set_Trace_Max_Hier 0
gtkwave::/View/Show_Filled_High_Values 1
gtkwave::/View/Show_Wave_Highlight 1
gtkwave::/View/Show_Mouseover 1

# view global input 
gtkwave::addSignalsFromList $global_input
gtkwave::highlightSignalsFromList $global_input
gtkwave::addSignalsFromList $debug_output
gtkwave::highlightSignalsFromList $debug_output
gtkwave::/Edit/Color_Format/Green
gtkwave::/Edit/UnHighlight_All

gtkwave::addSignalsFromList $inst_info
gtkwave::highlightSignalsFromList $inst_info
gtkwave::/Edit/Color_Format/Yellow
gtkwave::/Edit/UnHighlight_All
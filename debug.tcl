
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
    TOP.miniRV_SoC.my_cpu.pc_if
    TOP.miniRV_SoC.my_cpu.inst_if
    TOP.miniRV_SoC.my_cpu.inst_pc_id
    TOP.miniRV_SoC.my_cpu.inst_id
    TOP.miniRV_SoC.my_cpu.inst_pc_ex
    TOP.miniRV_SoC.my_cpu.inst_pc_mem
}

set mem_info {
    # IROM
    TOP.miniRV_SoC.irom.a
    TOP.miniRV_SoC.irom.spo
    # DRAM
    TOP.miniRV_SoC.dram.a
    TOP.miniRV_SoC.dram.spo
    TOP.miniRV_SoC.dram.we
    TOP.miniRV_SoC.dram.d
}

set inner_info {
    TOP.miniRV_SoC.my_cpu.mem_stage.mem_data
    #TOP.miniRV_SoC.my_cpu.id_stage.S_imm
    TOP.miniRV_SoC.my_cpu.id_stage.sext_S_imm
    TOP.miniRV_SoC.my_cpu.id_stage.sext_I_imm
    TOP.miniRV_SoC.my_cpu.mem_stage.dmem_addr
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

gtkwave::addSignalsFromList $mem_info
gtkwave::highlightSignalsFromList $mem_info
gtkwave::/Edit/Color_Format/Indigo
gtkwave::/Edit/UnHighlight_All

gtkwave::addSignalsFromList $inner_info
gtkwave::highlightSignalsFromList $inner_info
gtkwave::/Edit/Color_Format/Red
gtkwave::/Edit/UnHighlight_All
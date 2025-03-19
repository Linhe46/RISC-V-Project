# gtkwave::addSignalsFromFile "./wave_dir/id_tb.vcd"

# set signals to be added
set global_input {
    TOP.clk
    TOP.rst
    TOP.pc
    TOP.inst
}
set id_ex_reg_output {
    # regfile relevant signals
    TOP.id_tb.id_ex_reg_u.rs1_rd_en_ex
    TOP.id_tb.id_ex_reg_u.rs2_rd_en_ex
    TOP.id_tb.id_ex_reg_u.rs1_data
    TOP.id_tb.id_ex_reg_u.rs2_data
    TOP.id_tb.id_ex_reg_u.rs1_addr_ex
    TOP.id_tb.id_ex_reg_u.rs2_addr_ex
    TOP.id_tb.id_ex_reg_u.rd_addr_ex
    # ex stage control bits
    TOP.id_tb.id_ex_reg_u.alu_op_ex
    TOP.id_tb.id_ex_reg_u.alu_src_ex
    # mem stage control bits
    TOP.id_tb.id_ex_reg_u.mem_read_ex
    TOP.id_tb.id_ex_reg_u.mem_write_ex
    TOP.id_tb.id_ex_reg_u.mask_ex
    TOP.id_tb.id_ex_reg_u.unsigned_load_ex
    # wb stage control bits
    TOP.id_tb.id_ex_reg_u.reg_write_ex
    TOP.id_tb.id_ex_reg_u.mem_to_reg_ex
}
set id_inner {
    # view instruction segment
    TOP.id_tb.id_u.opcode
    TOP.id_tb.id_u.funct3
    TOP.id_tb.id_u.funct7
    # view imm & branch res
    TOP.id_tb.id_u.I_imm
    TOP.id_tb.id_u.sext_shift_B_imm
    TOP.id_tb.id_u.sext_shift_J_imm
    TOP.id_tb.id_u.branch_taken
    TOP.id_tb.id_u.branch_addr
    TOP.id_tb.id_u.pc_next
    TOP.id_tb.id_u.pc_bra
    TOP.id_tb.id_u.pc_jal
    TOP.id_tb.id_u.pc_jalr
}

proc set_signal_format {signals format} {
    foreach signal $signals {
        gtkwave::highlightSignalsFromList $signal
        gtkwave::/Edit/Signal_Format $format
        gtkwave::/Edit/UnHighlight_All
    }
}

set decimal_signals {
    # ex stage control bits
    TOP.id_tb.id_ex_reg_u.alu_op_ex
    TOP.id_tb.id_ex_reg_u.alu_src_ex
    # mem stage control bits
    TOP.id_tb.id_ex_reg_u.mem_read_ex
    TOP.id_tb.id_ex_reg_u.mem_write_ex
    TOP.id_tb.id_ex_reg_u.mask_ex
    TOP.id_tb.id_ex_reg_u.unsigned_load_ex
    # wb stage control bits
    TOP.id_tb.id_ex_reg_u.reg_write_ex
    TOP.id_tb.id_ex_reg_u.mem_to_reg_ex
}
# some bug in format convert
#set_signal_format $decimal_signals Decimal

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

# view signals in id stage
gtkwave::addSignalsFromList $id_inner
gtkwave::highlightSignalsFromList $id_inner
gtkwave::/Edit/Color_Format/Green
gtkwave::/Edit/UnHighlight_All


# view signals in id/ex regfile
gtkwave::addSignalsFromList $id_ex_reg_output
gtkwave::highlightSignalsFromList $id_ex_reg_output
gtkwave::/Edit/Color_Format/Yellow
gtkwave::/Edit/UnHighlight_All

# 设置波形窗口的显示范围（可选）
gtkwave::setZoomFactor 10
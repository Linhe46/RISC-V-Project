//%
// Register file used in ID and WB stages
// x0 is hardwared zero
// Use read-after-write in a combinational way

/* verilator lint_off WIDTHEXPAND */
`include "defines.sv"
module registers(
	input logic      clk,
	input logic      rst,
	input logic      wr_en,
	input logic      rs2_rd_en,
	input logic      rs1_rd_en,
	input logic[4:0] rd2_addr,
	input logic[4:0] rd1_addr,
	input logic[4:0] wr_addr,
	input logic[4:0] wr_data,
	
	output logic[31:0] rd2_data,
	output logic[31:0] rd1_data
);

    logic[31:0] regfile_initial[0:31];
	logic[31:0]	regfile[0:31];
	initial begin
		$readmemb("registers.txt", regfile_initial);
	end

    /* write logic */
	always_ff @(posedge clk) begin
		if(rst) begin
			for(int i = 0; i < 32; i++) begin
				//regfile[i] <= 32'b0;
				regfile[i] <= regfile_initial[i];
			end
		end
		else begin
			if(wr_en) begin
				regfile[wr_addr] <= (wr_addr == 5'b0 ? 32'b0 : wr_data);
			end
		end
	end
		
	/* read logic */
	always_comb begin
		rd2_data = 32'b0;
		if(rd2_addr == wr_addr && wr_en)
			rd2_data = rs2_rd_en ? wr_data : `REG_DATA_ZERO;		// read after write 
		else
			rd2_data = rs2_rd_en ? regfile[rd2_addr] : `REG_DATA_ZERO;
	end
	always_comb begin
		rd1_data = 32'b0;
		if(rd1_addr == wr_addr && wr_en)
			rd1_data = rs1_rd_en ? wr_data : `REG_DATA_ZERO;		// read after write
		else
			//rd1_data = rs1_rd_en ? regfile[rd1_addr] : `REG_DATA_ZERO;
			rd1_data = regfile[rd1_addr];
	end

endmodule

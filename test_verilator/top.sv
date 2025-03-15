`timescale 1ns/1ps
module edge_detect (
    input logic clk,
    input logic rst_n,
    input logic a,

    output logic rise,
    output logic down
);
    logic a_dely;
    always_ff @(posedge clk) begin
        if(~rst_n) begin
            rise <= 0;
            down <= 0;
            a_dely <= 0;
        end  
        else begin
            a_dely <= a;
            if(~a_dely & a) begin
                down <= 0;
                rise <= 1;
            end
            else if(a_dely & ~a) begin
                down <= 1;
                rise <= 0;
            end
            else begin
                rise <= 0;
                down <= 0;
            end
        end
    end
endmodule

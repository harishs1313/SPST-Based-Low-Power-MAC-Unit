`timescale 1ns / 1ps

module SPSTMAC(
    input clk,
    input rst_n,
    input start,
    input [15:0] A,
    input [15:0] B,
    output reg done,
    output reg [31:0] result
);
    reg [31:0] acc;
    reg [15:0] multi;
    reg [4:0] cycle;
    reg running;
    
    wire [31:0] pp;
    wire [31:0] pp_shift;
    
    assign pp = (multi[0] == 1'b1) ? {16'b0, A} : 32'b0;
    assign pp_shift = pp << cycle;
    
    always@(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            acc <= 32'b0;
            multi <= 16'b0;
            cycle <= 5'd0;
            running <= 1'b0;
            done <= 1'b0;
            result <= 32'b0;
         end
         else begin
         if(start && !running)begin
                acc <= 32'b0;
                multi <= B;
                cycle <= 5'd0;
                running <= 1'b1;
                done <= 1'b0;
                result <= 32'b0;
          end
          else if(running)begin
            if(pp_shift != 32'b0)begin
                acc <= acc + pp_shift;
            end    
            multi <= multi >> 1;
            
            cycle <= cycle + 1;
            
            if (cycle == 15)begin
                running <= 1'b0;
                done <= 1'b1;
                result <= acc + pp_shift;
            end
            
          end
          
          else begin
            done <= 1'b0;
          end
          
        end
      end
endmodule

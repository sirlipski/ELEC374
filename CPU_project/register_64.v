// File Name: register_64.v

`timescale 1ns/10ps
module register_64(clr, clk, R_in, BusMuxOut, BusMuxIn_R_hi, BusMuxIn_R_lo);
	input clr, clk, R_in;
	input [63:0] BusMuxOut;
	output reg [31:0] BusMuxIn_R_hi, BusMuxIn_R_lo;
	
initial BusMuxIn_R_hi = 0;
initial BusMuxIn_R_lo = 0;
reg [63:0] RegValue = 0;

always@(posedge clk)
	begin
		if(clr) begin
			RegValue = 0;
			BusMuxIn_R_hi = 32'b0;
			BusMuxIn_R_lo = 32'b0;
		end
		else if(R_in) begin
			RegValue[63:0] = BusMuxOut[63:0];
			BusMuxIn_R_hi[31:0] = RegValue[63:32]; 
			BusMuxIn_R_lo[31:0] = RegValue[31:0]; 
		end
	end
endmodule
	
	
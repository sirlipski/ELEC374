// File Name: pc_reg_32.v

`timescale 1ns/10ps
module pc_reg_32(clk, clr, IncPC, PC_in, BusMuxOut, pc_data_out);
	input clr, clk, IncPC, PC_in;
	input [31:0] BusMuxOut;
	output reg [31:0] pc_data_out;
	
	reg [31:0] RegValue;
	
initial RegValue = 0;
initial pc_data_out = 0;
	
	
always@(posedge clk)
	begin
		if (clk) begin
			if(clr)
				RegValue <= 32'b0;
			else begin
				if(IncPC && PC_in) begin
					RegValue = BusMuxOut + 1;
					pc_data_out = RegValue;
				end
				else if(PC_in) begin
					RegValue <= BusMuxOut;
					pc_data_out <= RegValue;
				end
				else if(IncPC)begin
					RegValue = RegValue + 1;
					pc_data_out <= RegValue;
				end
			end
		end
	end
endmodule
	
	

	
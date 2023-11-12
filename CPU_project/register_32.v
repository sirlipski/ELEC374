// File Name: register_32.v

module register_32(clk, clr, R_in, BusMuxOut, BusMuxIn_R);
	input wire clk, clr, R_in;
	input wire [31:0] BusMuxOut;
	output reg [31:0] BusMuxIn_R;
	
	reg [31:0] RegValue = 0;
	initial BusMuxIn_R = 0;
	
always@(posedge clk)
	begin
		if(clr)
			BusMuxIn_R = 32'b0;
		else if(R_in) begin
			
			RegValue[31:0] = BusMuxOut[31:0];
			BusMuxIn_R[31:0] = RegValue[31:0]; 
		end
	end
endmodule
	
	
	
	
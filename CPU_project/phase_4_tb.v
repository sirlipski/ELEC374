`timescale 1ns/10ps

module phase_4_tb;
	reg clk, rst, stop;
	wire[31:0] OutPort_output, busOut, Mdata;
	reg [31:0] InPort_input;
	wire run;

datapath DUT(
	.clk(clk),
	.rst(rst),
	.stop(stop),
	.InPort_input(InPort_input),
	.OutPort_output(OutPort_output), 
	.busOut(busOut), 
	.Mdata(Mdata),
	.Run(run)
);
 

initial
	begin
		clk = 0;
		rst = 0;
		InPort_input <= 8'h88;
end

always
begin
		#10 clk <= ~clk;
		
		
		if(stop) $finish;
end
endmodule



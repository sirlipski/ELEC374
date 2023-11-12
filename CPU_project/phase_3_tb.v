`timescale 1ns/10ps

module phase_3_tb;
	reg clk, rst, stop;
	wire[31:0] InPort_input, OutPort_output, busOut, Mdata;
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
end

always
begin
		#10 clk <= ~clk;
		
		
		if(stop) $finish;
end
endmodule



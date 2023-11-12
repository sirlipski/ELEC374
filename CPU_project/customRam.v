	`timescale 1ns/10ps

module customRam(
	address,
	clock,
	data,
	rden,
	wren,
	q);

	input	[8:0]  address;
	input	  clock;
	input	[31:0]  data;
	input	  rden;
	input	  wren;
	output	[31:0]  q;
	
	reg [8:0] tempAddress;
	reg [31:0] memRam[511:0];
	
	initial begin : INIT
		$readmemh("init.mif", memRam); 
	end
	
	always @(posedge clock)
	begin
		if (wren)
			memRam[address] <= data;
		tempAddress <= address;
	end
	assign q = memRam[tempAddress];
endmodule
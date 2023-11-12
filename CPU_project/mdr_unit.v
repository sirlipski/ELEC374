//filename mdr_unit.v

module mdr_unit(
	input clk, clr, R_in, read,
	input [31:0] Mdatain, bus,
	output reg [31:0] MDR_out
);

reg [31:0] MDR_data;


always@(posedge clk)
begin
	if(clr)begin
		MDR_out = 0;
		MDR_data = 0;
	end
	else if(R_in)begin
		
		if(read)
			MDR_data = Mdatain;
		else
			MDR_data = bus;
	end
	MDR_out = MDR_data;
	$display("MDR contents: %h", MDR_data);
end
endmodule
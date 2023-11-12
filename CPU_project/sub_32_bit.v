module sub_32_bit(
	input [31:0] A, 
	input [31:0] B, 
	input  cin, 
	output wire[31:0] diff, 
	output cout);
	
	CLA_adder_32_bit result(A, -B, 1'b0, diff, cout);

endmodule
module CLA_adder_32_bit(
input [31:0] A, 
input [31:0] B, 
input  cin, 
output wire[31:0] Sum, 
output cout);
	wire cout1;

	CLA_16bit CLA1(A[15:0], B[15:0], cin, Sum[15:0], cout1);
	CLA_16bit CLA2(A[31:16], B[31:16], cout1, Sum[31:16], cout);

endmodule

module CLA_16bit(
	input wire [15:0] A, 
	input wire [15:0] B, 
	input wire cin, 
	output wire [15:0] Sum, 
	output wire cout);
	
	wire cout1,cout2,cout3;

	CLA_4bit CLA1(A[3:0], B[3:0], cin, Sum[3:0], cout1);
	CLA_4bit CLA2(A[7:4], B[7:4], cout1, Sum[7:4], cout2);
	CLA_4bit CLA3(A[11:8], B[11:8], cout2, Sum[11:8], cout3);
	CLA_4bit CLA4(A[15:12], B[15:12], cout3, Sum[15:12], cout);

endmodule

module CLA_4bit(input wire [3:0] A, 
	input wire [3:0] B, 
	input wire cin, 
	output wire[3:0] Sum, 
	output wire cout);
	
	wire [3:0] P,G,c;

	assign P=A^B;	
	assign G=A&B;
	assign c[0]= cin;
	assign c[1]= G[0] | (P[0]&c[0]);
	assign c[2]= G[1] | (P[1]&G[0]) | P[1]&P[0]&c[0];
	assign c[3]= G[2] | (P[2]&G[1]) | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&c[0];
	assign cout = G[3] | (P[3]&G[2]) | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&c[0];
	assign Sum[3:0] =P^c;
	
endmodule
  
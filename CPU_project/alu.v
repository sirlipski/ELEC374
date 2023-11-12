// filename alu.v

module alu(
    input wire  signed [31:0] A_reg, 
	 input wire [31:0] B_reg, 
    input [4:0] opcode,
	 input Zin,
    output reg [63:0] Z_reg
);

parameter ADD =5'b00011, SUB =5'b00100, AND =5'b00101, OR =5'b00110, MUL =5'b01111, DIV = 5'b10000, 
SHR = 5'b00111, SHRA = 5'b01000, SHL = 5'b01001, ROR = 5'b01010, ROL = 5'b01011, NEG = 5'b10001, NOT = 5'b10010;

//wire [31:0] IncPC_out, shr_out, shra_out, shl_out, ror_out, rol_out, neg_out, not_out, add_out, sub_out, and_out, or_out;
wire [63:0] mul_out, div_out;
wire [31:0] ror_out, rol_out;
wire [31:0] add_out, sub_out;

reg [31:0] ResHi, ResLo;
wire cout;

initial ResHi = 0;
initial ResLo = 0;

//assign Z_reg = {ResHi, ResLo};

mul_unit mul_val(.Q(A_reg), .b(B_reg), .z(mul_out));
div_unit div_val(.Q(A_reg), .M(B_reg), .z(div_out));
ror_unit ror_val(.in(A_reg), .numRotateBits(B_reg[4:0]), .out(ror_out));
rol_unit rol_val(.in(A_reg), .numRotateBits(B_reg[4:0]), .out(rol_out));
CLA_adder_32_bit adder(A_reg, B_reg, 1'b0, add_out, cout);
sub_32_bit subtractor(A_reg, B_reg, 1'b0, sub_out, cout);

always@(*)
    begin
		 if(Zin) begin
			  case(opcode)
					ADD: ResLo <= add_out;
					SUB: ResLo <= sub_out;
					AND: ResLo <= A_reg & B_reg;
					OR: ResLo <= A_reg | B_reg;
					MUL: {ResHi, ResLo} <= mul_out;
					DIV: {ResHi, ResLo} <= div_out;
					SHR: ResLo <= A_reg >> B_reg;
					SHRA: ResLo <= A_reg >>> B_reg;
					SHL: ResLo <= A_reg << B_reg;
					ROR: ResLo <= ror_out;
					ROL: ResLo <= rol_out;
					NEG: ResLo <= ~B_reg+1;
					NOT: ResLo <= ~B_reg;
					default: begin
						ResLo <= B_reg;
						ResHi <= 0;
					end
			  endcase
			  Z_reg <= {ResHi, ResLo};
		end
    end
endmodule


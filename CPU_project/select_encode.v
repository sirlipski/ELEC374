module select_encode(
	input wire Gra, Grb, Grc, Rin, Rout, BAout,
	input wire [31:0] IR,
	output reg R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
	output reg R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in,
	output reg [31:0] C_sign_extended
	);

wire [15:0] dec_output;

wire [3:0] output_y;
wire ba_or_r;

assign output_y = (IR[26:23]&{4{Gra}}) | (IR[22:19]&{4{Grb}}) | (IR[18:15]&{4{Grc}});
assign ba_or_r = Rout | BAout;

decoder_4_to_16 dec(.a(output_y), .b(dec_output));
always @(*)
begin
	C_sign_extended[18:0] = IR[18:0];
	if(IR[18] != 1)
		C_sign_extended[31:19] = 13'b0000000000000;
	else
		C_sign_extended[31:19] = 13'b1111111111111;

	R0in = Rin & dec_output[0];
	R1in = Rin & dec_output[1];
	R2in = Rin & dec_output[2];
	R3in = Rin & dec_output[3];
	R4in = Rin & dec_output[4];
	R5in = Rin & dec_output[5];
	R6in = Rin & dec_output[6];
	R7in = Rin & dec_output[7];
	R8in = Rin & dec_output[8];
	R9in = Rin & dec_output[9];
	R10in = Rin & dec_output[10];
	R11in = Rin & dec_output[11];
	R12in = Rin & dec_output[12];
	R13in = Rin & dec_output[13];
	R14in = Rin & dec_output[14];
	R15in = Rin & dec_output[15];

	R0out = ba_or_r & dec_output[0];
	R1out = ba_or_r & dec_output[1];
	R2out = ba_or_r & dec_output[2];
	R3out = ba_or_r & dec_output[3];
	R4out = ba_or_r & dec_output[4];
	R5out = ba_or_r & dec_output[5];
	R6out = ba_or_r & dec_output[6];
	R7out = ba_or_r & dec_output[7];
	R8out = ba_or_r & dec_output[8];
	R9out = ba_or_r & dec_output[9];
	R10out = ba_or_r & dec_output[10];
	R11out = ba_or_r & dec_output[11];
	R12out = ba_or_r & dec_output[12];
	R13out = ba_or_r & dec_output[13];
	R14out = ba_or_r & dec_output[14];
	R15out = ba_or_r & dec_output[15];
end

endmodule

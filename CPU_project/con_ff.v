module con_ff(
	input wire [31:0] bus,
	input wire [1:0] IR,
	input wire con_in,
	output reg result
);

wire is_pos, is_zero;
reg ff_input;
assign is_zero = (bus == 32'b0);
assign is_pos = ~bus[31];

//flip_flop ff(ff_input, con_in, result);

always @(*) begin
if (con_in) begin
case(IR)
	4'b00 : ff_input <= is_zero;
	4'b01 : ff_input <= ~is_zero;
	4'b10 : ff_input <= is_pos;
	4'b11 : ff_input <= ~is_pos;
endcase
result <= ff_input;
end
end


endmodule

module flip_flop(
	input wire D,
	input wire en,
	output reg Q,
	output reg Q_not
);
always @(*)
begin
Q_not = ~Q;
	if(en) Q <= D;
end
endmodule

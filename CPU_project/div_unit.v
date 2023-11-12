module div_unit(input signed [31:0] Q, M, output reg [32*2-1:0] z);
	reg [63:32] high, low;
	always @ (*)
	begin
		high = Q % M;
		low = (Q - high) / M;
		begin
			z = {high, low};
		end
	end
				
endmodule

//filename mul_unit.v

`timescale 1ns/ 1ps
 
module mul_unit(

    input signed [31:0] Q, b, output[63:0] z); //Q is the multiplicand, b is the multiplier, z is the product
	reg [2:0] currentM[15:0]; //stores the 3 bits of b that are currently being multiplied
	reg [32:0] currentP[15:0]; //stores the product of the current 3 bits of b and Q
	reg[63:0] currentSP[15:0]; //stores the signed product of the current 3 bits of b and Q
	
	reg [63:0] product; //stores the final product
	
	integer j,i; //counters
	
	wire [32:0] inv_Q; //stores the 2's complement of Q
	assign inv_Q = {~Q[31], ~Q} +1; //calculates the 2's complement of Q
	
	always @ (Q or b or inv_Q)  //when Q, b, or the 2's complement of Q changes
	begin
		
		currentM[0] = {b[1], b[0], 1'b0}; //stores the first 2 bits of b in currentM[0]
		
		for (j=1; j < (16); j = j+1) //stores the next 2 bits of b in currentM[1], etc.
			currentM[j] = {b[2*j+1], b[2*j], b[2*j-1]}; 
			
		for (j=0; j < (16); j = j+1) //for each 2 bits of b
		begin	
			case(currentM[j]) 
				//6 different cases for the 3 current bits
				3'b001 : currentP[j] = {Q[32-1], Q};  //if the 3 bits are 001, then the product is Q
				3'b010 : currentP[j] = {Q[32-1], Q}; //if the 3 bits are 010, then the product is Q
				3'b011 : currentP[j] = {Q, 1'b0}; //if the 3 bits are 011, then the product is Q shifted left by 1
				3'b100 : currentP[j] = {inv_Q[32-1:0], 1'b0}; //if the 3 bits are 100, then the product is -Q shifted left by 1
				3'b101 : currentP[j] = inv_Q; //if the 3 bits are 101, then the product is -Q
				3'b110 : currentP[j] = inv_Q; //if the 3 bits are 110, then the product is -Q
				default : currentP[j] = 0;
			endcase
			currentSP[j] = $signed(currentP[j]); //converts the product to a signed number
			
			for (i=0 ; i<j ; i = i + 1) //shifts the product left by j
				currentSP[j] = {currentSP[j], 2'b00}; 
		end
	
		product = currentSP[0]; //initializes the product to the first 2 bits of b
	
		for (j=1; j < (16); j = j+1) //adds the rest of the products together
			product = product + currentSP[j];
	end
	assign z = product;	//assigns the product to the output
endmodule
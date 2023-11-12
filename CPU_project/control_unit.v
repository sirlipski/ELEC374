`timescale 1ns/10ps
module control_unit (
	output reg Gra, Grb, Grc, Rin, 
	BAout, Rout, Cout, OutputPortIn, MDRin, IRin, PCin, CONin, HIin, LOin,// define the inputs and outputs to your Control Unit
	Yin, Zin, PCout, IncPC, MARin, MDRout, Zhiout, Zlowout, HIout, LOout, stackEnable,
	Read, Write, InputPortOut, Clear, RunOut,
	output reg [4:0] opcode,
	input [31:0] IR,
	input Clock, Reset, Stop, Con_FF
);

parameter ADD =5'b00011, SUB =5'b00100, AND =5'b00101, OR =5'b00110, MUL =5'b01111, DIV = 5'b10000, 
SHR = 5'b00111, SHRA = 5'b01000, SHL = 5'b01001, ROR = 5'b01010, ROL = 5'b01011, NEG = 5'b10001, NOT = 5'b10010;

	parameter reset_state = 7'b0000000, 
          fetch0 = 7'b0000001, fetch1 = 7'b0000010, fetch2 = 7'b0000011,
          add3 = 7'b0000100, add4 = 7'b0000101, add5 = 7'b0000110, 
          and3 = 7'b0000111, and4 = 7'b0001000, and5 = 7'b0001001,
          or3 = 7'b0001010,or4 = 7'b0001011,or5 = 7'b0001100,
          sub3 = 7'b0001101,sub4 = 7'b0001110,sub5 = 7'b0001111,
          mul3 = 7'b0010000,mul4 = 7'b0010001,mul5 = 7'b0010010,mul6 = 7'b0010011,
          div3 = 7'b0010100,div4 = 7'b0010101,div5 = 7'b0010110,div6 = 7'b0010111,
          not3 = 7'b0011000,not4 = 7'b0011001,
          neg3 = 7'b0011010,neg4 = 7'b0011011,
          shl3 = 7'b0011100,shl4 = 7'b0011101,shl5 = 7'b0011110,
          ror3 = 7'b0011111,ror4 = 7'b0100000,ror5 = 7'b0100001,
          rol3 = 7'b0100010,rol4 = 7'b0100011,rol5 = 7'b0100100,
          shr3 = 7'b0100101,shr4 = 7'b0100110,shr5 = 7'b0100111,
          shra3 = 7'b0101000,shra4 = 7'b0101001,shra5 = 7'b0101010,
          ld3 = 7'b0101011,ld4 = 7'b0101100,ld5 = 7'b0101101,ld6 = 7'b0101110,ld7 = 7'b0101111,
          ldi3 = 7'b0110000,ldi4 = 7'b0110001,ldi5 = 7'b0110010,
          st3 = 7'b0110011,st4 = 7'b0110100,st5 = 7'b0110101,st6 = 7'b0110110,st7 = 7'b0110111,
          addi3 = 7'b0111000,addi4 = 7'b0111001,addi5 = 7'b0111010,
          andi3 = 7'b0111011, andi4 = 7'b0111100, andi5 = 7'b0111101,
          ori3 = 7'b0111110,ori4 = 7'b0111111,ori5 = 7'b1000000,
          br3 = 7'b1000001,br4 = 7'b1000010, br5 = 7'b1000011, br6 = 7'b1000100, 
          jr3 = 7'b1000101,
          jal3 = 7'b1000110,jal4 = 7'b1000111,
          mfhi3 = 7'b1001000,
          mflo3 = 7'b1001001,
          in3 = 7'b1001010,
          out3 = 7'b1001011,
			 halt = 7'b1001100;
	reg [6:0] present_state = reset_state; // adjust the bit pattern based on the number of states
always @(posedge Clock, posedge Reset, posedge Stop) // finite state machine; if clock or reset rising-edge
begin
	if (Reset == 1'b1)begin
		present_state = reset_state;
	end
	else if(Stop) 
		present_state = halt;
	else case (present_state) 
		reset_state : # 60 present_state = fetch0;
		fetch0 : #80  present_state = fetch1;
		fetch1 : #60  present_state = fetch2;
		fetch2 : #60 begin
			$display("IR: %b", IR[31:27]);
						case (IR[31:27]) // inst. decoding based on the opcode to set the next state
							5'b00011 :   present_state = add3; // this is the add instruction
							5'b00100 :   present_state = sub3;
							5'b00101 :   present_state = and3;
							5'b00110 :   present_state = or3;
							5'b00111 :   present_state = shr3;
							5'b01000 :   present_state = shra3;
							5'b01001 :   present_state = shl3;
							5'b01010 :   present_state = ror3;
							5'b01011 :   present_state = rol3;
							5'b01100 :   present_state = addi3;
							5'b01101 :   present_state = andi3;
							5'b01110 :   present_state = ori3;
							5'b01111 :   present_state = mul3;
							5'b10000 :   present_state = div3;
							5'b10001 :   present_state = neg3;
							5'b10010 :   present_state = not3;
							5'b00000 :   present_state = ld3;
							5'b00001 :   present_state = ldi3;
							5'b00010 :   present_state = st3;
							5'b10011 :   present_state = br3;
							5'b10100 :   present_state = jr3;
							5'b10101 :   present_state = jal3;
							5'b10110 :   present_state = in3;
							5'b10111 :   present_state = out3;
							5'b11000 :   present_state = mfhi3;
							5'b11001 :   present_state = mflo3;
							5'b11011 : 	 present_state = halt;
							default  :   present_state = fetch0;
						endcase
					end
		add3  : #60  present_state = add4;
		add4  : #60  present_state = add5;
		  
		sub3  : #60  present_state = sub4;
		sub4  : #60  present_state = sub5;
		  
		and3  : #60  present_state = and4;
		and4  : #60  present_state = and5;
		
		or3   : #60  present_state = or4;
		or4   : #60  present_state = or5;
		
		mul3  : #60  	present_state = mul4;
		mul4  : #60  	present_state = mul5;
		mul5  : #60  	present_state = mul6;
		  
		div3  : #60  	present_state = div4;
		div4  : #60  	present_state = div5;
		div5  : #60  	present_state = div6;
		  
		shl3  : #60  	present_state = shl4;
		shl4  : #60  	present_state = shl5;
		  
		shr3  : #60  	present_state = shr4;
		shr4  : #60  	present_state = shr5;
		
		shra3 : #60  	present_state = shra4;
		shra4 : #60  	present_state = shra5;
		
		rol3	: #60  	present_state = rol4;
		rol4	: #60  	present_state = rol5;
		
		ror3	: #60  	present_state = ror4;
		ror4	: #60  	present_state = ror5;
		
		neg3	: #60  	present_state = neg4;
		
		not3	: #60  	present_state = not4;
		
		ld3 : #60  present_state = ld4;
		ld4 : #60  present_state = ld5;
		ld5 : #60  present_state = ld6;
		ld6 : #60  present_state = ld7;
		
		ldi3 : #60  present_state = ldi4;
		ldi4 : #60  present_state = ldi5;
		
		st3 : #60  present_state = st4;
		st4 : #60  present_state = st5;
		st5 : #80  present_state = st6;
		st6 : #60  present_state = st7;

		addi3 : #60  present_state = addi4;
		addi4 : #60  present_state = addi5;

		andi3 : #60  present_state = andi4;
		andi4 : #60  present_state = andi5;

		ori3 : #60  present_state = ori4;
		ori4 : #60  present_state = ori5;

		br3  : #60  	present_state = br4;
		br4  : #60  	present_state = br5;
		br5  : #60  	present_state = br6;
		
		jal3 : #60  present_state = jal4;
		
		
		default: #60  present_state = fetch0;
		
	endcase
end
always @(present_state) // do the job for each state
begin
	case (present_state) // assert the required signals in each state
		reset_state: begin
			Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; 
			BAout <= 0; Rout <= 0; Cout <= 0; OutputPortIn <= 0; MDRin <= 0; IRin <= 0; PCin <= 0; CONin <= 0; HIin <= 0; LOin <= 0;// define the inputs and outputs to your Control Unit
			Yin <= 0; Zin <= 0; PCout <= 0; IncPC <= 0; MARin <= 0; MDRout <= 0; Zhiout <= 0; Zlowout <= 0; HIout <= 0; LOout <= 0; stackEnable <= 0; opcode <= 5'b11111;
			Read <= 0; Write <= 0; RunOut <= 1; InputPortOut <= 0; PCin <= 1; Clear <= 1; #21 PCin <=0; Clear <= 0;
		end
		// Fetch
		fetch0: begin
		Gra <= 0; Grb <= 0; Grc <= 0; Rin <= 0; 
			BAout <= 0; Rout <= 0; Cout <= 0; OutputPortIn <= 0; MDRin <= 0; IRin <= 0; PCin <= 0; CONin <= 0; HIin <= 0; LOin <= 0;// define the inputs and outputs to your Control Unit
			Yin <= 0; IncPC <= 0; MDRout <= 0; Zhiout <= 0; Zlowout <= 0; HIout <= 0; LOout <= 0; stackEnable <= 0; opcode <= 5'b11111; Read <= 0; Write <= 0; InputPortOut <= 0;
			
			PCout <= 1;Zin <= 1; // see if you need to de-assert these signals
			MARin <= 1; #22 MARin <= 0;  IncPC <= 1; #20 IncPC <= 0;
		end
		fetch1: begin
			PCout <= 0; MARin <= 0; Zin <= 0; 
			Zlowout <= 1; Read <= 1; MDRin <= 1; PCin <= 1; 
		end
		fetch2: begin
			Zlowout <= 0; Read <= 0; MDRin <= 0; PCin <= 0;
			MDRout <= 1; IRin <= 1; 
		end
		// Add /  Sub
		add3, sub3: begin	
			MDRout <= 0; IRin <= 0; PCin <= 0; IncPC <= 0;
			Grb <= 1; Rout <= 1; Yin <= 1;
		end
		add4, sub4: begin
			Grb <= 0; Rout <= 0; Yin <= 0;
			Grc<=1; Rout <= 1; Zin <= 1; opcode <= IR[31:27];
		end
		add5, sub5: begin
			Grc<=0; Rout <= 0; Zin <= 0;
			Zlowout <= 1; Gra<=1; Rin<=1;
		end
		
		// Or, And, shl, shra, shr, ror, rol
		or3, and3, shl3, shr3, shra3, rol3, ror3: begin	
			MDRout <= 0; IRin <= 0;PCin <= 0; IncPC <= 0;
			Grb<=1; Rout<=1; Yin<=1;
		end
		or4, and4, shl4, shr4, shra4, rol4, ror4: begin
			Grb<=0;Rout<=0;Yin<=0;
			Grc<=1; Rout <= 1;Zin <= 1; opcode <= IR[31:27];
		end
		or5, and5, shl5, shr5, shra5, rol5, ror5: begin
			Grc<=0; Rout <= 0;Zin <= 0;
			Zlowout <= 1; Gra<=1; Rin<=1;
			#40 Zlowout <= 0;Gra<=1;Rout<=1;Rin<=0;
		end
		
		// Mul / Div
		mul3, div3: begin	
			MDRout <= 0; IRin <= 0;PCin <= 0; IncPC <= 0;
			Gra <= 1; Rout <= 1;Yin <= 1;  
			
		end
		mul4, div4: begin
			Gra <= 0; Rout <= 0; Yin <= 0;
			Grb<=1; Rout <= 1;Zin <= 1; opcode <= IR[31:27];
				
		end
		mul5, div5: begin
			Grb<=0; Rout<=0; Zin <= 0;
			Zlowout<=1; LOin <= 1;
				
		end
		
		mul6, div6: begin
			Zlowout<= 0; LOin <= 0;
			Zhiout<= 1; HIin <= 1; 
		end
		
		// Neg / Not
		not3, neg3: begin	
			MDRout <= 0; IRin <= 0;PCin <= 0; IncPC <= 0;
			Grb<=1; Rout <= 1;Zin <= 1; opcode <= IR[31:27];
		end
		
		not4, neg4: begin
			Grb<=0; Rout <= 0; Zin <= 0;
			Zlowout <= 1; Gra<=1; Rin<=1;
		end
		
		// addi
		addi3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;	
			Grb<=1; Rout<=1; Yin<=1; 
		end

		addi4: begin
			Grb<=0; Rout<=0; Yin<=0;
			Cout<=1; Zin <= 1; opcode <= ADD;
		end

		addi5: begin
			Cout<=0; Zin <= 0;
			Zlowout <= 1; Gra<=1; Rin<=1;
			#40 Zlowout <= 0; Gra<=1; Rout<=1; Rin<=0;
		end
		
		// andi
		andi3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;	
			Grb<=1; Rout<=1; Yin<=1;
		end

		andi4: begin
			Grb<=0;Rout<=0;Yin<=0;
			Cout<=1; Zin <= 1; opcode <= AND;
		end

		andi5: begin
			Cout<=0; Zin <= 0;
			Zlowout <= 1;Gra<=1;Rin<=1;
			#40 Zlowout <= 0; Gra<=1; Rout<=1; Rin<=0;
		end
		
		// ori
		ori3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;	
			Grb<=1; Rout<=1; Yin<=1;
		end

		ori4: begin
			Grb<=0; Rout<=0; Yin<=0;
			Cout<=1; Zin <= 1; opcode <= OR;
		end

		ori5: begin
			Cout<=0; Zin <= 0;
			Zlowout <= 1; Gra<=1; Rin<=1;
			#40 Zlowout <= 0; Gra<=1; Rout<=1; Rin<=0;
		end
		
		// ld
		ld3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;	
			Grb<=1; BAout<=1; Yin<=1;
		end

		ld4: begin
			Grb<=0;BAout<=0;Yin<=0;
			Cout<=1;Zin <= 1; opcode <= ADD;
		end

		ld5: begin
			Cout<=0; Zin <= 0;
			Zlowout <= 1; MARin<=1;
		end

		ld6: begin
			Zlowout <= 0; MARin <= 0;
			Read <= 1; MDRin <= 1;
		end
		ld7: begin
			Read <= 0; MDRin <= 0;
			MDRout <= 1; Gra <= 1; Rin <= 1;
		end
		
		// ldi
		ldi3: begin
			MDRout <= 0; IRin <= 0;PCin <= 0; IncPC <= 0;			
			Grb<=1;BAout<=1;Yin<=1;
		end

		ldi4: begin
			Grb<=0;BAout<=0;Yin<=0;
			Cout<=1;Zin <= 1; opcode <= ADD;
		end

		ldi5: begin
			Cout<=0; Zin <= 0;
			Zlowout <= 1;Gra<=1;Rin<=1;
			#40 Zlowout <= 0; Gra<=0; Rin<=0; 
		end
		
		// st 
		st3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;		
			Grb<=1;BAout<=1;Yin<=1;
		end

		st4: begin
			Grb<=0;BAout<=0;Yin<=0;
			Cout<=1;Zin <= 1; opcode <= ADD;
		end

		st5: begin
			Cout<=0; Zin <= 0;
			Zlowout <= 1;MARin<=1;
		end

		st6: begin
			Zlowout <= 0; MARin <= 0;
			Read <= 0; Gra <= 1; Rout <= 1; MDRin <= 1;
		end
		
		st7: begin
			Gra <= 0; Rout <= 0; MDRin <= 0;
			MDRout <= 1; #5 Write <= 1; 
		end
		
		// br
		br3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;		
			Gra<=1; Rout<=1; CONin<=1; #21 CONin<=0;
		end

		br4: begin
			Gra<=0; Rout<=0; CONin<=0;
			PCout<=1; Yin <= 1;
		end

		br5: begin
			PCout<=0; Yin <= 0;
			Cout <= 1; opcode <= ADD; Zin <= Con_FF ? 1 : 0;
		end

		br6: begin
			Cout <= 0; Zin <= 0;
			Zlowout<=1; PCin<=1;
		end
		
		// jr
		jr3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;				
			Gra<=1;Rout<=1; PCin <= 1;
		end
		
		// jal
		jal3: begin
			MDRout <= 0; IRin <= 0; PCin <= 0;IncPC <= 0;	
			PCout <= 1; stackEnable <= 1;
		end

		jal4: begin
			PCout <= 0; stackEnable <= 0;
			Gra<=1; Rout <= 1; PCin <= 1;
		end
		
		// mfhi
		mfhi3: begin
			MDRout <= 0; IRin <= 0;		PCin <= 0; IncPC <= 0;	
			Gra<=1; Rin<=1; HIout<=1;
			#40 Gra<=0; Rin<=0; HIout<=0;
		end
		
		// mflo
		mflo3: begin
			MDRout <= 0; IRin <= 0; PCin <= 0; IncPC <= 0;	
			Gra<=1; Rin<=1; LOout<=1;
			#40 Gra<=0; Rin<=0; LOout<=0;
		end
		
		// in 
		in3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;
			Gra<=1; Rin<=1; InputPortOut <= 1;
		end
		
		// out
		out3: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;	
			Gra<=1; Rout<=1; Yin<=1; OutputPortIn <= 1;
		end
		
		halt: begin
			MDRout <= 0; IRin <= 0;	PCin <= 0; IncPC <= 0;
			RunOut <= 0; 
			#21 $stop;
		end
		
	endcase
end
endmodule 
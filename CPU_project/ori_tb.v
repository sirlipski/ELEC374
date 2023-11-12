	`timescale 1ns/10ps
// use 1897398325
// 0x71180035
// ori r2, r3, $35

	module ori_tb;
		reg clk, clr, rst;
		reg IncPC, CON_enable; 
		wire [31:0] Mdata;
		wire [31:0] bus_contents;
		reg RAM_write, MDR_enable, MDRout, MAR_enable, IR_enable;
		reg MDR_read;
		reg Rin, Rout;
		//reg [15:0] R0_R15_enable, R0_R15_out;
		reg Gra, Grb, Grc;
		reg HI_enable, LO_enable, Zin, Y_enable, PC_enable, InPort_enable, OutPort_enable;
		reg InPortout, PCout, Yout, ZLowout, ZHighout, LOout, HIout, BAout, Cout;
		reg [4:0] opcode;
		wire[31:0] OutPort_output;
		reg [31:0] InPort_input;
		reg stackEnable;
		
		parameter Default = 4'b0000, T0 = 4'b0111, T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100, T6 = 4'b1101, T7 = 4'b1110;
		reg [3:0] Present_state = Default;
		reg [4:0] ORI = 5'b00110;

datapath DUT(
	.PCout(PCout),
	.Z_hi_reg_out(ZHighout),
	.Z_lo_reg_out(ZLowout),  
	.MDR_reg_out(MDRout), 
	.MARin(MAR_enable), 
	.MDR_reg_in(MDR_enable),   	
	.PCin(PC_enable), 
	.IR_reg_in(IR_enable),
	.Y_reg_in(Y_enable), 
	.IncPC(IncPC),
	.Read(MDR_read),
	.clk(clk),
	.Mdata(Mdata), 	
	.clr(clr),                       
	.HI_reg_in(HI_enable),                                
	.LO_reg_in(LO_enable),
	.HI_reg_out(HIout), 
	.LO_reg_out(LOout),                		
	.Zin(Zin),
	.Cout(Cout),
	.Write(RAM_write),
	.Gra(Gra),								
	.Grb(Grb),                       
	.Grc(Grc), 
	.Rin(Rin),
	.Rout(Rout),	
	.BAout(BAout),
	.CON_enable(CON_enable),
	//.R_enableIn(R0_R15_enable), 
	//.Rout_in(R0_R15_out),
	//.Inport_data_in(InPort_enable),
	.Output_in(OutPort_enable),
	.Inport_data_in(InPort_input),
	.OutPort_output(OutPort_output),
	.busOut(bus_contents),
	.opcode(opcode),
	.InPort_out(InPortout),
	.stackEnable(stackEnable)
);

initial
	begin
		clk = 0;
		clr = 0;
end

always
		#10 clk <= ~clk;

always @(posedge clk) 
	begin
		case (Present_state)
			Default			:	#40 Present_state = T0;
			T0					:	#40 Present_state = T1;
			T1					:	#60 Present_state = T2;
			T2					:	#40 Present_state = T3;
			T3					:	#40 Present_state = T4;
			T4					:	#40 Present_state = T5;
			T5					:	#40 Present_state = T6;
			T6					:	#60 Present_state = T7;
		endcase
end

always @(Present_state) 
	begin
	#10 
		case (Present_state) //assert the required signals in each clockcycle
			Default: begin // initialize the signals
				PCout <= 0; ZLowout <= 0; MDRout <= 0; 
				MAR_enable <= 0; Zin <= 0; Zin <= 0; CON_enable<=0; 
				InPort_enable<=0; OutPort_enable<=0;
				InPort_input<=32'd0;
				PC_enable <=0; MDR_enable <= 0; IR_enable <= 0; 
				Y_enable <= 0;
				IncPC <= 0; RAM_write<=0;
				Gra<=0; Grb<=0; Grc<=0;
				BAout<=0; Cout<=0;
				InPortout<=0; ZHighout<=0; LOout<=0; HIout<=0; 
				HI_enable<=0; LO_enable<=0;
				Rout<=0;Rin<=0;MDR_read<=0;
			end	
						

T0: begin 
	PCout <= 1; MAR_enable <= 1; //Zin <= 1;
end

T1: begin //Loads MDR from RAM output
		PCout <= 0; MAR_enable <= 0; IncPC <= 0; Zin <= 0;
		ZLowout <= 1; PC_enable <= 1; MDR_read <= 1; MDR_enable <= 1;
end

T2: begin
	ZLowout <= 0; PC_enable <= 0; MDR_read <= 0; MDR_enable <= 0;
	MDRout <= 1; IR_enable <= 1; IncPC <= 1;
end

T3: begin
	MDRout <= 0; IR_enable <= 0; IncPC <= 0; 	
	Grb<=1;Rout<=1;Y_enable<=1;
end

T4: begin
	Grb<=0;Rout<=0;Y_enable<=0;
	Cout<=1;Zin <= 1; opcode <= ORI;
end

T5: begin
	Cout<=0; Zin <= 0;
	ZLowout <= 1;Gra<=1; Rin<=1;
end


endcase

end

endmodule


`timescale 1ns/10ps
module datapath(
	input clk, rst, stop,
	input wire[31:0] InPort_input,
	output [31:0] OutPort_output, busOut, Mdata,
	output Run
	
);
wire Read, Write;
wire Gra, Grb, Grc, Rin, Rout, BAout;
wire PCin, PCout, IncPC, Zin, Z_lo_reg_out, Z_hi_reg_out;
wire MARin, MDR_reg_in, MDR_reg_out;
wire IR_reg_in, Y_reg_in, Cout;
wire CON_enable;
wire Output_in, InPort_out;
wire HI_reg_in, LO_reg_in;
wire HI_reg_out, LO_reg_out;
wire stackEnable;

wire [8:0] MAR_out_address;
wire [31:0] RAM_data_out;

wire con_out;
wire clr;

wire[31:0] bus;
wire[63:0] Zreg;
wire [31:0] Z_hi_data, Z_lo_data;

// Inputs to the bus's 32-to-1 mux
wire [31:0] R0_data_out;
wire [31:0] R1_data_out;
wire [31:0] R2_data_out;
wire [31:0] R3_data_out;
wire [31:0] R4_data_out;
wire [31:0] R5_data_out;
wire [31:0] R6_data_out;
wire [31:0] R7_data_out;
wire [31:0] R8_data_out;
wire [31:0] R9_data_out;
wire [31:0] R10_data_out;
wire [31:0] R11_data_out;
wire [31:0] R12_data_out;
wire [31:0] R13_data_out;
wire [31:0] R14_data_out;
wire [31:0] R15_data_out;
wire R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out;
wire R0in, R1in, R2in, R3in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;

wire [31:0] PCreg_data_out;
wire [31:0] IRreg_data_out;
wire [31:0] Yreg_data_out;
wire [31:0] MARreg_data_out;
wire [31:0] HIreg_data_out;
wire [31:0] LOreg_data_out;
wire [31:0] Zhireg_data_out;
wire [31:0] Zloreg_data_out;
wire [31:0] MDRreg_data_out;
wire [31:0] Input_data_out;
wire [31:0] C_sign_ext_data_out;

wire [31:0] Output_data_out;
wire [31:0] Outport_reg_data;


assign busOut = bus;
assign Mdata = RAM_data_out;
assign OutPort_output = Output_data_out;

wire [4:0] encoder_select;

wire [4:0] opcode;

// Create registers
register_32 r0 (.clk(clk), .clr(clr), .R_in(R0in), .BusMuxOut(bus), .BusMuxIn_R(R0_data_out));
register_32 r1 (.clk(clk), .clr(clr), .R_in(R1in), .BusMuxOut(bus), .BusMuxIn_R(R1_data_out));
register_32 r2 (.clk(clk), .clr(clr), .R_in(R2in), .BusMuxOut(bus), .BusMuxIn_R(R2_data_out));
register_32 r3 (.clk(clk), .clr(clr), .R_in(R3in), .BusMuxOut(bus), .BusMuxIn_R(R3_data_out));
register_32 r4 (.clk(clk), .clr(clr), .R_in(R4in), .BusMuxOut(bus), .BusMuxIn_R(R4_data_out));
register_32 r5 (.clk(clk), .clr(clr), .R_in(R5in), .BusMuxOut(bus), .BusMuxIn_R(R5_data_out));
register_32 r6 (.clk(clk), .clr(clr), .R_in(R6in), .BusMuxOut(bus), .BusMuxIn_R(R6_data_out));
register_32 r7 (.clk(clk), .clr(clr), .R_in(R7in), .BusMuxOut(bus), .BusMuxIn_R(R7_data_out));
register_32 r8 (.clk(clk), .clr(clr), .R_in(R8in), .BusMuxOut(bus), .BusMuxIn_R(R8_data_out));
register_32 r9 (.clk(clk), .clr(clr), .R_in(R9in), .BusMuxOut(bus), .BusMuxIn_R(R9_data_out));
register_32 r10 (.clk(clk), .clr(clr), .R_in(R10in), .BusMuxOut(bus), .BusMuxIn_R(R10_data_out));
register_32 r11 (.clk(clk), .clr(clr), .R_in(R11in), .BusMuxOut(bus), .BusMuxIn_R(R11_data_out));
register_32 r12 (.clk(clk), .clr(clr), .R_in(R12in), .BusMuxOut(bus), .BusMuxIn_R(R12_data_out));
register_32 r13 (.clk(clk), .clr(clr), .R_in(R13in), .BusMuxOut(bus), .BusMuxIn_R(R13_data_out));
register_32 r14 (.clk(clk), .clr(clr), .R_in(R14in), .BusMuxOut(bus), .BusMuxIn_R(R14_data_out));
register_32 r15 (.clk(clk), .clr(clr), .R_in(R15in | stackEnable), .BusMuxOut(bus), .BusMuxIn_R(R15_data_out));



register_32 hi_reg(.clk(clk), .clr(clr), .R_in(HI_reg_in), .BusMuxOut(bus) ,.BusMuxIn_R(HIreg_data_out));
register_32 lo_reg(.clk(clk), .clr(clr), .R_in(LO_reg_in), .BusMuxOut(bus) ,.BusMuxIn_R(LOreg_data_out));
register_32 IR_reg(.clk(clk), .clr(clr), .R_in(IR_reg_in), .BusMuxOut(bus), .BusMuxIn_R(IRreg_data_out));
register_32 Y_reg(.clk(clk), .clr(clr), .R_in(Y_reg_in), .BusMuxOut(bus), .BusMuxIn_R(Yreg_data_out));
register_32 MAR_reg(.clk(clk), .clr(clr), .R_in(MARin), .BusMuxOut(bus), .BusMuxIn_R(MARreg_data_out));

register_32 Input_reg (.clk(clk), .clr(clr), .R_in(1'b1), .BusMuxOut(InPort_input), .BusMuxIn_R(Input_data_out));				// TODO: Figure this two out
register_32 Output_reg (.clk(clk), .clr(clr), .R_in(Output_in), .BusMuxOut(bus), .BusMuxIn_R(Outport_reg_data));


register_64 Z_reg(clr, clk, Zin, Zreg, Z_hi_data, Z_lo_data);
pc_reg_32 PC_reg(clk, clr, IncPC, PCin, bus, PCreg_data_out);

// MDR
mdr_unit the_mdr(
	.clk(clk),
	.clr(clr),
	.R_in(MDR_reg_in),
	.read(Read),
	.Mdatain(RAM_data_out),
	.bus(bus),
	.MDR_out(MDRreg_data_out)
);


// ALU
alu the_alu(.A_reg(Yreg_data_out), .B_reg(bus), .opcode(opcode), .Z_reg(Zreg), .Zin(Zin));
// BUS
bus the_bus(
	.busOut(bus),
	.R0out(R0out), .R1out(R1out), .R2out(R2out), 
	.R3out(R3out), .R4out(R4out), .R5out(R5out), 
	.R6out(R6out), .R7out(R7out), .R8out(R8out), 
	.R9out(R9out), .R10out(R10out), .R11out(R11out), 
	.R12out(R12out), .R13out(R13out), .R14out(R14out), 
	.R15out(R15out), .PCout(PCout), .HIout(HI_reg_out),
	.LOout(LO_reg_out), .ZHI(Z_hi_reg_out), .ZLO(Z_lo_reg_out),
	.MDRout(MDR_reg_out), .InPortout(InPort_out), .Cout(Cout),


	.busInR0(R0_data_out), .busInR1(R1_data_out), .busInR2(R2_data_out),
	.busInR3(R3_data_out), .busInR4(R4_data_out), .busInR5(R5_data_out),
	.busInR6(R6_data_out), .busInR7(R7_data_out), .busInR8(R8_data_out),
	.busInR9(R9_data_out), .busInR10(R10_data_out), .busInR11(R11_data_out),
	.busInR12(R12_data_out), .busInR13(R13_data_out), .busInR14(R14_data_out),
	.busInR15(R15_data_out), .busInPC(PCreg_data_out), .busInHI(HIreg_data_out),
	.busInLO(LOreg_data_out), .busInZHI(Z_hi_data), .busInZLO(Z_lo_data),
	.busInMDR(MDRreg_data_out), .busInInPort(Input_data_out), .busInC(C_sign_ext_data_out),
	.BAout(BAout)
);

// RAM
mar_unit the_mar(.clk(clk), .rst(rst), .MARin(MARin), .bus_contents(bus), .q(MAR_out_address));
ram theRam(.address(MAR_out_address), .clock(clk), .rden(Read), .wren(Write), .data(MDRreg_data_out), .q(RAM_data_out));

// SELECT AND ENCODE 
select_encode the_select_encode(
	.Gra(Gra), 
	.Grb(Grb), 
	.Grc(Grc), 
	.Rin(Rin), 
	.Rout(Rout), 
	.BAout(BAout),
	.IR(IRreg_data_out),
	.R0out(R0out), .R1out(R1out), .R2out(R2out), 
	.R3out(R3out), .R4out(R4out), .R5out(R5out), 
	.R6out(R6out), .R7out(R7out), .R8out(R8out), 
	.R9out(R9out), .R10out(R10out), .R11out(R11out), 
	.R12out(R12out), .R13out(R13out), .R14out(R14out), 
	.R15out(R15out),
	
	.R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), 
	.R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), 
   .R8in(R8in), .R9in(R9in), .R10in(R10in), .R11in(R11in),
   .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in),
	
	.C_sign_extended(C_sign_ext_data_out)
);

// CONDITIONAL LOGIC
con_ff the_con_ff(.bus(bus), .IR(IRreg_data_out[20:19]), .con_in(CON_enable), .result(con_out));

// CONTROL UNIT
control_unit the_control_unit(.IR(IRreg_data_out), .Clock(clk), .Reset(rst), .Stop(stop), .Con_FF(con_out),

.Gra(Gra), .Grb(Grb), .Grc(Grc), .Rin(Rin), .BAout(BAout), .Rout(Rout), .Cout(Cout), 
.OutputPortIn(Output_in), .MDRin(MDR_reg_in), .IRin(IR_reg_in), .PCin(PCin), .CONin(CON_enable), .HIin(HI_reg_in), .LOin(LO_reg_in),// define the inputs and outputs to your Control Unit
	.Yin(Y_reg_in), .Zin(Zin), .PCout(PCout), .IncPC(IncPC), .MARin(MARin), .MDRout(MDR_reg_out), .Zhiout(Z_hi_reg_out), .Zlowout(Z_lo_reg_out), .HIout(HI_reg_out), .LOout(LO_reg_out),
	.Read(Read), .Write(Write), .InputPortOut(InPort_out), .Clear(clr), .stackEnable(stackEnable), .opcode(opcode), .RunOut(Run)
);
Seven_Seg_Display_Out seg1(.outputt(Output_data_out[7:0]), .clk(clk), .data(Outport_reg_data[3:0]));
Seven_Seg_Display_Out seg2(.outputt(Output_data_out[15:8]), .clk(clk), .data(Outport_reg_data[7:4]));

endmodule

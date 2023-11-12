// and datapath_tb.v file: shl_tb.v
`timescale 1ns/10ps
module shl_tb;

reg PCout, Zlowout, MDRout, R2out, R3out; // add any other signals to see in your simulation
reg R0out, R1out, R4out, R5out, R6out;
reg R7out, R8out, R9out, R10out, R11out; 
reg R12out, R13out, R14out, R15out;
reg HIout, LOout, IRout;
reg Yout, Zhiout, MARout;
reg InPortout, Cout;


reg MARin, Zin, PCin, MDRin, IRin, Yin;
reg IncPC, Read, R1in, R2in, R3in;
reg R0in, R4in, R5in, R6in, R7in, R8in, R9in, R10in, R11in, R12in, R13in, R14in, R15in;
reg HIin, LOin;
reg InPortin, Cin;
reg Clock, Clear;
reg [31:0] Mdatain;
reg [4:0] SHL;

// wire [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, HI_out, LO_out, BusMuxOut;
wire [63:0] Zreg;

parameter Default = 4'b0000, Reg_load1a = 4'b0001, Reg_load1b = 4'b0010, Reg_load2a = 4'b0011,
    Reg_load2b = 4'b0100, Reg_load3a = 4'b0101, Reg_load3b = 4'b0110, T0 = 4'b0111,
    T1 = 4'b1000, T2 = 4'b1001, T3 = 4'b1010, T4 = 4'b1011, T5 = 4'b1100;

reg [3:0] Present_state = Default;

datapath DUT(
.clk(Clock),
.clr(Clear),
.opcode(SHR),
.R0_out(R0out), .R1_out(R1out), .R2_out(R2out), .R3_out(R3out), .R4_out(R4out), .R5_out(R5out), .R6_out(R6out), .R7_out(R7out), .R8_out(R8out), .R9_out(R9out), .R10_out(R10out), .R11_out(R11out), .R12_out(R12out), .R13_out(R13out), .R14_out(R14out), .R15_out(R15out),
.HI_reg_out(HIout), .LO_reg_out(LOout), .IR_reg_out(IRout), .Y_reg_out(Yout), .Z_hi_reg_out(Zhiout), .Z_lo_reg_out(Zlowout), .MAR_reg_out(MARout), .InPort_out(InPortout), .C_out(Cout),
.PC_reg_out(PCout), .MDR_reg_out(MDRout),

.R0in(R0in), .R1in(R1in), .R2in(R2in), .R3in(R3in), .R4in(R4in), .R5in(R5in), .R6in(R6in), .R7in(R7in), .R8in(R8in), .R9in(R9in), .R10in(R10in), .R11in(R11in), .R12in(R12in), .R13in(R13in), .R14in(R14in), .R15in(R15in),
.HI_reg_in(HIin), .LO_reg_in(LOin), .IR_reg_in(IRin), .Y_reg_in(Yin), .Z_reg_in(Zin), .MAR_reg_in(MARin), .InPort_reg_in(InPortin), .C_in(Cin),
.pc_inc_in(IncPC), .MDR_reg_in(MDRin),

.Mdatain(Mdatain), .Read(Read),

//.R0_data_out(R0), .R1_data_out(R1), .R2_data_out(R2), .R3_data_out(R3), .R4_data_out(R4), .R5_data_out(R5), .R6_data_out(R6), .R7_data_out(R7), .R8_data_out(R8), .R9_data_out(R9), .R10_data_out(R10), .R11_data_out(R11), .R12_data_out(R12), .R13_data_out(R13), .R14_data_out(R14), .R15_data_out(R15), .HI_reg_data_out(HI_out), .LO_reg_data_out(LO_out), .bus(BusMuxOut), 
.Zreg(Zreg)
);

// SUB test logic here
initial
begin
    Clock = 0;
    forever #10 Clock = ~ Clock;
end

always @(posedge Clock) // finite state machine; if clock rising-edge
begin
    case (Present_state)
        Reg_load1a : #40 Present_state = Reg_load1b;
        Default : #40 Present_state = Reg_load1a;
        Reg_load1b : #40 Present_state = Reg_load2a;
        Reg_load2a : #40 Present_state = Reg_load2b;
        Reg_load2b : #40 Present_state = Reg_load3a;
        Reg_load3a : #40 Present_state = Reg_load3b;
        Reg_load3b : #40 Present_state = T0;
        T0 : #40 Present_state = T1;
        T1 : #40 Present_state = T2;
        T2 : #40 Present_state = T3;
        T3 : #40 Present_state = T4;
        T4 : #40 Present_state = T5;
    endcase
end

always @(Present_state) // do the required job in each state
begin
    case (Present_state) // assert the required signals in each clock cycle
    Default: begin
        PCout <= 0; Zlowout <= 0; MDRout <= 0; // initialize the signals
        R5out <= 0; R3out <= 0; MARin <= 0; Zin <= 0;
        PCin <=0; MDRin <= 0; IRin <= 0; Yin <= 0;
        IncPC <= 0; Read <= 0; SHL <= 5'b01001;
        R1in <= 0; R5in <= 0; R3in <= 0; Mdatain <= 32'h00000000;
    end
    Reg_load1a: begin
        Mdatain <= 32'h00000012;
        Read = 0; MDRin = 0; // the first zero is there for completeness
        #10 Read <= 1; MDRin <= 1;
        #15 Read <= 0; MDRin <= 0;
    end
    Reg_load1b: begin
        #10 MDRout <= 1; R3in <= 1;
        #15 MDRout <= 0; R3in <= 0; // initialize R2 with the value $12
    end
    Reg_load2a: begin
        Mdatain <= 5'h00000001;
        #10 Read <= 1; MDRin <= 1;
        #15 Read <= 0; MDRin <= 0;
    end
    Reg_load2b: begin
        #10 MDRout <= 1; R5in <= 1;
        #15 MDRout <= 0; R5in <= 0; // initialize R3 with the value $14
    end
    Reg_load3a: begin
        Mdatain <= 32'h00000018;
        #10 Read <= 1; MDRin <= 1;
        #15 Read <= 0; MDRin <= 0;
    end
    Reg_load3b: begin
        #10 MDRout <= 1; R0in <= 1;
        #15 MDRout <= 0; R0in <= 0; // initialize R1 with the value $18
    end


    T0: begin // see if you need to de-assert these signals
        PCout <= 1; MARin <= 1; IncPC <= 1; Zin <= 1;
    end
    
    T1: begin
		  PCout <= 0; MARin <= 0; IncPC <= 0; Zin <= 0;
        Zlowout <= 1; PCin <= 1; Read <= 1; MDRin <= 1;
        Mdatain <= 32'h39918000; // opcode for shr R1, R3, R5
    end
    
    T2: begin
        Zlowout <= 0; PCin <= 0; Read <= 0; MDRin <= 0;
        MDRout <= 1; IRin <= 1;
    end
    
    T3: begin
        MDRout <= 0; IRin <= 0;
        R3out <= 1; Yin <= 1;
    end

    T4: begin
        R3out <= 0; Yin <= 0;
        R5out <= 1; SHL <= 5'b01001; Zin <= 1;
    end

    T5: begin
        R5out <= 0; Zin <= 0;
        Zlowout <= 1; R1in <= 1;
    end
    endcase
end
endmodule 
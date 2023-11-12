//filename bus.v

module bus(
    output reg [31:0] busOut,
    input [31:0] busInR0, busInR1, busInR2, busInR3, busInR4, busInR5, busInR6, busInR7, busInR8, busInR9, busInR10,
    busInR11, busInR12, busInR13, busInR14, busInR15, busInHI, busInLO, busInZHI, busInZLO, busInPC, busInMDR,
    busInInPort, busInC,
    input R0out, R1out, R2out, R3out, R4out, R5out, R6out, R7out, R8out, R9out, R10out, R11out, R12out, R13out, R14out, R15out,
    input HIout, LOout, ZHI, ZLO, PCout, MDRout, InPortout, Cout, BAout
);


initial busOut =0;
always @(*)
begin
    if(R0out)
        busOut <= BAout ? 32'h00000000 : busInR0;
    else if(R1out)
        busOut <= busInR1;
    else if(R2out)
        busOut <= busInR2;
    else if(R3out)
        busOut <= busInR3;
    else if(R4out)
        busOut <= busInR4;
    else if(R5out)
        busOut <= busInR5;
    else if(R6out)
        busOut <= busInR6;
    else if(R7out)
        busOut <= busInR7;
    else if(R8out)
        busOut <= busInR8;
    else if(R9out)
        busOut <= busInR9;
    else if(R10out)
        busOut <= busInR10;
    else if(R11out)
        busOut <= busInR11;
    else if(R12out)
        busOut <= busInR12;
    else if(R13out)
        busOut <= busInR13;
    else if(R14out)
        busOut <= busInR14;
    else if(R15out)
        busOut <= busInR15;
    else if(HIout)
        busOut <= busInHI;
    else if(LOout)
        busOut <= busInLO;
    else if(ZHI)
        busOut <= busInZHI;
    else if(ZLO)
        busOut <= busInZLO;
    else if(PCout)
        busOut <= busInPC;
    else if(MDRout)
        busOut <= busInMDR;
    else if(InPortout)
        busOut <= busInInPort;
    else if(Cout)
        busOut <= busInC;
	 else busOut <= 0;
	 
end

endmodule
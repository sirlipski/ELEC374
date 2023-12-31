// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.


// Generated by Quartus II 64-Bit Version 13.0 (Build Build 232 06/12/2013)
// Created on Mon Mar 13 14:37:59 2023

datapath datapath_inst
	.clk(clk_sig) ,	// input  clk_sig
	.clr(clr_sig) ,	// input  clr_sig
	.opcode(opcode_sig) ,	// input [4:0] opcode_sig
	.R0_out(R0_out_sig) ,	// input  R0_out_sig
	.R1_out(R1_out_sig) ,	// input  R1_out_sig
	.R2_out(R2_out_sig) ,	// input  R2_out_sig
	.R3_out(R3_out_sig) ,	// input  R3_out_sig
	.R4_out(R4_out_sig) ,	// input  R4_out_sig
	.R5_out(R5_out_sig) ,	// input  R5_out_sig
	.R6_out(R6_out_sig) ,	// input  R6_out_sig
	.R7_out(R7_out_sig) ,	// input  R7_out_sig
	.R8_out(R8_out_sig) ,	// input  R8_out_sig
	.R9_out(R9_out_sig) ,	// input  R9_out_sig
	.R10_out(R10_out_sig) ,	// input  R10_out_sig
	.R11_out(R11_out_sig) ,	// input  R11_out_sig
	.R12_out(R12_out_sig) ,	// input  R12_out_sig
	.R13_out(R13_out_sig) ,	// input  R13_out_sig
	.R14_out(R14_out_sig) ,	// input  R14_out_sig
	.R15_out(R15_out_sig) ,	// input  R15_out_sig
	.R0in(R0in_sig) ,	// input  R0in_sig
	.R1in(R1in_sig) ,	// input  R1in_sig
	.R2in(R2in_sig) ,	// input  R2in_sig
	.R3in(R3in_sig) ,	// input  R3in_sig
	.R4in(R4in_sig) ,	// input  R4in_sig
	.R5in(R5in_sig) ,	// input  R5in_sig
	.R6in(R6in_sig) ,	// input  R6in_sig
	.R7in(R7in_sig) ,	// input  R7in_sig
	.R8in(R8in_sig) ,	// input  R8in_sig
	.R9in(R9in_sig) ,	// input  R9in_sig
	.R10in(R10in_sig) ,	// input  R10in_sig
	.R11in(R11in_sig) ,	// input  R11in_sig
	.R12in(R12in_sig) ,	// input  R12in_sig
	.R13in(R13in_sig) ,	// input  R13in_sig
	.R14in(R14in_sig) ,	// input  R14in_sig
	.R15in(R15in_sig) ,	// input  R15in_sig
	.HI_reg_in(HI_reg_in_sig) ,	// input  HI_reg_in_sig
	.LO_reg_in(LO_reg_in_sig) ,	// input  LO_reg_in_sig
	.IR_reg_in(IR_reg_in_sig) ,	// input  IR_reg_in_sig
	.Y_reg_in(Y_reg_in_sig) ,	// input  Y_reg_in_sig
	.Z_reg_in(Z_reg_in_sig) ,	// input  Z_reg_in_sig
	.MAR_reg_in(MAR_reg_in_sig) ,	// input  MAR_reg_in_sig
	.HI_reg_out(HI_reg_out_sig) ,	// input  HI_reg_out_sig
	.LO_reg_out(LO_reg_out_sig) ,	// input  LO_reg_out_sig
	.IR_reg_out(IR_reg_out_sig) ,	// input  IR_reg_out_sig
	.Y_reg_out(Y_reg_out_sig) ,	// input  Y_reg_out_sig
	.Z_hi_reg_out(Z_hi_reg_out_sig) ,	// input  Z_hi_reg_out_sig
	.Z_lo_reg_out(Z_lo_reg_out_sig) ,	// input  Z_lo_reg_out_sig
	.MAR_reg_out(MAR_reg_out_sig) ,	// input  MAR_reg_out_sig
	.IncPC(IncPC_sig) ,	// input  IncPC_sig
	.PCin(PCin_sig) ,	// input  PCin_sig
	.MDR_reg_in(MDR_reg_in_sig) ,	// input  MDR_reg_in_sig
	.InPort_reg_in(InPort_reg_in_sig) ,	// input  InPort_reg_in_sig
	.C_in(C_in_sig) ,	// input  C_in_sig
	.PCout(PCout_sig) ,	// input  PCout_sig
	.MDR_reg_out(MDR_reg_out_sig) ,	// input  MDR_reg_out_sig
	.InPort_out(InPort_out_sig) ,	// input  InPort_out_sig
	.C_out(C_out_sig) ,	// input  C_out_sig
	.Mdatain(Mdatain_sig) ,	// input [31:0] Mdatain_sig
	.Read(Read_sig) ,	// input  Read_sig
	.R0(R0_sig) ,	// output [31:0] R0_sig
	.R1(R1_sig) ,	// output [31:0] R1_sig
	.R2(R2_sig) ,	// output [31:0] R2_sig
	.R3(R3_sig) ,	// output [31:0] R3_sig
	.R4(R4_sig) ,	// output [31:0] R4_sig
	.R5(R5_sig) ,	// output [31:0] R5_sig
	.R6(R6_sig) ,	// output [31:0] R6_sig
	.R7(R7_sig) ,	// output [31:0] R7_sig
	.R8(R8_sig) ,	// output [31:0] R8_sig
	.R9(R9_sig) ,	// output [31:0] R9_sig
	.R10(R10_sig) ,	// output [31:0] R10_sig
	.R11(R11_sig) ,	// output [31:0] R11_sig
	.R12(R12_sig) ,	// output [31:0] R12_sig
	.R13(R13_sig) ,	// output [31:0] R13_sig
	.R14(R14_sig) ,	// output [31:0] R14_sig
	.R15(R15_sig) ,	// output [31:0] R15_sig
	.IR(IR_sig) ,	// output [31:0] IR_sig
	.HI_out(HI_out_sig) ,	// output [31:0] HI_out_sig
	.LO_out(LO_out_sig) ,	// output [31:0] LO_out_sig
	.BusMuxOut(BusMuxOut_sig) ,	// output [31:0] BusMuxOut_sig
	.PC_register(PC_register_sig) ,	// output [31:0] PC_register_sig
	.Zreg_out(Zreg_out_sig) 	// output [63:0] Zreg_out_sig
);


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2025 16:24:08
// Design Name: 
// Module Name: Integration
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Integration # (parameter N = 32)
(
    input  wire clk,
    input  wire reset_n,
    output wire [N - 1 : 0] data_out
);
    
    localparam SEED0 = 32'h14784518;
    localparam SEED1 = 32'h198837FA;
    localparam SEED2 = 32'hFACD1223;
    localparam SEED3 = 32'hFABFECD1;
    localparam SEED4 = 32'h12829218;
    localparam SEED5 = 32'hFFFEFEFE;
    localparam SEED6 = 32'hEEE11122;
    localparam SEED7 = 32'hAAAAAAAA;
    
    wire [N - 1 : 0] default_seed = DEFAULT_SEED;
    
    wire [N - 1 : 0] seed0 = SEED0;
    wire [N - 1 : 0] seed1 = SEED1;
    wire [N - 1 : 0] seed2 = SEED2;
    wire [N - 1 : 0] seed3 = SEED3;
    wire [N - 1 : 0] seed4 = SEED4;
    wire [N - 1 : 0] seed5 = SEED5;
    wire [N - 1 : 0] seed6 = SEED6;
    wire [N - 1 : 0] seed7 = SEED7;
    
    wire [N - 1 : 0] value1, value2;
    wire [N - 1 : 0] value3, value4;
    wire [N - 1 : 0] value5, value6;
    wire [N - 1 : 0] value7, value8;
    
    wire s0,s1,s2,s3,s4,s5,s6,s7;
    
    LFSR     #(.N(N)) dut1(clk, reset_n, seed0, value1);
    Rule_30  #(.N(N)) dut2(clk, reset_n, seed1, value2);
    Rule_105 #(.N(N)) dut3(clk, reset_n, seed2, value3);
    Rule_149 #(.N(N)) dut4(clk, reset_n, seed3, value4);
    Rule_45  #(.N(N)) dut5(clk, reset_n, seed4, value5);
    Rule_182 #(.N(N)) dut6(clk, reset_n, seed5, value6);
    Rule_30  #(.N(N)) dut7(clk, reset_n, seed6, value7);
    Rule_149 #(.N(N)) dut8(clk, reset_n, seed7, value8);
    
    assign s0 = value8[27] & value1[13];
    assign s1 = value2[15] & value7[9];
    assign s2 = value3[0]  & value5[13];
    assign s3 = value4[11] & value6[8];
    
    assign s4 = value1[14] ^ value3[30] | value8[22];
    assign s5 = value7[1]  ^ value2[26] | value5[29];
    assign s6 = value4[6]  ^ value5[28] & value6[15];
    assign s7 = value2[4]  ^ value1[3]  & value5[2];
    
    assign data_out = s0 ? value7 :
                      s3 ? value2 :
                      s1 ? value8 :
                      s4 ? value4 :
                      s5 ? value6 :
                      s7 ? value3 :
                      s6 ? value5 :
                      s2 ? value1 : ;
    
endmodule

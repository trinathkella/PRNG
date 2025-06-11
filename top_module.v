`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2025 16:39:20
// Design Name: 
// Module Name: top_module
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


module top_module # (parameter N = 32)
(
    input  wire clk,
    input  wire reset_n,
    output wire [N - 1 : 0] random_data
);
    
    Integration #(.N(N)) dut
    (
        .clk(clk),
        .reset_n(reset_n),
        .data_out(random_data)
    );

endmodule

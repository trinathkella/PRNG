`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2025 12:02:08
// Design Name: 
// Module Name: LFSR
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


module LFSR #(parameter N = 32)
(
	input  wire clk,
	input  wire reset_n,
	input  wire [N - 1 : 0] seed_in,
	output wire [N - 1 : 0] data_out
);
	
	reg [N - 1 : 0] data_out_reg;

	always @ (posedge clk, negedge reset_n) begin
		if(!reset_n) begin
			data_out_reg <= seed_in;
		end
		else begin
			data_out_reg <= {data_out_reg[30 : 0], data_out_reg[31] ^ data_out_reg[21] ^ data_out_reg[1] ^ data_out_reg[0]};
		end
	end

	assign data_out = data_out_reg;

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2025 16:31:15
// Design Name: 
// Module Name: Rule_105
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


module Rule_105 # (parameter N = 32) 
(
	input  wire clk,   
	input  wire reset_n,
	input  wire [N - 1 : 0] seed_in,
	output wire [N - 1 : 0] data_out
);
	
	reg [N - 1 : 0] next_value, current_value;

	always @ (posedge clk, negedge reset_n) begin
		if(~reset_n) begin
			current_value <= seed_in;
		end
		else begin
			current_value <= next_value;
		end
	end
    
    //Rule 30
	always @ (*) begin
		integer i;
		for(i = 0; i < N; i++) begin
			next_value[i] = (current_value[i] & current_value[(i+N-1) % N] & !current_value[(i+1) % N]) |
			                (current_value[(i+1) % N] & current_value[(i+N-1) % N] & !current_value[i]) |
			                (!current_value[(i+1) % N] & !current_value[i] & !current_value[(i+N-1) % N]) ;
		end
	end

	assign data_out = current_value;

endmodule

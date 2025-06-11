`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2025 17:22:07
// Design Name: 
// Module Name: tb_top_module
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


module tb_top_module;
    
    parameter N = 32;
    reg clk, reset_n;
    wire [N - 1 : 0] random_data;

    // File pointer for logging
    integer f;

    // Instantiate DUT
    top_module #(.N(N)) dut (
        .clk(clk),
        .reset_n(reset_n),
        .random_data(random_data)
    );

    // Clock generation: 100MHz
    always #5 clk = ~clk;

    initial begin
         //Open a file for logging output
        f = $fopen("data.txt", "w");

        // Initial setup
        clk = 1'b0;
        reset_n = 1'b0;
        // Hold reset for at least one full clock cycle
        #20;
        reset_n = 1'b1;
         //Run simulation for a while and log data
        forever begin
            @(posedge clk);
            $fwrite(f, "%032b\n", random_data);
        end
        $fclose(f);
    end

endmodule
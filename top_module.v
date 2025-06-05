module top_module #(parameter N = 32)
(
    input  wire             clk,
    input  wire             reset_n,
    input  wire [N - 1 : 0] seed_in,
    
    output wire [N - 1 : 0] random_data
);
    
    CA #(.N(N)) ca_dut1
    (
        .clk(clk),
        .reset_n(reset_n),
        .seed_in(seed_in),
        .data_out(random_data)
    );
    
endmodule

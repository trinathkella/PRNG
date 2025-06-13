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
    
    wire [N - 1 : 0] seed0 = SEED0;
    wire [N - 1 : 0] seed1 = SEED1;
    wire [N - 1 : 0] seed2 = SEED2;
    wire [N - 1 : 0] seed3 = SEED3;
    wire [N - 1 : 0] seed4 = SEED4;
    wire [N - 1 : 0] seed5 = SEED5;
    
    wire [N - 1 : 0] value1, value2;
    wire [N - 1 : 0] value3, value4;
    wire [N - 1 : 0] value5, value6;
    
    wire s0,s1,s2,s3,s4,s5;
    
    LFSR     #(.N(N)) dut1(clk, reset_n, seed0, value1);
    Rule_30  #(.N(N)) dut2(clk, reset_n, seed1, value2);
    Rule_149 #(.N(N)) dut3(clk, reset_n, seed3, value4);
    Rule_30  #(.N(N)) dut4(clk, reset_n, seed4, value6);
    Rule_149 #(.N(N)) dut5(clk, reset_n, seed2, value3);
    LFSR     #(.N(N)) dut6(clk, reset_n, seed5, value5);
    
    reg [N - 1 : 0] data_out_reg;
    
    assign s0 = value3[27] ^ value5[11];
    assign s1 = value4[31] ^ value1[2];
    assign s2 = value2[0]  ^ value6[4];
    assign s3 = value1[8]  ^ value2[9];
    assign s4 = value6[21] ^ value3[17]; 
    assign s5 = value5[15] ^ value4[20];
    
    always @ (posedge clk, negedge reset_n) begin
        if(!reset_n) begin
            data_out_reg <= value2;
        end
        else begin
            if(s1) begin
                data_out_reg <= value2;
            end
            else if(s4) begin
                data_out_reg  <= value4;
            end
            else if(s5) begin
                data_out_reg  <= value1;
            end
            else if(s0) begin
                data_out_reg  <= value3;
            end
            else if(s2) begin
                data_out_reg  <= value5;
            end
            else if(s3) begin
                data_out_reg  <= value6;
            end
            else begin
                data_out_reg  <= value6;
            end
        end
    end
    
    assign data_out = data_out_reg;
    
endmodule

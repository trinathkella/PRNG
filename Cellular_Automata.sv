module CA #(parameter N = 32)(
                             input  wire clk,
    (* ASYNC_REG = "TRUE" *) input  wire reset_n,
    (* ASYNC_REG = "TRUE" *) input  wire [N - 1 : 0] seed_in,
                             output wire [N - 1 : 0] data_out
);
    localparam DEFAULT_SEED = 32'h198837FA;
    localparam SEED2        = 32'hFACD1223;
    localparam SEED3        = 32'hFABFECD1;
    localparam SEED4        = 32'h12829218;
    localparam SEED5        = 32'hFFFEFEFE;
    localparam SEED6        = 32'hEEE11122;
    localparam SEED7        = 32'hAAAAAAAA;

    reg [N - 1 : 0] value_1, value_2;
    reg [N - 1 : 0] value_3, value_4;
    reg [N - 1 : 0] value_5, value_6;
    reg [N - 1 : 0] value_7;
    
    reg [N - 1 : 0] next_value1, next_value2;
    reg [N - 1 : 0] next_value3, next_value4;
    reg [N - 1 : 0] next_value5, next_value6;
    reg [N - 1 : 0] next_value7, next_value8;
    reg s1, s2, s3, s4, s5, s6, s7; 
    
    reg [N - 1 : 0] data_out_reg;
    
    // --------1. Rule 30 based on seed_in ----------------
    always @ (posedge clk) begin
        if(!reset_n)
            value_1 <= seed_in;
        else
            value_1 <= next_value1;
    end

    always @ (*) begin
        integer i1;
        for(i1 = 0; i1 < N; i1 = i1 + 1) begin
            next_value1[i1] = value_1[(i1+1)%N] ^ (value_1[i1] | value_1[(i1+N-1)%N]);
        end
    end
 
    // --------2. Rule 30 based on seed2 ----------------
    always @ (posedge clk) begin
        if(!reset_n)
            value_2 <= SEED2;
        else
            value_2 <= next_value2;
    end

    always @ (*) begin
        integer i2;
        for(i2 = 0; i2 < N; i2 = i2 + 1) begin
            next_value2[i2] = value_1[(i2+1)%N] ^ (value_1[i2] | value_1[(i2+N-1)%N]);
        end
    end
    
    // -------- Rule 149 based on SEED3 ----------------
    always @ (posedge clk) begin
        if(!reset_n)
            value_3 <= SEED3;
        else
            value_3 <= next_value3;
    end

    always @ (*) begin
        integer i3;
        for(i3 = 0; i3 < N; i3 = i3 + 1) begin
            next_value3[i3] = !(value_3[(i3+N-1)%N] ^ (value_3[i3] | value_3[(i3+1)%N]));
        end
    end
    
    // -------- Rule 110 based on SEED4 ----------------
    always @ (posedge clk) begin
        if(!reset_n)
            value_4 <= SEED4;
        else
            value_4 <= next_value4;
    end

    always @ (*) begin
        integer i4;
        for(i4 = 0; i4 < N; i4 = i4 + 1) begin
            next_value4[i4] = (value_4[i4] & !value_4[(i4+N-1)%N]) | (!value_4[i4] & value_4[(i4+N-1)%N]) | (!value_4[(i4+1)%N] & value_4[i4]);
        end
    end
    
    // -------- Rule 182 based on SEED5 ----------------
    always @ (posedge clk) begin
        if(!reset_n)
            value_5 <= SEED5;
        else
            value_5 <= next_value5;
    end

    always @ (*) begin
        integer i5;
        for(i5 = 0; i5 < N; i5 = i5 + 1) begin
            next_value5[i5] = (value_5[(i5+1)%N] & !value_5[i5]) | (!value_5[(i5+1)%N] & value_5[(i5+N-1)%N]);
        end
    end

    // -------- Rule 30 based on SEED6 ----------------
    always @ (posedge clk) begin
        if(!reset_n)
            value_6 <= SEED6;
        else
            value_6 <= next_value6;
    end

    always @ (*) begin
        integer i6;
        for(i6 = 0; i6 < N; i6 = i6 + 1) begin
            next_value6[i6] = value_6[(i6+1)%N] ^ (value_6[i6] | value_6[(i6+N-1)%N]);
        end
    end

    // -------- Rule 105 based on SEED7 ----------------
    always @ (posedge clk) begin
        if(!reset_n)
            value_7 <= SEED7;
        else
            value_7 <= next_value7;
    end

    always @ (*) begin
        integer i7;
        for(i7 = 0; i7 < N; i7 = i7 + 1) begin
            next_value7[i7] = (value_7[i7] & value_7[(i7+N-1)%N] & !value_7[(i7+1)%N]) | 
                              (value_7[(i7+1)%N] & value_7[(i7+N-1)%N] & !value_7[i7]) |
                              (!value_7[(i7+1)%N] & !value_7[i7] & !value_7[(i7+N-1)%N]);
        end
    end

    //LFSR
    always @ (posedge clk) begin
        if(!reset_n) begin
            next_value8 <= DEFAULT_SEED;
        end
        else begin
            next_value8 <= {next_value8[30 : 0], next_value8[31] ^ next_value8[21] ^ next_value8[1], next_value8[0]};
        end
    end

    //Asserting random signals
    always @ (posedge clk) begin
        if(!reset_n) begin
            s1 <= 1'b0; s2 <= 1'b0;
            s3 <= 1'b0; s4 <= 1'b0;
            s5 <= 1'b0; s6 <= 1'b0;
            s7 <= 1'b0;
        end

        else begin
            s1 <= next_value8[31] ^ (next_value8[17] | next_value8[1]);
            s2 <= next_value6[29] ^ (next_value6[13] | next_value6[3]);
            s3 <= next_value4[23] ^ (next_value4[11] | next_value4[5]);
            s4 <= next_value2[8]  ^ (next_value2[10] | next_value2[7]);
            s5 <= next_value5[4]  ^ (next_value3[19] | next_value1[16]);
            s6 <= next_value1[22] ^ (next_value8[21] | next_value8[20]);
            s7 <= next_value3[28] ^ (next_value3[2]  | next_value3[6]);
        end
    end
    

    //Selecting a Rule or LFSR's output
    always @ (posedge clk) begin
        if(!reset_n) begin
            data_out_reg <= DEFAULT_SEED;
        end
        else begin
        data_out_reg <= (s1) ? next_value4 :
                        (s2) ? next_value2 :
                        (s3) ? next_value1 :
                        (s4) ? next_value5 :
                        (s5) ? next_value6 :
                        (s6) ? next_value8 :
                        (s7) ? next_value3 : next_value7;
        end
    end
    
    //assigning the output
    assign data_out    = data_out_reg;

endmodule

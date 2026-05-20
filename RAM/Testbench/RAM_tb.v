`timescale 1ns / 1ps

module RAM_tb;

    // --- Semnale Port A ---
    reg clk_a;
    reg write_en_a;
    reg [2:0] addr_a;
    reg [7:0] data_in_a;
    wire [7:0] data_out_a;

    // --- Semnale Port B ---
    reg clk_b;
    reg write_en_b;
    reg [2:0] addr_b;
    reg [7:0] data_in_b;
    wire [7:0] data_out_b;

    // --- Instantierea DUT ---
    RAM TEST(
        .clk_a(clk_a),
        .write_en_a(write_en_a),
        .addr_a(addr_a),
        .data_in_a(data_in_a),
        .data_out_a(data_out_a),
        .clk_b(clk_b),
        .write_en_b(write_en_b),
        .addr_b(addr_b),
        .data_in_b(data_in_b),
        .data_out_b(data_out_b)
    );

    always #5 clk_a = ~clk_a;
    always #8 clk_b = ~clk_b;

    initial begin
        clk_a = 0; clk_b = 0;
        write_en_a = 0; addr_a = 0; data_in_a = 0;
        write_en_b = 0; addr_b = 0; data_in_b = 0;
    end


    initial begin
        $monitor("Time=%0t | we_a=%b addr_a=%d din_a=%h dout_a=%h | we_b=%b addr_b=%d din_b=%h dout_b=%h", 
        $time, write_en_a, addr_a, data_in_a, data_out_a, write_en_b, addr_b, data_in_b, data_out_b);
        @(negedge clk_a);
        write_en_a = 1; addr_a = 3'd2; data_in_a = 8'hAA;
        
        @(negedge clk_a);
        write_en_a = 0; addr_a = 3'd5;
        
        @(negedge clk_a);
        write_en_a = 1; addr_a = 3'd0; data_in_a = 8'h11;
        
        @(negedge clk_a);
        write_en_a = 0; addr_a = 3'd7;
    end

    initial begin
        @(negedge clk_b);
        write_en_b = 0; addr_b = 3'd2;
        
        @(negedge clk_b);
        write_en_b = 1; addr_b = 3'd5; data_in_b = 8'hBB;
        
        @(negedge clk_b);
        write_en_b = 1; addr_b = 3'd7; data_in_b = 8'h99;
        
        @(negedge clk_b);
        write_en_b = 0; addr_b = 3'd0;

        #500;
        $finish;
    end

endmodule
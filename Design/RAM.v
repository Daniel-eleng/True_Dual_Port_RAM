`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2026 09:51:20 PM
// Design Name: 
// Module Name: RAM
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


module RAM(input clk_a, write_en_a, 
           input [2:0]addr_a, 
           input [7:0]data_in_a, 
           output reg [7:0]data_out_a,
           input clk_b, write_en_b,
           input [2:0]addr_b,
           input [7:0]data_in_b,
           output reg [7:0]data_out_b);
    
    reg [7:0]memory[0:7];

    always @(posedge clk_a) begin
        if(write_en_a) begin
            memory[addr_a] <= data_in_a;
            data_out_a <= data_in_a;
        end
        else
            data_out_a <= memory[addr_a];
    end
    
    always @(posedge clk_b) begin
        if(write_en_b) begin
            memory[addr_b] <= data_in_b;
            data_out_b <= data_in_b;
        end
        else
            data_out_b <= memory[addr_b];
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2023 09:56:42 AM
// Design Name: 
// Module Name: timer_tb
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


module timer_tb();
    reg clk;
    reg reset;
    reg in;
    wire [3:0] count;
    wire counting;
    wire done;
    reg ack;
    
    timer inst(clk,reset,in,count[3:0],counting,done,ack);
     
     always begin
         #0.5 clk = ~clk;
      end
      
      initial begin
         clk= 1;
         reset=1;         
         #1 reset=0;
         #110 ack=0;
         #4 ack=1;
         #1 ack=1'bx;
      end;
      
      initial begin
      in = 0;
      #1 in=1;
      #1 in=0;
      #2 in=1;
      #2 in=0;
      #1 in=1;
      #1 in=0;
      #3 in=1;
      #1 in=1'bx;
      #100 in=0;
      #4 in=1;
      #1 in=0;
      #1 in=1;
      #3 in=0;
      #1 in=1;
      #4 in=0;
      #1 in=1'bx;
      end
endmodule

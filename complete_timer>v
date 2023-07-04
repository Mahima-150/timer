module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
  parameter s=0, s1=1,s11=2,s110=3, bs=4,be=5, count1=6, wait1=7;
    reg [3:0] state, next;
    reg [2:0]count;
    
    always @(*) begin
        case(state)
            s: next=data?s1:s;
            s1: next=data?s11:s;
            s11: next=data?s11:s110;
            s110: next=data?bs:s;
            bs: next=(count==1)?be:bs; 
            be: next=(count==4)?count1:be;
            count1: next=done_counting?wait1:count1;
            wait1: next=ack?s:wait1;
        endcase
    end
        
    always@(posedge clk) begin
        if(reset) state<=s;
        else state<=next;
    end
    
    always@(posedge clk) begin
        if(reset)begin 
            shift_ena<=0;
            count<=0;
        end
        else begin 
            if((state==s110)&(data==1)) begin
               shift_ena<=1;
               count<=1;
            end
            else if((count<4)&((state==be)|(state==bs))) begin
               shift_ena<=1;
               count<=count+1;
            end
           else shift_ena<=0;
        end
    end
    
    assign counting= state==count1;
    assign done= state==wait1;
    
endmodule

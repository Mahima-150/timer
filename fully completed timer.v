module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );

    parameter s=0,s1=1, s11=2,s110=3,b0=4,b1=5,b2=6, b3=7, counts=8,waiting=9;
    reg [3:0]state, next;
    reg [9:0]counter;
    
    always@(*) begin
        case (state)
            s: next=data?s1:s;
            s1: next=data?s11:s;
            s11: next=data?s11:s110;
            s110: next=data?b0:s;
            b0: next=b1;
            b1: next=b2;
            b2: next=b3;
            b3: next=counts;
            counts: next=(count==0 && counter==999)?waiting:counts;
            waiting: next=ack?s:waiting;
        endcase
    end
    
    always@(posedge clk) begin
        if(reset) begin
            count<=0;
            counter<=0;
        end
        else begin
            if(state==b0 | state==b1 | state==b2 | state==b3)
                count<={count[2:0],data};
            else if(state==counts) begin
                    if (count >= 0) begin
                        if (counter < 999) begin
                            counter <= counter + 1;
                        end
                        else begin
                            count <= count - 1;
                            counter <= 0;
                        end
                    end
                end
            end
        end
    
    
    always@(posedge clk) begin
        if(reset) state<=s;
        else state<=next;
    end
    
    assign counting= state==counts;
    assign done= state==waiting;
           
endmodule

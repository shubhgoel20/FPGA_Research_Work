`timescale 1ns / 1ps

module counter(input clk,input rst,output reg[2:0] out);
always @(posedge clk) begin
    if(!rst)
        out<=0;
    else
        out<=out+1;
end
endmodule

module node(in,in1,in2,in3,in4,clk,out);
input [1:0] in,in1,in2,in3,in4,clk;
output reg out;

reg [1:0] temp;
// reg [1:0] temp_in;
reg [2:0] cnt;
reg rst;
wire y;

initial begin
temp = 2'b11;
// temp_in = in;
cnt = 3'b000;
rst = 1;
out = 0;
end

twobit_comparator cmp (in,temp,y);
counter c(clk,rst,cnt);

// reg [1:0] t;
// integer i;

always @ (posedge clk)
begin
// temp_in = in;
// out = 0;
// for (i = 0 ; i<=3 ; i=i+1) 
// begin
//     t=i;
case(cnt)
    3'b001:begin
        temp = in1;
        end
    3'b010:begin
        temp = in2;
        end
    3'b011:begin
        temp = in3;
        end
    3'b100:begin
        temp = in4;
        end
endcase
// out =(out|y);
// end  
end
always @(posedge clk) begin
    if(!rst) begin
        out<=0;
        rst<=1;
    end
    else begin 
        out<=(out|y);
        if(cnt == 3'b100)
            rst <= 0;
    end
end
endmodule

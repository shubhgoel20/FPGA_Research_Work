`timescale 1ns / 1ps

module counter(input clk,input rst,output reg[2:0] out);
always @(posedge clk) begin
    if(!rst)
        out=0;
    else
        out=out+1;
end
endmodule

module node(in,in1,in2,in3,in4,clk,high,out);
input [1:0] in,in1,in2,in3,in4;
input clk,high;
output reg out;

reg [1:0] temp;
reg temp_o;
wire [2:0] cnt;
reg rst;
wire y;

initial begin
    temp = 2'b11;
    out = 0;
    temp_o = 0;
    rst = 0;
end

twobit_comparator cmp (in,temp,y);
counter c(clk,rst,cnt); //counter will work as selector line for the mux


always @ (posedge clk)
begin
if(high == 0) begin 
    out = 0;
    rst = 0;
end
else begin
    out=0;
    rst = 1;
    case(cnt)
        3'b000:begin
            temp = in1;
            temp_o=(temp_o|y);
            end
        3'b001:begin
            temp = in2;
            temp_o=(temp_o|y);
            end
        3'b010:begin
            temp = in3;
            temp_o=(temp_o|y);
            rst=0;
            end
        3'b011:begin
            temp = in4;
            out=(temp_o|y);
            temp_o=0;
            end
    endcase
    
end
end
endmodule

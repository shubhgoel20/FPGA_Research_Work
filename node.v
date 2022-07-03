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
output reg [3:0] out;

reg [1:0] temp;
reg [3:0] temp_o;
wire [2:0] cnt;
reg rst;
wire y;

initial begin
temp_o = 4'b0000;
temp = 2'b11;
out = 4'b0000;
rst = 0;
end

twobit_comparator cmp (in,temp,y);
counter c(clk,rst,cnt);

always @ (*)
begin
    if(high == 0) begin 
        out = 4'b0000;
        rst = 0;
    end
    else begin
        rst = 1;
        case(cnt)
            3'b000:begin
                temp = in1;
                temp_o[0] = y;
                end
            3'b001:begin
                temp = in2;
                temp_o[1] = y;
                end
            3'b010:begin
                temp = in3;
                temp_o[2] = y;
                end
            3'b011:begin
                temp = in4;
                temp_o[3] = y;
                out = temp_o;
                rst = 0;
                end
        endcase
        
    end
end
endmodule

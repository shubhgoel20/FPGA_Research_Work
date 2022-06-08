`timescale 1ns / 1ps

module node_v2(in,in1,in2,in3,in4,out);
input [1:0] in,in1,in2,in3,in4;
output reg out;

reg [1:0] temp;
reg [1:0] temp_in;
wire y;
reg rst;
initial begin
temp = 2'b11;
rst = 0;
temp_in = in;
end

twobit_comparator uut (temp_in,temp,y);

reg [1:0] t;
integer i;

always @ (*)
begin
temp_in = in;
out = 0;
for (i = 0 ; i<=3 ; i=i+1) 
begin
    t=i;
    case(t)
        2'b00:begin
            temp = in1;
            end
        2'b01:begin
            temp = in2;
            end
        2'b10:begin
            temp = in3;
            end
        2'b11:begin
            temp = in4;
            end
    endcase
end
rst = 1;
end
always @ (*)
begin
    if(rst == 0)begin
    out = (out|y);
    end
    else begin
    rst = 0;
    end
end
endmodule

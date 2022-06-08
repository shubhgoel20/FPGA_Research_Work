`timescale 1ns / 1ps

module node(in,in1,in2,in3,in4,out);
input [1:0] in,in1,in2,in3,in4;
output reg out;

reg [1:0] temp;
wire y;

initial begin
temp = 2'b11;
end

twobit_comparator uut (in,temp,y);

reg [1:0] t;
integer i;

always @ (*)
begin
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
    out =(out|y);
end
  
end
endmodule

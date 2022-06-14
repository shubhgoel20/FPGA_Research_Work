`timescale 1ns / 1ps
module twobit_26x18_mesh(
input [51:0] inp,      // 26 inputs, 2 bit each, concatenated
input [4:0] row,       // for inputting the values at the right place
input clk,
input high, //when high = 1, all the inputs have been scaned. Output will then be generated after 4 clock cycles.
output [467:0] out
);

integer t;
//Input section
reg [1:0] in[0:467];
always @ (*) begin
    for ( t = 0 ; t<26 ; t=t+1 ) begin
	    in[26*row+t] = {inp[2*t],inp[(2*t)+1]};
    end
end

genvar j;
generate
	for ( j = 0 ; j<468 ; j=j+1 ) begin: comparator_block
		node wirexy (in[j],in[(j-26+468)%468],in[(j-j%26)+(j-1+26)%26],in[(j-j%26)+(j+1+26)%26],in[(j+26+468)%468],clk,high,out[467-j]);
	end
endgenerate


endmodule
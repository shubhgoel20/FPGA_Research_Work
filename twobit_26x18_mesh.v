`timescale 1ns / 1ps
module twobit_26x18_mesh(
input [935:0] inp,     
input clk,
input high,
output [1871:0] out
);

integer t;
reg [1:0] in[0:467];
always @ (posedge clk) begin
    for ( t = 0 ; t<468 ; t=t+1 ) begin
	    in[467-t] = {inp[(2*t)+1],inp[2*t]};
    end
end
genvar j;
generate
	for ( j = 0 ; j<468 ; j=j+1 ) begin: comparator_block
		node wirexy (in[j],in[(j-26+468)%468],in[(j-j%26)+(j-1+26)%26],in[(j-j%26)+(j+1+26)%26],in[(j+26+468)%468],clk,high,{out[4*(467-j)+3],out[4*(467-j)+2],out[4*(467-j)+1],out[4*(467-j)]});
	end
endgenerate


endmodule
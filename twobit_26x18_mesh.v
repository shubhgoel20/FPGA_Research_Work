`timescale 1ns / 1ps
module twobit_26x18_mesh(
input [935:0] inp,
input clk,
output [467:0] out
);


genvar j;
generate
	for ( j = 467 ; j>=0 ; j=j-1 ) begin: comparator_block
	    node wirexy ({inp[(2*j)+1],inp[2*j]},{inp[(2*((j-26+468)%468))+1],inp[2*((j-26+468)%468)]},{inp[(2*((j-j%26)+(j-1+26)%26))+1],inp[2*((j-j%26)+(j-1+26)%26)]},{inp[(2*((j-j%26)+(j+1+26)%26))+1],inp[2*((j-j%26)+(j+1+26)%26)]},{inp[(2*((j+26+468)%468))+1],inp[2*((j+26+468)%468)]},clk,out[j]);
	end
endgenerate


endmodule
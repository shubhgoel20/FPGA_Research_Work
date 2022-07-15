`timescale 1ns / 1ps
module twobit_26x18_mesh(
input [935:0] inp,     
input clk,
input high,
input algo,
output reg [467:0] contour
);

wire [1871:0] out;
reg [1871:0] mesh;

integer i, i_east, i_south ,x,y;
reg [5:0] ind;

task searchneighbour;
	input integer i;

	for( ind=0 ; ind<16 ; ind=ind+1) begin
		case(ind/4)
			0 : begin
				x = (i-26+468)%468;    //N
			end

			1 : begin
				x = (i-i%26)+(i+1+26)%26;  //E
			end

			2 : begin
				x = (i+26+468)%468;    //S
			end

			3 : begin
				x = (i-i%26)+(i-1+26)%26;  //W
			end
		endcase

		case(ind%4)
			0 : begin
				y = (x-26+468)%468;    //N
			end

			1 : begin
				y = (x-x%26)+(x+1+26)%26;  //E
			end

			2 : begin
				y = (x+26+468)%468;    //S
			end

			3 : begin
				y = (x-x%26)+(x-1+26)%26;  //W
			end
		endcase

		// Now we will have (x,y) as a pair of neighbours of node (i.e. neighbour1 & neighbour2)

		if (contour[x] != 1'b0) begin
			if ((mesh[4*y]&mesh[4*y+1]&mesh[4*y+2]&mesh[4*y+3])>(mesh[4*x]&mesh[4*x+1]&mesh[4*x+2]&mesh[4*x+3])) begin
				contour[x] = 1'b0;
				searchneighbour(x);
			end
		end

	end
	
endtask

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

always @(*) begin
	contour = 468'b111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111;
	mesh = out;
	if(algo == 0) begin
		for (i = 467 ; i>=0 ; i=i-1 ) begin
			i_east = (i-i%26)+(i-1+26)%26;
			i_south = (i-26+468)%468;

			if(contour[i] != 1'b0) begin            // for i_east
				if((mesh[4*i_east]&mesh[4*i_east+1]&mesh[4*i_east+2]&mesh[4*i_east+3])>(mesh[4*i]&mesh[4*i+1]&mesh[4*i+2]&mesh[4*i+3])) begin
					contour[i] = 1'b0;
					searchneighbour(i);
				end

				if(contour[i_east] != 1'b0) begin
					if((mesh[4*i_east]&mesh[4*i_east+1]&mesh[4*i_east+2]&mesh[4*i_east+3]) < (mesh[4*i]&mesh[4*i+1]&mesh[4*i+2]&mesh[4*i+3])) begin
						contour[i_east] = 1'b0;
						searchneighbour(i_east);
					end
				end
			end

			if(contour[i] != 1'b0) begin            // for i_south
				if((mesh[4*i_south]&mesh[4*i_south+1]&mesh[4*i_south+2]&mesh[4*i_south+3]) > (mesh[4*i]&mesh[4*i+1]&mesh[4*i+2]&mesh[4*i+3])) begin
					contour[i] = 1'b0;
					searchneighbour(i);
				end

				if(contour[i_south] != 1'b0) begin
					if((mesh[4*i_south]&mesh[4*i_south+1]&mesh[4*i_south+2]&mesh[4*i_south+3]) < (mesh[4*i]&mesh[4*i+1]&mesh[4*i+2]&mesh[4*i+3])) begin
						contour[i_south] = 1'b0;
						searchneighbour(i_south);
					end
				end
			end
		end
	end
	else begin
		for (i = 467 ; i>=0 ; i=i-1 ) begin
			if((mesh[4*i+1]^mesh[4*i+2]) == 1) begin
				contour[i] = 1'b0;
			end
		end
	end
	mesh = 0;
end

endmodule
`timescale 1ns / 1ps

module pixel_foll_tb;
	reg [51:0] inp;
	reg [4:0] row;
	reg clk;
	reg high;
	integer i;
    wire [467:0] out;
    reg [467:0] mesh;
	reg [1:0] in[0:5];
	reg [467:0] contour;

	// Instantiate the Unit Under Test (UUT)
	twobit_26x18_mesh uut (
		.inp(inp),
		.row(row),
		.clk(clk),
		.high(high),
        .out(out)
	);

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
                if (mesh[y] > mesh[x]) begin
                    contour[x] = 1'b0;
                    searchneighbour(x);
                end
            end

        end
        
    endtask
    
    initial begin
        clk = 0;
        forever begin
            #50 clk = ~clk;
        end
    end

    initial begin
        mesh = 0;
        contour = 468'b111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111;
    end
    
    initial begin 
        in[0] = 2'b01;
		in[1] = 2'b00;
		in[2] = 2'b10;
		in[3] = 2'b10;
		in[4] = 2'b01;
		in[5] = 2'b11;
    end

	always @(posedge clk) begin
	   contour = 468'b111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111;
        high = 0;
        for ( i=0 ; i<18 ; i=i+1 ) begin
            #5;row = i;
            inp = {2'b11,in[i%6],2'b11,in[i%6],2'b11,in[i%6],2'b11,in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6]};
        end
        #10;
        //Inputs will take one clock cycle to stablize.
        high = 1;
        #450;
        //Output will become after 4 clock cycles and will remain active for one clock cycle.
        in[0] = {($random)%2,($random)%2};
		in[1] = {($random)%2,($random)%2};
		in[2] = {($random)%2,($random)%2};
		in[3] = {($random)%2,($random)%2};
		in[4] = {($random)%2,($random)%2};
		in[5] = {($random)%2,($random)%2};
        //Pixel Following Algorithm begin-------------------------
        mesh = out;
        for (i = 0 ; i<468 ; i=i+1 ) begin
            i_east = (i-i%26)+(i+1+26)%26;
            i_south = (i+26+468)%468;

            if(contour[i] != 1'b0) begin            // for i_east
                if(mesh[i_east] > mesh[i]) begin
                    contour[i] = 1'b0;
                    searchneighbour(i);
                end

                if(contour[i_east] != 1'b0) begin
                    if(mesh[i_east] < mesh[i]) begin
                        contour[i_east] = 1'b0;
                        searchneighbour(i_east);
                    end
                end
            end

            if(contour[i] != 1'b0) begin            // for i_south
                if(mesh[i_south] > mesh[i]) begin
                    contour[i] = 1'b0;
                    searchneighbour(i);
                end

                if(contour[i_south] != 1'b0) begin
                    if(mesh[i_south] < mesh[i]) begin
                        contour[i_south] = 1'b0;
                        searchneighbour(i_south);
                    end
                end
            end
        end
        #50;

	end
  
endmodule
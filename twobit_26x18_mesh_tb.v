`timescale 1ns / 1ps

module twobit_26x18_mesh_tb;
	reg [51:0] inp;
	reg [4:0] row;
	reg clk;
	reg high;
	integer i;
    wire [467:0] out;
	reg [1:0] in[0:5];

	// Instantiate the Unit Under Test (UUT)
	twobit_26x18_mesh uut (
		.inp(inp),
		.row(row),
		.clk(clk),
		.high(high),
        .out(out)
	);

    initial begin
        clk = 0;
        forever begin
            #50 clk = ~clk;
        end
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
        high = 0;
        for ( i=0 ; i<18 ; i=i+1 ) begin
            #5;row = i;
            inp = {2'b11,in[i%6],2'b11,in[i%6],2'b11,in[i%6],2'b11,in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6],in[i%6]};
        end
        #10;
        //Inputs will take one clock cycle to stablize.
        high = 1;
        #500;
        //Output will become after 4 clock cycles and will remain active for one clock cycle.
        in[0] = {($random)%2,($random)%2};
		in[1] = {($random)%2,($random)%2};
		in[2] = {($random)%2,($random)%2};
		in[3] = {($random)%2,($random)%2};
		in[4] = {($random)%2,($random)%2};
		in[5] = {($random)%2,($random)%2};
	end
  
endmodule
`timescale 1ns / 1ps

module twobit_26x18_mesh_tb;
	reg [935:0] inp;
	reg clk;
	integer i;
    wire [467:0] out;

	// Instantiate the Unit Under Test (UUT)
	twobit_26x18_mesh uut (
		.inp(inp),
		.clk(clk),
        .out(out)
	);

    initial begin
        clk = 0;
        forever begin
            #50 clk = ~clk;
        end
    end

	always @(posedge clk) begin
		for ( i=0 ; i<936 ; i=i+1 ) begin
            inp[i] = ($random)%2;
        end
        #400;
	end
  
endmodule
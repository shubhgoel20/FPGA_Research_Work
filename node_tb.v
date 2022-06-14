`timescale 1ns / 1ps

module node_tb;

	// Inputs
	reg [1:0] in,in1,in2,in3,in4;
    reg clk;
    reg high;
	// Outputs
	wire out;

    initial begin
        clk = 0;
        high = 1;
    end

	// Instantiate the Unit Under Test (UUT)
	node uut(
		.in(in), .in1(in1), .in2(in2), .in3(in3), .in4(in4),.clk(clk),.high(high),
		.out(out)
	);

    initial begin
        forever begin
            #5 clk = ~clk;
        end
    end

    reg [9:0] i = 0;
    
    always @(posedge clk) begin 
        high = 1;
        {in,in1,in2,in3,in4} = i;
        #40;
        i = i+1;
        
        
    end

    initial begin
        #51200; $finish;
    end
      
endmodule
`timescale 1ns / 1ps

module twobit_comparatornew_tb;

	// Inputs
	reg [1:0] in,in1,in2,in3,in4;
    reg clk;
	// Outputs
	wire out;

    initial begin
        clk = 0;
    end

	// Instantiate the Unit Under Test (UUT)
	node uut(
		.in(in), .in1(in1), .in2(in2), .in3(in3), .in4(in4),.clk(clk)
		.out(out)
	);

    initial begin
        forever begin
            #5 clk = ~clk;
        end
    end

    reg [9:0] i;

	initial begin
		for (i = 0;i<= 1023; i=i+1) begin
            {in,in1,in2,in3,in4} = i;
            #40;
        end
	end

    initial begin
        #40960; $finish;
    end
      
endmodule
`timescale 1ns / 1ps

module pixel_foll_tb;

	// Inputs
	reg [99:0] img;
    reg clk;
	// Outputs
	wire [99:0] contour;

    initial begin
        clk = 0;
    end

	// Instantiate the Unit Under Test (UUT)
	pixel_foll uut(
		.img(img), .contour(contour)
	);

    initial begin
        forever begin
            #100 clk = ~clk;
        end
    end


    always @(posedge clk) begin 
        img = 100'b0000000000011100111001110011100111001110011111111001111111100111001110011100111001110011100000000000;
    end
    //Expected Output-
    //0000000000011100111001010010100101001010010011001001001100100101001010010100101001110011100000000000

    initial begin
        #51200; $finish;
    end
      
endmodule

// module pixel_foll_tb;

// 	// Inputs
// 	reg [467:0] img;
//     reg clk;
// 	// Outputs
// 	wire [467:0] contour;

//     initial begin
//         clk = 0;
//     end

// 	// Instantiate the Unit Under Test (UUT)
// 	pixel_foll uut(
// 		.img(img), .contour(contour)
// 	);

//     initial begin
//         forever begin
//             #100 clk = ~clk;
//         end
//     end

//     reg [467:0] i = 0;
    
//     always @(posedge clk) begin 
//         img = i;
//         #200;
//         i = i+255;
//     end

//     initial begin
//         #51200; $finish;
//     end
      
// endmodule
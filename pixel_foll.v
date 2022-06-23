`timescale 1ns / 1ps
module pixel_foll(
input [99:0] img,
output reg [99:0] contour
);

initial begin
    contour = 0;
end

integer i;

always @(*) begin 
    for(i = 99;i>=0;i = i-1) begin
        if(!img[i])begin
            if(img[(i-i%10)+(i-1+10)%10]) contour[(i-i%10)+(i-1+10)%10] = 1;
            if(img[(i-10+100)%100]) contour[(i-10+100)%100] = 1;
        end
        else begin
            if(!contour[i]) begin
                if(!img[(i-i%10)+(i-1+10)%10] || !img[(i-10+100)%100]) contour[i] = 1;
            end
        end
    end
end

endmodule

// module pixel_foll(
// input [467:0] img,
// output reg [467:0] contour
// );

// initial begin
//     contour = 0;
// end

// integer i;

// always @(*) begin 
//     for(i = 467;i>=0;i = i-1) begin
//         if(!img[i])begin
//             if(img[(i-i%26)+(i-1+26)%26]) contour[(i-i%26)+(i-1+26)%26] = 1;
//             if(img[(i-26+468)%468]) contour[(i-26+468)%468] = 1;
//         end
//         else begin
//             if(!contour[i]) begin
//                 if(!img[(i-i%26)+(i-1+26)%26] || !img[(i-26+468)%468]) contour[i] = 1;
//             end
//         end
//     end
// end

// endmodule
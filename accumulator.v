module accumulator (A, accum,overflow, clk, clr);

 input [7:0] A;
 input clk, clr;
 output [7:0] accum;
 output reg overflow;

 reg [7:0] accum;

 always@(clk) begin
    if(clk) begin
        {overflow,accum} <= accum + A;
    end
    else if(~clr) begin
        accum = 8'b00000000;
    end
 end

endmodule
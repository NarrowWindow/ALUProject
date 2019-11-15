module combinationalLogic(rst, noOp, cmd, sa, sb, so);
	input rst, noOp;
	input[4:0] cmd;
	output[1:0] sa, sb;
	output[3:0] so;

	assign sa = {rst, ~rst & ~noOp};
	assign sb = {rst | (~noOp & cmd[4]), ~rst & ~noOp};
	assign so = {rst | (~noOp & cmd[3]),
		     rst | (~noOp & cmd[2]),
		     rst | (~noOp & cmd[1]),
		     ~rst & ~noOp & cmd[0]};
endmodule

// Selector bit needs to be go through a decoder
module Mux16(a15, a14, a13, a12, a11, a10, a9, a8, a7, a6, a5, a4, a3, a2, a1, a0, s, b) ;
	parameter k = 32;
	input [k-1:0] a15, a14, a13, a12, a11, a10, a9, a8, a7, a6, a5, a4, a3, a2, a1, a0 ;
	input [15:0] s;
	output[k-1:0] b;
	assign b = ({k{s[15]}} & a15) |
                ({k{s[14]}} & a14) |
                ({k{s[13]}} & a13) |
                ({k{s[12]}} & a12) |
                ({k{s[11]}} & a11) |
                ({k{s[10]}} & a10) |
                ({k{s[9]}} & a9) |
                ({k{s[8]}} & a8) |
                ({k{s[7]}} & a7) |
                ({k{s[6]}} & a6) |
                ({k{s[5]}} & a5) |
                ({k{s[4]}} & a4) |
                ({k{s[3]}} & a3) | 
                ({k{s[2]}} & a2) | 
                ({k{s[1]}} & a1) |
                ({k{s[0]}} & a0) ;
endmodule

module Mux4(a3, a2, a1, a0, s, b) ;
	parameter k = 16;
	input [k-1:0] a3, a2, a1, a0 ;
	input [3:0] s;
	output[k-1:0] b;
	assign b = 
                ({k{s[3]}} & a3) | 
                ({k{s[2]}} & a2) | 
                ({k{s[1]}} & a1) |
                ({k{s[0]}} & a0) ;
endmodule

module ADD(a, b, out, overflow);
    input [15:0] a, b;
    output [31:0] out;
    output overflow;

    assign out = a + b;
    assign overflow = out[16];
endmodule

module SUB(a, b, out, underflow);
    input [15:0] a, b;
    output [31:0] out;
    output underflow;
    assign out = a - b;
endmodule

module MULT(a, b, out);
    input [15:0] a, b;
    output [31:0] out;
    assign out = a * b;
endmodule

module DIV(a, b, out);
    input [15:0] a, b;
    output [31:0] out;
    assign out = a / b;
endmodule

module SLL(a, b, out);
    input[15:0] a, b;
    output [31:0] out;
    assign out = a << b;
endmodule

module SRL(a, b, out);
    input[15:0] a, b;
    output [31:0] out;
    assign out = a >> b;
endmodule

module AND(a, b, out);
    input [15:0] a, b;
    output [31:0] out;
    assign out = a & b;
endmodule

module OR(a, b, out);
    input [15:0] a, b;
    output [31:0] out;
    assign out = a | b;
endmodule

module XOR(a, b, out);
    input [15:0] a, b;
    output [31:0] out;
    assign out = a ^ b;
endmodule

module NOT(a, out);
    input [15:0] a;
    output [31:0] out;
    assign out = ~a;
endmodule

module NAND(a, b, out);
    input [15:0] a, b;
    output [31:0] out;
    assign out = a ~& b;
endmodule

module NOR(a, b, out);
    input [15:0] a, b;
    output [31:0] out;
    assign out = a ~| b;
endmodule

module register (reset, CLK, D, Q);
	parameter N=16;
	input reset;
	input CLK;
	input [N-1:0] D;
	output [N-1:0] Q;
	reg [N-1:0] Q;
	always @(posedge CLK)
	if (reset)
		Q = 0;
	else
	Q = D;
endmodule // reg8

module accumulator (A, accum,overflow, clk, clr);
 parameter N=16;
 input [N-1:0] A;
 input clk, clr;
 output [N-1:0] accum;
 output reg overflow;

 reg [N-1:0] accum;

 always@(clk) begin
    if(clk) begin
        {overflow,accum} <= accum + A;
    end
    else if(~clr) begin
        accum = 8'b00000000;
    end
 end

endmodule

module dec2 (in, out)
input [1:0} in;
output [3:0] out;
assign out = { in[1] & in[0],
				in[1] & ~in[0],
				~in[1] & in[0],
				~in[1] & ~in[0]				
}

endmodule

module testbench()
parameter n = 16;

wire [n-1:0] Aout, Bout;
reg [n-1:0] A, B;
wire [n-1:0] AcumOut;



Mux4 AMux (Aout, A, 16'b00000000, 16'b00000000, );
Mux4 BMux (Bout, B, 16'b00000000, AcumOut);  

register regA (

endmodule



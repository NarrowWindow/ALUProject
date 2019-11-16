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
	assign b = ({k{s[0]}} & a15) |
                ({k{s[1]}} & a14) |
                ({k{s[2]}} & a13) |
                ({k{s[3]}} & a12) |
                ({k{s[4]}} & a11) |
                ({k{s[5]}} & a10) |
                ({k{s[6]}} & a9) |
                ({k{s[7]}} & a8) |
                ({k{s[8]}} & a7) |
                ({k{s[9]}} & a6) |
                ({k{s[10]}} & a5) |
                ({k{s[11]}} & a4) |
                ({k{s[12]}} & a3) | 
                ({k{s[13]}} & a2) | 
                ({k{s[14]}} & a1) |
                ({k{s[15]}} & a0) ;
endmodule

module Mux4(a3, a2, a1, a0, s, b) ;
	parameter k = 16;
	input [k-1:0] a3, a2, a1, a0 ;
	input [3:0] s;
	output[k-1:0] b;
	assign b = 
                ({k{s[0]}} & a3) | 
                ({k{s[1]}} & a2) | 
                ({k{s[2]}} & a1) |
                ({k{s[3]}} & a0) ;
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

module register (CLK, D, Q);
	parameter N=16;
	input CLK;
	input [N-1:0] D;
	output [N-1:0] Q;
	reg [N-1:0] Q;
	always @(posedge CLK)
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

// This has been tested
module dec2 (in, out);
input [1:0] in;
output [3:0] out;
assign out = { in[1] & in[0],
				in[1] & ~in[0],
				~in[1] & in[0],
				~in[1] & ~in[0]				
};

endmodule


module breadboard(clk, A, B, cmd, rst, noOp);
parameter n = 16;

input clk, rst, noOp;

wire [n-1:0] Aout, Bout;
input [n-1:0] A, B;
input [4:0] cmd;
wire [n-1:0] AcumOut;
wire [n-1:0] MuxAout, MuxBout;
wire [3:0] so;

wire [n-1:0] addOut, subOut, SLOut, SROut, divOut, mulOut;
wire [n-1:0] andOut, orOut, xorOut, notOut; 

wire [1:0] sa, sb;
wire [3:0] soa, sob;

wire overflow;

dec2 DecA (sa, soa);
dec2 DecB (sb, sob);

Mux4 AMux (Aout, A, 16'b00000000, 16'b00000000, soa, MuxAout);
Mux4 BMux (Bout, B, 16'b00000000, AcumOut, sob, MuxBout);  

register regA (clk, MuxAout, Aout);
register regB (clk, MuxBout, Bout);

combinationalLogic CL(rst, noOp, cmd, sa, sb, so);

ADD adder (Aout, Bout, addOut, overflow);
SUB sub(Aout, Bout, subOut, overflow);
MULT mult(Aout, Bout, mulOut);
DIV div(Aout, Bout, divOut);
SLL sl(Aout, Bout, SLOut);
SRL sr(Aout, Bout, SROut);
AND anD(Aout, Bout, andOut);
OR oR(Aout, Bout, orOut);
XOR xOr(Aout, Bout, xorOut);
NOT noT(Aout, notOut);0

endmodule

module testbench();

reg clk, rst, noOp;
reg [4:0] cmd;
reg [15:0] A, B;
wire [31:0] out;
wire overflow;

breadboard ALU (clk, A, B, cmd, rst, noOp);
 

//---------------------------------------------
	//The Display Thread with Clock Control
	//---------------------------------------------
	initial
		begin
			forever
				begin
					#5 
					clk = 0 ;
					#5
					clk = 1 ;
				end
		end
		
	initial
		begin
		#1
		A = 16'd17; B = 16'd15; rst = 1; noOp = 0; cmd = 5'b0;
		#10 
		
		$display("%b  %b", ALU.Aout, ALU.Bout);
		
		$finish;
		end
endmodule



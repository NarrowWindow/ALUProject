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
    assign out = a >> b;
endmodule

module SRL(a, b, out);
    input[15:0] a, b;
    output [31:0] out;
    assign out = a << b;
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

module TestBench();
    parameter n = 16;
    parameter m = 32;

    reg [15:0] a, b;
    wire [31:0] out;
    wire overflow;

    ADD adder(a, b, out, overflow);

    initial begin
        a = 50000;
        b = 50000;

        #1
        $display("%b", a);
        $display("%b", b);
        $display("%b", out);
        $display("%b", overflow);
    end
endmodule
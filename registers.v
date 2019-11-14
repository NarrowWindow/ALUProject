module register_a (reset, CLK, D, Q);
	#(parameter N=16)
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

module register_b (reset, CLK, D, Q);
	#(parameter N=16)
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

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

module testbench();
	reg rst, noOp;
	reg[4:0] cmd;
	wire[1:0] sa, sb;
	wire[3:0] so;

	combinationalLogic CL(rst, noOp, cmd, sa, sb, so);

	initial begin
	$display("rst|nop| cmd |sa|sb| so |");
	rst = 1; noOp = 1; cmd = 5'b10101;
	#5
	$display(" %b | %b |%b|%b|%b|%b|", rst, noOp, cmd, sa, sb, so);
	rst = 1; noOp = 0; cmd = 5'b01010;
	#5
	$display(" %b | %b |%b|%b|%b|%b|", rst, noOp, cmd, sa, sb, so);
	rst = 0; noOp = 1; cmd = 5'b10101;
	#5
	$display(" %b | %b |%b|%b|%b|%b|", rst, noOp, cmd, sa, sb, so);
	rst = 0; noOp = 1; cmd = 5'b01010;
	#5
	$display(" %b | %b |%b|%b|%b|%b|", rst, noOp, cmd, sa, sb, so);
	rst = 0; noOp = 0; cmd = 5'b10101;
	#5
	$display(" %b | %b |%b|%b|%b|%b|", rst, noOp, cmd, sa, sb, so);
	rst = 0; noOp = 0; cmd = 5'b01010;
	#5
	$display(" %b | %b |%b|%b|%b|%b|", rst, noOp, cmd, sa, sb, so);
	end
endmodule

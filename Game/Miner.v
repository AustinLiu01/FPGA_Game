module Miner(a, b, out);
	input [5:0]a;
	input [5:0]b;
	output [5:0]out;
	
	assign out = a - b ;
endmodule

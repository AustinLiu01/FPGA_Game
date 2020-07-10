module D_Latch(clk, rst, in, out) ;
	parameter n = 1 ;
	input clk, rst ;
	input [n-1:0] in ;
	output [n-1:0] out ;
	//变量类型
	reg [n-1:0] out ;
	//条件判断
	always @(posedge clk or posedge rst) begin
		if(rst)
			out <= 0 ;
		else
			out <= in ;
	end
endmodule

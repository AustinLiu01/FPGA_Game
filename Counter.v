module Counter(clk, rst, cnt);
	parameter n = 4;
	input clk, rst;
	output reg [n-1:0]cnt;
	
	always @(posedge clk or posedge rst) begin
		if(rst)
			cnt <= 0 ;
		else if(clk)
			cnt <= cnt + 1'b1;
		else 
			cnt <= cnt ;

	end
endmodule

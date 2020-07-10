module Fellow(clk, rst, clkout) ;
	parameter N = 25000000;
	input 	clk, rst;
	output	clkout;

	reg [63:0]cnt;
	reg clkout;
	//计数
	always @(posedge clk) begin
		if(rst == 1)
			cnt <= 0;
		else if (cnt == (N-1))
			cnt <= 0;
		else 
			cnt <= cnt+1;
	end
	//新时钟
	always @(posedge clk) begin
		if(rst == 1)
			clkout <= 0;
		else if (cnt < (N/2))
			clkout <= 0;
		else
			clkout <= 1;
	end
endmodule

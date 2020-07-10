module clk_1s(clk,clk_out);//默认1s时钟
	parameter n = 24999_999;
	parameter m = 25;
	input clk;

	output clk_out;
	
	reg [m-1:0] cnt;
	reg clk_out;
	
	always@(posedge clk)

		if (cnt == n)  //数25000个数后清零,否则正常计数
			cnt <= 0;
		else 
			cnt <= cnt + 1'b1;
	
	always@(posedge clk)
	if (cnt == n)  //每数25000个数输出clk_out产生一次电平翻转
		clk_out <= ~clk_out;
	else 
		clk_out <= clk_out;

endmodule

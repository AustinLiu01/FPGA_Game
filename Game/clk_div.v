module clk_div(clk,clk_out);
	parameter n = 24999999;
	input clk;
	output clk_out;
	reg clk_out;
	reg [25:0]cnt;
	wire rst;
	assign rst=0;

	always @(posedge clk )
	if(rst==1)
		begin
		cnt <= 0;
		clk_out <= 0;
		end
	else if(cnt == n)
		begin
		cnt <= 0;
		clk_out <= ~clk_out;
		end
	else cnt <= cnt + 1'b1;

endmodule
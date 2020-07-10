module D_Latch2(clk,in,out);
	parameter n=24999999;
	parameter m=1;
	input clk;
	wire rst;
	assign rst =0;
	reg [25:0] cnt;
	input [m-1:0] in;
	output [m-1:0] out;
	reg [m-1:0] out;
	reg clk_out;
	
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
	
	always@(posedge clk_out)
		out=in;
	
endmodule

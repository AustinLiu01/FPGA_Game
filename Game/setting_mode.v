module setting_mode(clk, up, down, hole_rst, display_mode, times);
	input clk, up, down;
	output [9:0]hole_rst;
	output [6:0]display_mode;
	output [5:0]times;
	//变量类型
	wire [3:0]mode;
	//实例化
	FSM_hole U0(up, down, clk, mode, hole_rst);
	Display U1(mode, display_mode);
	iEncoder U2(mode, times);
endmodule

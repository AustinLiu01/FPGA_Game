module Main(clk, rst, sw, keep, out, fail);
	input clk, keep;
	input [9:0]rst;
	input [9:0]sw;
	output [9:0]out;
	output [9:0]fail;
	//output point;
//———————————————————— 随机种子 ————————————————————

	//变量类型
	wire [30:0]seed_0;
	wire [30:0]seed_1;
	wire [30:0]seed_2;
	wire [30:0]seed_3;
	wire [30:0]seed_4;
	wire [30:0]seed_5;
	wire [30:0]seed_6;
	wire [30:0]seed_7;
	wire [30:0]seed_8;
	wire [30:0]seed_9;
	//随机种子设置
	assign seed_0 = 31'b00000_00001_00000_00001_00000_00001_0;
	assign seed_1 = 31'b01000_00010_00000_00010_00000_00100_0;
	assign seed_2 = 31'b00000_00100_00000_00100_00001_00000_0;
	assign seed_3 = 31'b00000_01000_00000_01000_01000_01000_0;
	assign seed_4 = 31'b00000_10000_00000_10000_00000_10000_0;
	assign seed_5 = 31'b00001_00000_00001_00001_00000_00000_0;
	assign seed_6 = 31'b00000_00000_00010_00000_00010_00000_0;
	assign seed_7 = 31'b00100_00010_00100_00000_00000_00000_0;
	assign seed_8 = 31'b00000_00000_01000_00000_01000_00000_0;
	assign seed_9 = 31'b10000_00000_10000_00000_00000_00000_0;
	
//———————————————————— 老鼠洞系统 ————————————————————

	//变量类型
	wire clkout;
	wire rst_n;
	assign rst_n = 0;
	//实例化分频
	//Fellow #(25000000) F(clk, rst, clkout);
	//assign point = clkout;
	//实例化计时器
	//Timer T(rst_n, clkout, point);
	//实例化老鼠洞
	FSM_mouse M0(clk, rst[0], sw[0], keep, seed_0, out[0], fail[0]);
	FSM_mouse M1(clk, rst[1], sw[1], keep, seed_1, out[1], fail[1]);
	FSM_mouse M2(clk, rst[2], sw[2], keep, seed_2, out[2], fail[2]);
	FSM_mouse M3(clk, rst[3], sw[3], keep, seed_3, out[3], fail[3]);
	FSM_mouse M4(clk, rst[4], sw[4], keep, seed_4, out[4], fail[4]);
	FSM_mouse M5(clk, rst[5], sw[5], keep, seed_5, out[5], fail[5]);
	FSM_mouse M6(clk, rst[6], sw[6], keep, seed_6, out[6], fail[6]);
	FSM_mouse M7(clk, rst[7], sw[7], keep, seed_7, out[7], fail[7]);
	FSM_mouse M8(clk, rst[8], sw[8], keep, seed_8, out[8], fail[8]);
	FSM_mouse M9(clk, rst[9], sw[9], keep, seed_9, out[9], fail[9]);
	//
						
//———————————————————— 单锤逻辑 ————————————————————

	//变量类型
	
endmodule

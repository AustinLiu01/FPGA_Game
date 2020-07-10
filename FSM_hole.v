module FSM_hole(up, down, clk, mode, hole_rst);
	input up, down, clk;
	output [3:0]mode;			 //洞口模式
	output [9:0]hole_rst;	 //洞口选择
	//变量类型
	wire [1:0]state;
	wire [1:0]next;
	reg [1:0]nextl;
	reg [3:0]mode;
	reg [9:0]hole_rst;
	//屏蔽复位信号
	wire rst_n;
	assign rst_n = 0 ;
	//实例化
	Fellow C(clk, rst_n, clkout);
	D_Latch #(2) D(clkout, rst_n, next, state);
	//状态机
	always @(*) begin
		case(state)
			2'b00:{mode, hole_rst, nextl} = {4'b1101, 10'b1111111100, up? {down? 2'b00:2'b00}:2'b01};
			2'b01:{mode, hole_rst, nextl} = {4'b1100, 10'b1111100000, up? {down? 2'b01:2'b00}:2'b10};
			2'b10:{mode, hole_rst, nextl} = {4'b1011, 10'b1110000000, up? {down? 2'b10:2'b01}:2'b11};
			2'b11:{mode, hole_rst, nextl} = {4'b1010, 10'b0000000000, up? {down? 2'b11:2'b10}:2'b11};
			default:{mode, hole_rst, nextl} = {4'b0000, 10'b1111111111, 2'b00};
		endcase
	end
	//最后
	assign next = nextl;
endmodule

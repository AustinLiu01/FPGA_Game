module setting_delay(clk, rst, up, down, out, display_delay) ;
	input clk, rst, up, down ;
	output out ;
	output [6:0] display_delay;
	//变量类型
	wire rst_n ;
	wire [1:0] state ;
	wire [1:0] next ;
	wire clkout0 ;
	wire clkout1 ;
	wire clkout2 ;
	reg [1:0] nextl ;
	reg out ;
	reg [6:0] display_delay;
	//屏蔽信号
	assign rst_n = 0 ;
	//三个不同频率的时钟
	Fellow #(25000000) C(clk, rst_n, clkout);
	Fellow #(50000000) C0(clk, rst_n, clkout0) ;
	Fellow #(5000000) C1(clk, rst_n, clkout1) ;
	Fellow #(500000) C2(clk, rst_n, clkout2) ;
	//触发器
	D_Latch #(2) D(clkout, rst, next, state) ;
	//状态机
	always @(*) begin
		case(state)
			2'b00: {display_delay, out, nextl} = {7'b1000110, clkout0, up? {down? 2'b00:2'b00}:2'b01} ;
			2'b01: {display_delay, out, nextl} = {7'b0000011, clkout1, up? {down? 2'b01:2'b00}:2'b10} ;
			2'b10: {display_delay, out, nextl} = {7'b0001000, clkout2, up? {down? 2'b10:2'b01}:2'b10} ;
			default: {out, nextl} = {clkout0, 2'b00} ;
		endcase
	end
	//最后
	assign next = nextl ;
endmodule

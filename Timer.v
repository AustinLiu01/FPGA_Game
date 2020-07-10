module Timer(rst, clk, done, pre);
	input rst, clk;
	output done, pre;
	//变量类型
	wire [3:0]state;
	wire [3:0]next;
	reg done, pre;
	reg [3:0]nextl;
	//触发器
	D_Latch #(4) D(clk, rst, next, state);
	//FSM
	always @(*) begin
		case(state)
			4'b0000: {done, pre, nextl} = {1'b0, 1'b0,  4'b0001};
			4'b0001: {done, pre, nextl} = {1'b0, 1'b0,  4'b0010};
			4'b0010: {done, pre, nextl} = {1'b0, 1'b0,  4'b0011};
			4'b0011: {done, pre, nextl} = {1'b0, 1'b0,  4'b0100};
			4'b0100: {done, pre, nextl} = {1'b0, 1'b0,  4'b0101};
			4'b0101: {done, pre, nextl} = {1'b0, 1'b0,  4'b0110};
			4'b0110: {done, pre, nextl} = {1'b0, 1'b1,  4'b0111};
			4'b0111: {done, pre, nextl} = {1'b0, 1'b1,  4'b1000};
			4'b1000: {done, pre, nextl} = {1'b1, 1'b0,  4'b1001};
			4'b1001: {done, pre, nextl} = {1'b1, 1'b0,  4'b0000};
			default:{done, pre, nextl} = {1'b0, 1'b0, 4'b0000};
		endcase
  end
  //最后
  assign next = nextl;
endmodule

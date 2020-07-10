module FSM_mouse(clk, rst, sw, keep, seed, out, fail);
	input clk, rst, sw, keep;
	input [30:0]seed;
	output out, fail;
	//变量类型
	wire [4:0] state;
	wire [4:0] next;
	reg [4:0] nextl;
	reg out;
	//分频测试
	//Fellow #(50000000) C(clk, rst, clkout);
	//计时器
	wire stop;
	Timer T(stop, clk, done, pre);
	assign stop = rst | keep | sw;
	assign jump = done | sw ;
	assign fail = pre & out ;
	//触发器
	D_Latch #(5) D(jump, rst, next, state);
	//状态机
	always @(*) begin
		case(state)
			5'b00000: {nextl, out} = {keep? 5'b00000:5'b00001, 1'b0};		
			5'b00001: {nextl, out} = {keep? 5'b00001:5'b00010, seed[0]};				
			5'b00010: {nextl, out} = {keep? 5'b00010:5'b00011, seed[1]};				
			5'b00011: {nextl, out} = {keep? 5'b00011:5'b00100, seed[2]};				
			5'b00100: {nextl, out} = {keep? 5'b00100:5'b00101, seed[3]};				
			5'b00101: {nextl, out} = {keep? 5'b00101:5'b00110, seed[4]};					
			5'b00110: {nextl, out} = {keep? 5'b00110:5'b00111, seed[5]};				
			5'b00111: {nextl, out} = {keep? 5'b00111:5'b01000, seed[6]};				
			5'b01000: {nextl, out} = {keep? 5'b01000:5'b01001, seed[7]};				
			5'b01001: {nextl, out} = {keep? 5'b01001:5'b01010, seed[8]};				
			5'b01010: {nextl, out} = {keep? 5'b01010:5'b01011, seed[9]};				
			5'b01011: {nextl, out} = {keep? 5'b01011:5'b01100, seed[10]};				
			5'b01100: {nextl, out} = {keep? 5'b01100:5'b01101, seed[11]};				
			5'b01101: {nextl, out} = {keep? 5'b01101:5'b01110, seed[12]};				
			5'b01110: {nextl, out} = {keep? 5'b01110:5'b01111, seed[13]};				
			5'b01111: {nextl, out} = {keep? 5'b01111:5'b10000, seed[14]};				
			5'b10000: {nextl, out} = {keep? 5'b10000:5'b10001, seed[15]};			
			5'b10001: {nextl, out} = {keep? 5'b10001:5'b10010, seed[16]};				
			5'b10010: {nextl, out} = {keep? 5'b10010:5'b10011, seed[17]};				
			5'b10011: {nextl, out} = {keep? 5'b10011:5'b10100, seed[18]};				
			5'b10100: {nextl, out} = {keep? 5'b10100:5'b10101, seed[19]};				
			5'b10101: {nextl, out} = {keep? 5'b10101:5'b10110, seed[20]};				
			5'b10110: {nextl, out} = {keep? 5'b10110:5'b10111, seed[21]};				
			5'b10111: {nextl, out} = {keep? 5'b10111:5'b11000, seed[22]};				
			5'b11000: {nextl, out} = {keep? 5'b11000:5'b11001, seed[23]};				
			5'b11001: {nextl, out} = {keep? 5'b11001:5'b11010, seed[24]};				
			5'b11010: {nextl, out} = {keep? 5'b11010:5'b11011, seed[25]};				
			5'b11011: {nextl, out} = {keep? 5'b11011:5'b11100, seed[26]};				
			5'b11100: {nextl, out} = {keep? 5'b11100:5'b11101, seed[27]};				
			5'b11101: {nextl, out} = {keep? 5'b11101:5'b11110, seed[28]};				
			5'b11110: {nextl, out} = {keep? 5'b11110:5'b11111, seed[29]};				
			5'b11111: {nextl, out} = {keep? 5'b11111:5'b00000, seed[30]};	
			default:{nextl, out} = {5'b00000, 1'b0};	
		endcase
	end
	//最后
	assign next = nextl;
endmodule
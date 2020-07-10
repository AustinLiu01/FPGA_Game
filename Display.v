//宏定义
`define Y0 7'b1000000
`define Y1 7'b1111001
`define Y2 7'b0100100
`define Y3 7'b0110000
`define Y4 7'b0011001
`define Y5 7'b0010010
`define Y6 7'b0000010
`define Y7 7'b1111000
`define Y8 7'b0000000
`define Y9 7'b0010000
`define Ya 7'b0001000
`define Yb 7'b0000011
`define Yc 7'b1000110
`define Yd 7'b0100001
`define Ye 7'b0000110
`define Yf 7'b0001110
 
module Display(in, out) ;
	input [3:0] in ;
	output [6:0] out ;
	//变量类型
	reg [6:0] out ;
	//赋值
	always @(*) begin
		case(in)
			4'b0000: out = `Y0 ;
			4'b0001: out = `Y1 ;
			4'b0010: out = `Y2 ;
			4'b0011: out = `Y3 ;
			4'b0100: out = `Y4 ;
			4'b0101: out = `Y5 ;
			4'b0110: out = `Y6 ;
			4'b0111: out = `Y7 ;
			4'b1000: out = `Y8 ;
			4'b1001: out = `Y9 ;
			4'b1010: out = `Ya ;
			4'b1011: out = `Yb ;
			4'b1100: out = `Yc ;
			4'b1101: out = `Yd ;
			4'b1110: out = `Ye ;
			4'b1111: out = `Yf ;
			default: out = 7'b0000000 ;
		endcase
	end
endmodule

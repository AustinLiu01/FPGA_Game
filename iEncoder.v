module iEncoder(in, out);
	input [3:0]in;
	output [5:0]out;
	//变量类型
	reg [5:0]out;
	//译码规定
	always @(*) begin
		case(in)
			4'b1101: out = 6'b010100;
			4'b1100: out = 6'b011110;
			4'b1011: out = 6'b101000;
			4'b1010: out = 6'b110010;
			default: out = 0;
		endcase
	end
endmodule

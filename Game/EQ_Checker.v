module EQ_Checker(a, b, out) ;
	parameter n = 4 ;
	input [n-1:0] a ;
	input [n-1:0] b ;
	output out ;
	
	assign out = (a == b);
	//变量类型
	//reg out ;
	//条件语句
	//always @(*) begin
		//if(a == b)
			//out <= 1 ;
		//else 
			//out <=0 ;
	//end
endmodule

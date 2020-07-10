module Reset_Delay(in_CLK,out_RESET);//作为分频器
input in_CLK;
output reg out_RESET;
reg[19:0] Cont;
 
always@(posedge in_CLK)
begin
	if(Cont!=20'hfffff)
		begin
			Cont<=Cont+1'b1;
			out_RESET<=1'b0;
		end
	else
		out_RESET<=1'b1;
end
endmodule
		
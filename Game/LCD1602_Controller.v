module LCD1602_Controller(
//Host Side
input in_CLK,in_RST_N,
input in_RS,in_Start,
input[7:0] in_DATA,
output reg out_Done,
//LCD1602 Interface
output[7:0] LCD_DATA,
output LCD_RS,
output LCD_RW,
output reg LCD_EN
);
//Internal Register
reg[4:0] Cont;
reg[1:0] ST;
reg pre_Start,m_Start;
//Only write to LCD,bypass iRS to LCD_RS
assign LCD_DATA	=	in_DATA;
assign LCD_RS	=	in_RS;
assign LCD_RW	=	1'b0;//固定写模式
parameter CLK_Divide	=	16;
always@(posedge in_CLK or negedge in_RST_N)
begin
	if(!in_RST_N)//没有复位时
	begin
		out_Done	<=	1'b0;
		LCD_EN	<=	1'b0;//还不能开写
		pre_Start<=	1'b0;//跳过准备状态
		m_Start	<=	1'b0;
		Cont	<=	0;
		ST		<=	0;
	end
	else
	begin	
	//Input Start Detect，复位时代表一直处于prepare状态
	pre_Start	<=	in_Start;
	if({pre_Start,in_Start}==2'b01)//复位无效，从prepare进入开始状态
	begin
		m_Start	<=	1'b1;
		out_Done	<=	1'b0;
	end
	if(m_Start)
	begin
		case(ST)
			0:	ST	<=	1;	//Wait Setup,开始前延迟一个周期
			1:	begin
					LCD_EN	<=	1'b1;
					ST		<=	2;
				end
			2:	begin
					if(Cont<CLK_Divide)
						Cont	<=	Cont+5'b1;//等待16个周期，十六个周期可打印
					else
						ST		<=	3;
				end
			3:	begin
					LCD_EN	<=	1'b0;
					m_Start	<=	1'b0;
					out_Done	<=	1'b1;//代表完成
					Cont	<=	0;
					ST		<=	0;//开始下一个循环
				end
		endcase
		end
	end
end
endmodule
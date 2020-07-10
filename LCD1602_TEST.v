`define LCD_INITIAL 1'b0
`define LCD_LINE1	3'b101	//Just have 5 control command
`define LCD_CH_LINE	`LCD_LINE1+16	//Change Line
`define LCD_LINE2	`LCD_LINE1+17
`define LUT_SIZE	`LCD_LINE1+33


module LCD1602_TEST(
input in_CLK,in_RST_N,	//Host Side
input [127:0] word_line1,
input [127:0] word_line2,
output[7:0] LCD_DATA,	//LCD1602 Side
output LCD_RS,LCD_RW,LCD_EN
);


//Internal Wires/Registers
reg[5:0] LUT_INDEX;
reg[8:0] LUT_DATA;
reg[5:0] mLCD_ST;
reg[15:0] mDLY;
reg[7:0] mLCD_DATA;
reg	mLCD_Start;
reg	mLCD_RS;
wire mLCD_Done;



//输出LCD 
always@(posedge in_CLK or negedge in_RST_N)
begin
	if(!in_RST_N)//复位无效时
	begin
		LUT_INDEX	<=	0;
		mLCD_ST		<=	0;
		mDLY		<=	0;
		mLCD_Start	<=	0;
		mLCD_DATA	<=	0;
		mLCD_RS		<=	0;
	end
	else
	begin
		if(LUT_INDEX<`LUT_SIZE)
		begin
			case(mLCD_ST)
				0:	begin
						mLCD_DATA	<=	LUT_DATA[7:0];
						mLCD_RS		<=	LUT_DATA[8];
						mLCD_Start	<=	1;
						mLCD_ST		<=	1;
					end
				1:	begin
						if(mLCD_Done)
						begin
							mLCD_Start	<=	0;
							mLCD_ST		<=	2;
						end
					end
				2:	begin
						if(mDLY<16'hffff)
							mDLY	<=	mDLY+16'b1;
						else
						begin
							mDLY	<=	0;
							mLCD_ST	<=	3;
						end
					end
				3:	begin
						LUT_INDEX	<=	LUT_INDEX+6'b1;
						mLCD_ST		<=	0;
					end
			endcase
		end
		else 
				LUT_INDEX <= 0;
	end
end
always@(*)
	begin
		case(LUT_INDEX)
		//	Inital
		`LCD_INITIAL+0:	LUT_DATA	<=	9'h038;	//设置16x2显示，5x7点阵，8位数据接口
		`LCD_INITIAL+1:	LUT_DATA	<=	9'h00C;	//设置开显示，不显示光标
		`LCD_INITIAL+2:	LUT_DATA	<=	9'h001;	//显示清零，数据指针清零
		`LCD_INITIAL+3:	LUT_DATA	<=	9'h006;	//写一个字符后地址指针加一
		`LCD_INITIAL+4:	LUT_DATA	<=	9'h080;	//Line1 First Address
		// 	Line1的显示
		`LCD_LINE1+0:	LUT_DATA	<=	{1'b1,word_line1[127:120]};	
		`LCD_LINE1+1:	LUT_DATA	<=	{1'b1,word_line1[119:112]};	
		`LCD_LINE1+2:	LUT_DATA	<=	{1'b1,word_line1[111:104]};	
		`LCD_LINE1+3:	LUT_DATA	<=	{1'b1,word_line1[103:96]};
		`LCD_LINE1+4:	LUT_DATA	<=	{1'b1,word_line1[95:88]};	
		`LCD_LINE1+5:	LUT_DATA	<=	{1'b1,word_line1[87:80]};	
		`LCD_LINE1+6:	LUT_DATA	<=	{1'b1,word_line1[79:72]};	
		`LCD_LINE1+7:	LUT_DATA	<=	{1'b1,word_line1[71:64]};	
		`LCD_LINE1+8:	LUT_DATA	<=	{1'b1,word_line1[63:56]};	
		`LCD_LINE1+9:	LUT_DATA	<=	{1'b1,word_line1[55:48]};	
		`LCD_LINE1+10:	LUT_DATA	<=	{1'b1,word_line1[47:40]};	
		`LCD_LINE1+11:	LUT_DATA	<=	{1'b1,word_line1[39:32]};	
		`LCD_LINE1+12:	LUT_DATA	<=	{1'b1,word_line1[31:24]};	
		`LCD_LINE1+13:	LUT_DATA	<=	{1'b1,word_line1[23:16]};	
		`LCD_LINE1+14:	LUT_DATA	<=	{1'b1,word_line1[15:8]};	
		`LCD_LINE1+15:	LUT_DATA	<=	{1'b1,word_line1[7:0]};	
		//	Change Line
		`LCD_CH_LINE:	LUT_DATA	<=	9'h0C0;
		//	Line 2
		`LCD_LINE2+0:	LUT_DATA	<=	{1'b1,word_line2[127:120]};	//	www.njodin.com
		`LCD_LINE2+1:	LUT_DATA	<=	{1'b1,word_line2[119:112]};	//
		`LCD_LINE2+2:	LUT_DATA	<=	{1'b1,word_line2[111:104]};	//
		`LCD_LINE2+3:	LUT_DATA	<=	{1'b1,word_line2[103:96]};	//
		`LCD_LINE2+4:	LUT_DATA	<=	{1'b1,word_line2[95:88]};	//
		`LCD_LINE2+5:	LUT_DATA	<=	{1'b1,word_line2[87:80]};	//
		`LCD_LINE2+6:	LUT_DATA	<=	{1'b1,word_line2[79:72]};	//
		`LCD_LINE2+7:	LUT_DATA	<=	{1'b1,word_line2[71:64]};	//
		`LCD_LINE2+8:	LUT_DATA	<=	{1'b1,word_line2[63:56]};	//
		`LCD_LINE2+9:	LUT_DATA	<=	{1'b1,word_line2[55:48]};	//
		`LCD_LINE2+10:	LUT_DATA	<=	{1'b1,word_line2[47:40]};	//
		`LCD_LINE2+11:	LUT_DATA	<=	{1'b1,word_line2[39:32]};	//
		`LCD_LINE2+12:	LUT_DATA	<=	{1'b1,word_line2[31:24]};	//
		`LCD_LINE2+13:	LUT_DATA	<=	{1'b1,word_line2[23:16]};	//
		`LCD_LINE2+14:	LUT_DATA	<=	{1'b1,word_line2[15:8]};	//
		`LCD_LINE2+15:	LUT_DATA	<=	{1'b1,word_line2[7:0]};	//
		default:		LUT_DATA	<=	9'h120;
		endcase
	end
	
LCD1602_Controller	u0	(	//Host Side
							.in_DATA(mLCD_DATA),
							.in_RS(mLCD_RS),
							.in_Start(mLCD_Start),
							.out_Done(mLCD_Done),
							.in_CLK(in_CLK),
							.in_RST_N(in_RST_N),
							//LCD1602 Interface
							.LCD_DATA(LCD_DATA),
							.LCD_RW(LCD_RW),
							.LCD_EN(LCD_EN),
							.LCD_RS(LCD_RS)
						);
endmodule

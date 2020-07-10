module Game(clk, rst, switch, 
				delay_up, delay_down, mode_up, mode_down, 
				display_delay, display_mode, display_times, display_score, 
				out, point, kp,LCD_BLON,LCD_DATA,LCD_EN,LCD_ON,LCD_RS,LCD_RW
				, total);
				
	input clk, rst;
	input [9:0]switch;
	input delay_up, delay_down, mode_up, mode_down;
	output [6:0]display_delay;
	output [6:0]display_mode;
	output [13:0]display_times;
	output [13:0]display_score;
	output [9:0]out;
	output point, kp;
	output [5:0]total;
	//////////// LCD //////////
	output		          		LCD_BLON;
	inout 		     [7:0]		LCD_DATA;
	output		          		LCD_EN;
	output		          		LCD_ON;
	output		          		LCD_RS;
	output		          		LCD_RW;
		
//———————————————————— 模式设置 ————————————————————
	
	//内部引脚
	wire [9:0]hole_rst;
	wire [5:0]times;
	//实例化
	setting_mode S_M(clk, mode_up, mode_down, hole_rst, display_mode, times);
	Display_double D_d(times, display_times);

//———————————————————— 延迟设置 ————————————————————

	//内部引脚
	wire rst_n;
	assign rst_n = 0;
	wire speed;
	assign point = speed;
	//实例化
	setting_delay S_D(clk, rst_n, delay_up, delay_down, speed, display_delay);

//———————————————————— 主要模块 ————————————————————

	//内部引脚——复位
	wire [9:0]reset;
	assign reset[0] = rst|hole_rst[0];
	assign reset[1] = rst|hole_rst[1];
	assign reset[2] = rst|hole_rst[2];
	assign reset[3] = rst|hole_rst[3];
	assign reset[4] = rst|hole_rst[4];
	assign reset[5] = rst|hole_rst[5];
	assign reset[6] = rst|hole_rst[6];
	assign reset[7] = rst|hole_rst[7];
	assign reset[8] = rst|hole_rst[8];
	assign reset[9] = rst|hole_rst[9];
	//内部引脚——开关
	wire  [9:0]sw;
	assign sw[0] = switch[0]&~switch[1]&~switch[2]&~switch[3]&~switch[4]&~switch[5]&~switch[6]&~switch[7]&~switch[8]&~switch[9];
	assign sw[1] = switch[1]&~switch[0]&~switch[2]&~switch[3]&~switch[4]&~switch[5]&~switch[6]&~switch[7]&~switch[8]&~switch[9];
	assign sw[2] = switch[2]&~switch[1]&~switch[0]&~switch[3]&~switch[4]&~switch[5]&~switch[6]&~switch[7]&~switch[8]&~switch[9];
	assign sw[3] = switch[3]&~switch[1]&~switch[2]&~switch[0]&~switch[4]&~switch[5]&~switch[6]&~switch[7]&~switch[8]&~switch[9];
	assign sw[4] = switch[4]&~switch[1]&~switch[2]&~switch[3]&~switch[0]&~switch[5]&~switch[6]&~switch[7]&~switch[8]&~switch[9];
	assign sw[5] = switch[5]&~switch[1]&~switch[2]&~switch[3]&~switch[4]&~switch[0]&~switch[6]&~switch[7]&~switch[8]&~switch[9];
	assign sw[6] = switch[6]&~switch[1]&~switch[2]&~switch[3]&~switch[4]&~switch[5]&~switch[0]&~switch[7]&~switch[8]&~switch[9];
	assign sw[7] = switch[7]&~switch[1]&~switch[2]&~switch[3]&~switch[4]&~switch[5]&~switch[6]&~switch[0]&~switch[8]&~switch[9];
	assign sw[8] = switch[8]&~switch[1]&~switch[2]&~switch[3]&~switch[4]&~switch[5]&~switch[6]&~switch[7]&~switch[0]&~switch[9];
	assign sw[9] = switch[9]&~switch[1]&~switch[2]&~switch[3]&~switch[4]&~switch[5]&~switch[6]&~switch[7]&~switch[8]&~switch[0];
	
	//内部引脚——保持
	wire keep;
	wire [9:0]fail;
	//实例化
	Main Mouse(speed, reset, sw, keep, out, fail);
	

//———————————————————— 保持模块 ————————————————————

	//内部引脚
	wire [5:0]count_0;
	wire [5:0]count_1;
	wire [5:0]count_2;
	wire [5:0]count_3;
	wire [5:0]count_4;
	wire [5:0]count_5;
	wire [5:0]count_6;
	wire [5:0]count_7;
	wire [5:0]count_8;
	wire [5:0]count_9;
	wire [5:0]total;
	//实例化
	Counter #(6) cnt_0(out[0], rst, count_0);
	Counter #(6) cnt_1(out[1], rst, count_1);
	Counter #(6) cnt_2(out[2], rst, count_2);
	Counter #(6) cnt_3(out[3], rst, count_3);
	Counter #(6) cnt_4(out[4], rst, count_4);
	Counter #(6) cnt_5(out[5], rst, count_5);
	Counter #(6) cnt_6(out[6], rst, count_6);
	Counter #(6) cnt_7(out[7], rst, count_7);
	Counter #(6) cnt_8(out[8], rst, count_8);
	Counter #(6) cnt_9(out[9], rst, count_9);
	
	Sum_10 sum0(count_0, count_1, count_2, count_3, count_4, count_5, count_6, count_7, count_8, count_9, total);
	
	EQ_Checker #(6) EQ(times, total, keep);
	
	assign kp = keep ;

//———————————————————— 分数模块 ————————————————————

	//内部引脚——扣分
	wire [5:0]failure_0;
	wire [5:0]failure_1;
	wire [5:0]failure_2;
	wire [5:0]failure_3;
	wire [5:0]failure_4;
	wire [5:0]failure_5;
	wire [5:0]failure_6;
	wire [5:0]failure_7;
	wire [5:0]failure_8;
	wire [5:0]failure_9;
	//内部引脚——分数
	wire [5:0]miss;
	wire [5:0]score;
	//实例化
	Counter #(6) f_0(fail[0], rst, failure_0);
	Counter #(6) f_1(fail[1], rst, failure_1);
	Counter #(6) f_2(fail[2], rst, failure_2);
	Counter #(6) f_3(fail[3], rst, failure_3);
	Counter #(6) f_4(fail[4], rst, failure_4);
	Counter #(6) f_5(fail[5], rst, failure_5);
	Counter #(6) f_6(fail[6], rst, failure_6);
	Counter #(6) f_7(fail[7], rst, failure_7);
	Counter #(6) f_8(fail[8], rst, failure_8);
	Counter #(6) f_9(fail[9], rst, failure_9);
	
	Sum_10 sum1(failure_0, failure_1, failure_2, failure_3, failure_4, failure_5, failure_6, failure_7, failure_8, failure_9, miss);
	
	Miner Mine(times, miss, score);
	
	Display_double D_B_1(score, display_score);
	
//——————————————————————
		
		
		
		
	//LCD显示模块--------------------------------------------
	
	
	
	
	wire[7:0] LCD_D_1;
	wire LCD_RS_1;
	wire LCD_RW_1;
	wire LCD_EN_1;
	wire DLY_RST;

	wire [9:0] LED_in;
	reg [1:0]state;

	reg [127:0] m;
	wire [127:0] m1,n1;
	reg [127:0] n;
	wire [79:0] LCD_line2;
	
	assign LCD_DATA=LCD_D_1;
	assign LCD_RS=LCD_RS_1;
	assign LCD_RW=LCD_RW_1;
	assign LCD_EN=LCD_EN_1;
	assign LCD_ON=1'b1;//默认打开
	assign LCD_BLON=1'b0;

	assign m1=m;
	assign n1=n;


	Reset_Delay r0(.in_CLK(clk),	.out_RESET(DLY_RST));


	connect_LED_to_LCD_single U0(clk,out[0],LCD_line2[7:0]);
	connect_LED_to_LCD_single U1(clk,out[1],LCD_line2[15:8]);
	connect_LED_to_LCD_single U2(clk,out[2],LCD_line2[23:16]);
	connect_LED_to_LCD_single U3(clk,out[3],LCD_line2[31:24]);
	connect_LED_to_LCD_single U4(clk,out[4],LCD_line2[39:32]);
	connect_LED_to_LCD_single U5(clk,out[5],LCD_line2[47:40]);
	connect_LED_to_LCD_single U6(clk,out[6],LCD_line2[55:48]);
	connect_LED_to_LCD_single U7(clk,out[7],LCD_line2[63:56]);
	connect_LED_to_LCD_single U8(clk,out[8],LCD_line2[71:64]);
	connect_LED_to_LCD_single U9(clk,out[9],LCD_line2[79:72]);


LCD1602_TEST u1(	//Host Side
				.in_CLK(clk),
				.in_RST_N(DLY_RST),
				//LCD Side
				.word_line1(m1),
				.word_line2(n1),
				.LCD_DATA(LCD_D_1),
				.LCD_RW(LCD_RW_1),
				.LCD_EN(LCD_EN_1),
				.LCD_RS(LCD_RS_1),
			);
			
reg [127:0] show_line2;
			
	always@(posedge clk)begin
		if(miss<5)
			show_line2 <= "   Excellent!   ";
		else if(miss<10&&miss>4)
			show_line2 <= "     Great!     ";
		else if(miss>9&&miss<15)
			show_line2 <= "     Not Bad    ";
		else 
			show_line2 <= "   keep work!   ";
	end

always@(posedge clk)begin
	case(state)
	2'b00:begin
			m <= "WELCOME TO GAME!";
			n <= "                ";
			if(!rst)
				state <= 2'b01;
			end
	2'b01:begin
			m <= "Have a Good Time";
			n <= {LCD_line2[79:72],LCD_line2[71:64],LCD_line2[63:56],
					LCD_line2[55:48],LCD_line2[47:40],LCD_line2[39:32],
					LCD_line2[31:24],LCD_line2[23:16],LCD_line2[15:8],
					LCD_line2[7:0],"      "};
			if(keep)
				state<= 2'b10;
			end
	2'b10:begin
			m <= "   GAME OVER!   ";
			n <= show_line2;
			if(rst)
				state<= 2'b00;
			end
	endcase
end

	
endmodule

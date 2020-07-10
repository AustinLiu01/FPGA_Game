module connect_LED_to_LCD_single(CLK,LED_in,LCD_line2);//此模块用来把LED的输出转化到LCD屏幕的输出

input  LED_in;
input CLK;
output reg [7:0] LCD_line2;//实际上只有十个老鼠洞，无法做到完全均匀排布，左边五个洞，右边五个洞，LED_in为0时，表示老鼠不出来，显示‘O’，为1时，显示‘M’；



always@(posedge CLK)
	begin
		if(LED_in)
			begin
				LCD_line2 <= "M";
			end
		else if(!LED_in)
			begin
				LCD_line2 <= "O";
			end
	end
	
	

	
endmodule

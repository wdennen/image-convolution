`timescale 1ns/1ns
module system_tb();
	
	reg clk;
	reg rst;
	reg [7:0]key_pressed;
	reg key_flag;
	wire [2:0] pix_val;
	wire [2:0] vga_dout;
	wire [19:0] note;
	parameter HOLD = 5'd4;
	
	system uut(
		.clk_proc(clk),
		.clk_vga(clk),
		.rst(rst),
		.key_pressed(key_pressed),
		.key_flag(key_flag),
		.pix_val(pix_val),
		.vga_x(vga_x),
		.vga_y(vga_y),
		.vga_dout(vga_dout),
		.note(note)
	);
	
	
	always #5 clk = ~clk;
	
	initial begin
		clk = 0; rst = 1;
		#10 rst = 0;
		
		
		key_pressed = 8'h16; key_flag = 1;
		#10; 
		key_flag = 0;
		while(uut.processor.controller.state != HOLD)
			#10;
		#20;
		
		key_pressed = 8'h15; key_flag =1;
		#10 key_flag = 0;
		#20
		while(uut.processor.controller.state != HOLD)
			#10;
		#5000;
		
		#10
		$stop;
	
	end
	
endmodule
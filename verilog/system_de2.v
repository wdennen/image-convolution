module system_de2(
	input				CLOCK_50,
	input  [0:0]	KEY,
	inout  PS2_CLK,
	inout  PS2_DAT,
	
	//AUDIO INPUT AND OUTPUT
	input       AUD_ADCDAT,
	inout       AUD_BCLK,
	inout       AUD_ADCLRCK,
	inout       AUD_DACLRCK,
	inout       I2C_SDAT,
	output      AUD_XCK,
	output      AUD_DACDAT,
	output      I2C_SCLK,
	// end audio inputs
	
	output			VGA_CLK,   				//	VGA Clock
	output			VGA_HS,					//	VGA H_SYNC
	output			VGA_VS,					//	VGA V_SYNC
	output			VGA_BLANK,				//	VGA BLANK
	output			VGA_SYNC,				//	VGA SYNC
	output [9:0]	VGA_R,   				//	VGA Red[9:0]
	output [9:0]	VGA_G,	 				//	VGA Green[9:0]
	output [9:0]	VGA_B	   				//	VGA Blue[9:0]
);


   wire   [2:0]  color_vga;
	wire	 [7:0] x_vga;
	wire	 [6:0] y_vga;
	
	system system(
		.clk_proc(CLOCK_50),
		.clk_vga(VGA_CLK),
		.rst(~KEY[0]),
		.key_flag(make), 
		.key_pressed(keycode),
		.vga_x(x_vga),
		.vga_y(y_vga),
		.vga_dout(color_vga),
		.note(note)
	);
	
	wire [19:0] note;
	
	wire [7:0] PS2_key_data;
	wire PS2_key_en;
	wire [7:0] keycode;
	wire keycode_ready;
	wire make;
	wire ext;
	
	PS2_Controller pS2(
		.CLOCK_50 (CLOCK_50),
		.reset(~KEY[0]),
		
		.PS2_CLK(PS2_CLK),
		.PS2_DAT(PS2_DAT),
		
		.received_data (PS2_key_data),
		.received_data_en (PS2_key_en)
	);
	
	
	keycode_recognizer key(
		.clk(CLOCK_50),
		.reset_n(KEY[0]),
		.ps2_key_en (PS2_key_en),
		.ps2_key_data (PS2_key_data),
		.keycode(keycode),
		.ext(ext),
		.make(make),
		.keycode_ready (keycode_ready)
	);
		
		
	vga_xy_controller vga_xy_controller (
      .CLOCK_50      (CLOCK_50),
      .resetn        (1),
      .color         (color_vga),
      .x             (x_vga),
      .y             (y_vga),
      .VGA_R         (VGA_R),
      .VGA_G         (VGA_G),
      .VGA_B         (VGA_B),
      .VGA_HS        (VGA_HS),
      .VGA_VS        (VGA_VS),
      .VGA_BLANK     (VGA_BLANK),
      .VGA_SYNC      (VGA_SYNC),
      .VGA_CLK       (VGA_CLK)				
   );

	/**
	
	Audio stuff
	
	**/
	
   wire				   audio_out_allowed;
   wire     [31:0]   osc_out;   

   square_wave_osc osc (
      .CLOCK_50						(CLOCK_50),
		.music							(note),		//This note controlled by audio_player in big_system
      .reset						   (~KEY[0]),	//Stops / resets the music
      .out                       (osc_out)
   );

   Audio_Controller Audio_Controller (
      // Inputs
      .CLOCK_50						(CLOCK_50),
      .reset						   (~KEY[0]),
      .left_channel_audio_out		(osc_out),
      .right_channel_audio_out	(osc_out),
      .write_audio_out			   (audio_out_allowed),
      .AUD_ADCDAT					   (AUD_ADCDAT),
      // Bidirectionals
      .AUD_BCLK					   (AUD_BCLK),
      .AUD_ADCLRCK				   (AUD_ADCLRCK),
      .AUD_DACLRCK				   (AUD_DACLRCK),
      // Outputs
      .audio_out_allowed			(audio_out_allowed),
      .AUD_XCK					      (AUD_XCK),
      .AUD_DACDAT					   (AUD_DACDAT),
   );
   
   avconf avc (
      .I2C_SCLK					(I2C_SCLK),
      .I2C_SDAT					(I2C_SDAT),
      .CLOCK_50					(CLOCK_50),
      .reset						(~KEY[0])
   );


	
	
endmodule
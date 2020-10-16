module controller(
	input clk,
	input rst,
	input ker_final_addr, //flag activated when all kernel pixels have been loaded
	input nine_flag, //flag that goes high when all nine pixels from original image have been loaded
	input pix_final_addr, //flag that gose high when all of the images pixels have been convoluted
	input [7:0]key_pressed, 
	input key_flag, 
	input sum_flag, //flag that goes high when the output of the matrix multiplciation is added up.
	
	output reg en_ker,
	
	output reg en_read_pix,
	output reg s_read_pix,
	
	output reg en_apply_ker,
	output reg s_apply_ker,
	
	output reg s_ker_addr,
	output reg en_ker_addr,
	
	output reg en_load_nine,
	output reg s_load_nine,
	
	output reg en_key,
	output reg s_key,
	
	output reg en_rst_sumnine,
	
	output reg s_inc_ker,
	
	output reg s_inc_pix,
	output reg en_inc_pix,
	
	output reg s_inc_nine,
	
	output reg s_inc_sum,
	
	output reg en_divide_ker,
	
	output reg en_inc_ker,
	
	output reg en_inc_nine,
	
	output reg en_inc_sum,
	
	output reg en_rst_nine,
	
	output reg en_rst_inc_pix,
	
	output reg s_divide_ker
	
);

parameter INIT = 5'd0;
parameter READ_KEY = 5'd1;
parameter HOLD = 5'd4;
parameter READ_KER = 5'd5;
parameter READ_PIX = 5'd6;
parameter LOAD_NINE = 5'd7; //YO
parameter APPLY_KER = 5'd8;
parameter INC_KER = 5'd9;
parameter INC_PIX = 5'd10; //yo
parameter INC_NINE = 5'd11; //yo
parameter INC_SUM = 5'd12;
parameter DIVIDE_KER = 5'd13;

reg [4:0] state, nextstate;

always @(posedge clk)
	if(rst)
		state <= INIT;
	else
		state <= nextstate;


always @(*) begin
	s_read_pix = 0;
	en_read_pix = 0;
	en_ker_addr = 0; s_ker_addr = 0;
	 s_apply_ker = 0; en_apply_ker = 0;
	en_load_nine = 0; s_load_nine = 0;
	en_key = 0; s_key = 0; s_inc_nine = 0;
	s_inc_ker = 0; s_inc_pix = 0;
	en_divide_ker = 0; s_divide_ker =0;
	s_inc_sum = 0;
	en_inc_ker = 0; en_inc_nine = 0;
	en_inc_pix = 0; en_inc_sum = 0; en_rst_nine = 0;
	en_rst_inc_pix = 0; en_rst_sumnine = 0;
	nextstate = INIT;
	case (state)
		INIT: begin
			en_ker_addr = 1;	 	 s_ker_addr = 0;
			en_read_pix = 1;	 	 s_read_pix = 0;
			en_load_nine=  1;		 s_load_nine = 0;
			en_apply_ker = 1; 	 s_apply_ker = 0;
			en_key = 1; 		    s_key = 0;
			s_inc_ker = 0;			 en_inc_ker = 1;
											s_inc_pix = 0;		s_inc_sum = 0;	
			en_divide_ker = 1; 	 s_divide_ker = 0;
			en_inc_nine= 1; 		 s_inc_nine = 0;
			en_inc_pix= 1; en_inc_sum = 1;
			en_rst_nine = 1;
			en_rst_inc_pix = 1; en_rst_sumnine = 1;
			if (key_flag)
				nextstate = READ_KEY;
			else
				nextstate = INIT;
		end
		
		READ_KEY: begin					//This state reads the key and decides how to precede next
			en_key = 1; s_key = 1;
			case(key_pressed)
				8'h16: begin
					nextstate = HOLD;
					end
				8'h1E: begin
					nextstate = HOLD;
					end
				8'h26: begin
					nextstate = HOLD;
					end
				8'h15: begin
					nextstate = READ_KER;
				end
				8'h1d: begin
					nextstate = READ_KER;
				end
				8'h24: begin
					nextstate = READ_KER;
				end
				default: ;
			endcase
		end
		
		
		HOLD: begin								//Our final state that keeps the current image on the display
			s_divide_ker = 0;
			if(key_flag)
				nextstate = READ_KEY;
			else
				nextstate = HOLD;
		end
		
		
		READ_KER: begin 								//reads in our nine kernel pixels
			en_ker_addr = 1; s_ker_addr = 1;
			nextstate = INC_KER;
		end
		
		INC_KER: begin								//increments the address for above state
			en_inc_ker = 1; s_inc_ker = 1;
			if(ker_final_addr)
				nextstate = READ_PIX;
			else
				nextstate = READ_KER;
		end
		
		READ_PIX: begin								//chooses the pixel to be convoluted from original image
			en_read_pix = 1; s_read_pix = 1;
			if(pix_final_addr) 
				nextstate = HOLD; 
			else	
				nextstate = LOAD_NINE;
		end

		LOAD_NINE: begin								//loads the nine surrounding pixels
			en_load_nine = 1; s_load_nine = 1;
			nextstate = INC_NINE;
		end
		
		INC_NINE: begin								//increments for the above state
			s_inc_nine = 1; en_inc_nine = 1;
			if(nine_flag) begin
				nextstate = APPLY_KER;
				en_rst_nine = 1; en_rst_inc_pix = 1;
			end
			else
				nextstate = INC_PIX;
		end
		
		INC_PIX: begin									//increments the current pixel address
			s_inc_pix = 1; en_inc_pix = 1;
			nextstate = LOAD_NINE;
		end
		
		APPLY_KER: begin								//computes the matrix multiplication
			s_inc_nine = 0; s_inc_pix = 0;
			en_apply_ker = 1; s_apply_ker = 1;
			nextstate = INC_SUM;
		end
		
		INC_SUM: begin									//cycles through addresses for above state
			en_inc_sum = 1; s_inc_sum = 1;
			if(sum_flag) begin
				en_rst_sumnine = 1;
				nextstate = DIVIDE_KER;
			end
			else
				nextstate = APPLY_KER;
		end
		
		DIVIDE_KER: begin								//sets the output pixel
			s_inc_sum = 0; s_apply_ker = 0; en_apply_ker = 1;
			en_divide_ker = 1; s_divide_ker = 1;
			nextstate = READ_PIX;
		end
		
	endcase

end


endmodule
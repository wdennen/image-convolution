module datapath(
	input clk,
	input rst,
	
	input [4:0] ker_din, //this is signed
	input [2:0] pix_din, 
	input [7:0]key_pressed,
		
	input en_ker_addr,
	input s_ker_addr,
	
	input s_inc_sum,
	
	input en_key,
	input s_key,
	
	input en_read_pix,
	input s_read_pix,
	
	
	input en_apply_ker,
	input s_apply_ker,
	
	input en_load_nine,
	input s_load_nine,
	
	input s_inc_ker,
	input en_inc_ker,
	
	input en_inc_nine,
	input s_inc_nine,
	
	input s_inc_pix,
	input en_inc_pix,
	
	input en_divide_ker,
	input s_divide_ker,
	
	input en_rst_nine,
	
	input en_rst_inc_pix,
	
	input en_inc_sum,
	
	input en_rst_sumnine,
	
	output ker_final_addr,
	output pix_final_addr,
	output nine_flag,
	output reg [3:0] ker_addr,
	output reg [2:0] pix_val,
	output reg [7:0] nine_x_addr,
	output reg [6:0] nine_y_addr,
	output reg [2:0] conv_pix,
	output reg [2:0] s_im,
	output reg [2:0] s_mus,
	output sum_flag,
	output reg [2:0] s_ker,
	output reg [2:0] newpix,
	output reg [7:0] pix_x_addr,
	output reg [6:0] pix_y_addr,
	output reg we
);
	
	reg signed [4:0] kernel [0:8];	//stores the current kernel
	reg [3:0]nine; 						
	reg [2:0] pixels [0:8];				//stores the pixel to be changed and its neighbors
	reg signed [4:0] sumr;
	reg signed [4:0] sumg;
	reg signed [4:0] sumb;
	reg [3:0] sumnine;
	
	always @(posedge clk)begin
		if(en_key)begin				//READ_KEY
			if(s_key)
				case(key_pressed)
					8'h16: begin
						s_im <= 1;
						s_ker <= 0;
						s_mus <= 1;
					end
					8'h1E: begin
						s_im <= 2;
						s_ker <= 0;
						s_mus <= 2;
					end
					8'h26: begin
						s_im <= 3;
						s_ker <= 0;
						s_mus <= 3;
					end
					8'h15: begin	
						s_ker <= 1;
					end
					8'h1d: begin
						s_ker <= 2;
					end
					8'h24: begin
						s_ker <= 3;
					end
					default: s_ker <= 0;
			endcase
			else begin
				s_im <= 0; s_ker <= 0; s_mus <= 0;
			end
		end
	end
	
	always @(posedge clk) 				//READ_KER
		if(en_ker_addr)
			if(s_ker_addr)begin
				kernel[ker_addr] <= ker_din;
				end
			
	always @(posedge clk)				//INC_KER
		if(en_inc_ker)
			if(s_inc_ker)
				ker_addr <= ker_addr + 1;
			else
				ker_addr <= 0;
			
	always @(posedge clk)						//READ_PIX
		if(en_read_pix)
			if(s_read_pix)
				if(pix_x_addr == 159) begin
					 pix_x_addr <= 1;
					 pix_y_addr <= pix_y_addr + 1;
				end
				else
					pix_x_addr <=  pix_x_addr + 1;
			else begin
				pix_x_addr <= 0; pix_y_addr <= 0;
			end
	 
	 always @(posedge clk)begin 				//LOAD NINE
		if(en_load_nine)
			if(s_load_nine) begin
				pixels[nine] <= pix_din;
			end
		end
		
	always @(posedge clk)begin
		if(en_inc_nine)begin
			if(s_inc_nine)
				nine <= nine + 1;
			else
				nine <= 0;
		end
		if(en_rst_nine)
			nine <= 0;
	end
		
	always @(posedge clk) begin						//INC_PIX
		if(en_inc_pix) begin
			if(s_inc_pix)begin
				if(nine_x_addr == pix_x_addr + 1) begin
					nine_y_addr <= nine_y_addr + 1;
					nine_x_addr <= pix_x_addr - 1;
				end
				else begin
				nine_x_addr <= nine_x_addr + 1;
				end
			end
			else begin
				nine_x_addr <= 0; nine_y_addr <= 0;
			end
		end
		if(en_rst_inc_pix) begin
			nine_x_addr <= pix_x_addr - 1; nine_y_addr <= pix_y_addr - 1;
		end
	end
			
			
		always @(posedge clk)							//APPLY_KER
			if(en_apply_ker)begin
				if(s_apply_ker) begin
					//do r
					sumr <= sumr + (pixels[sumnine][2] * kernel[sumnine]);
					//do g
					sumg <= sumg + (pixels[sumnine][1] * kernel[sumnine]);
					//do b
					sumb <= sumb + (pixels[sumnine][0] * kernel[sumnine]);
					//move on to next
				end
				else begin
					sumr <= 0;
					sumg <= 0;
					sumb <= 0;
				end
			end
			
		always @(posedge clk)begin							//INC_SUM
			if(en_inc_sum)begin
				if(s_inc_sum)
					sumnine <= sumnine + 1;
				else
					sumnine <= 0;
			end
			if(en_rst_sumnine)
				sumnine <= 0;
		end
				
		always @(posedge clk)							//DIVIDE_KER
			if(en_divide_ker)
				if(s_divide_ker)begin
					newpix[2] <= sumr / 1;
					newpix[1] <= sumg / 1;
					newpix[0] <= sumb / 1;
					we <= 1;
				end
				else begin
					newpix <= 0; we <= 0;	
				end
	
	assign pix_final_addr = pix_y_addr == 119  && pix_x_addr == 159;
	assign ker_final_addr = ker_addr == 9;
	assign nine_flag = nine == 8;
	assign sum_flag = sumnine == 8;
endmodule
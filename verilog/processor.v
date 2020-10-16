module processor(
	input clk,
	input rst,
	input [7:0]key_pressed,
	input key_flag,
	input [2:0] pix_din,
	input  [4:0] ker_din,
	output [2:0] s_im,
	output [2:0] s_ker,
	output [3:0] ker_addr,
	output [7:0] nine_x_addr,
	output [6:0] nine_y_addr,
	output [7:0] pix_x_addr,
	output [6:0] pix_y_addr,
	output we,
	output [2:0] s_mus,
	output [2:0] newpix
);
	
	wire ker_final_addr;
	wire en_ker_addr;
	wire s_ker_addr;
	wire en_load_nine;
	wire s_load_nine;
	wire en_read_pix;
	wire s_read_pix;
	wire pix_final_addr;
	wire nine_flag;
	wire nine_final_addr;
	wire en_apply_ker;
	wire s_apply_ker;
	wire en_key;
	wire s_key;
	wire s_inc_ker;
	wire s_inc_pix;
	wire s_inc_nine;
	wire s_inc_sum;
	wire sum_flag;
	wire en_divide_ker;
	wire s_divide_ker;
	wire en_inc_ker;
	wire en_inc_nine;
	wire en_inc_pix;
	wire en_inc_sum;
	wire en_rst_nine;
	wire en_rst_inc_pix;
	wire en_rst_sumnine;
	
	controller controller(
		.clk(clk),
		.rst(rst),
		.ker_final_addr(ker_final_addr),
		.key_pressed(key_pressed),
		.key_flag(key_flag),
		.s_inc_ker(s_inc_ker),
		.en_inc_ker(en_inc_ker),
		.en_key(en_key),
		.en_inc_nine(en_inc_nine),
		.s_key(s_key),
		.s_inc_sum(s_inc_sum),
		.s_inc_pix(s_inc_pix),
		.en_ker_addr(en_ker_addr),
		.s_inc_nine(s_inc_nine),
		.en_read_pix(en_read_pix),
		.s_read_pix(s_read_pix),
		.en_load_nine(en_load_nine),
		.en_apply_ker(en_apply_ker),
		.sum_flag(sum_flag),
		.s_apply_ker(s_apply_ker),
		.s_load_nine(s_load_nine),
		.s_ker_addr(s_ker_addr),
		.pix_final_addr(pix_final_addr),
		.en_divide_ker(en_divide_ker),
		.s_divide_ker(s_divide_ker),
		.nine_flag(nine_flag),
		.en_inc_pix(en_inc_pix),
		.en_inc_sum(en_inc_sum),
		.en_rst_nine(en_rst_nine),
		.en_rst_sumnine(en_rst_sumnine),
		.en_rst_inc_pix(en_rst_inc_pix)
	);
	
	datapath datapath(
		.clk(clk),
		.rst(rst),
		.ker_din(ker_din),
		.key_pressed(key_pressed),
		.pix_din(pix_din),
		.s_inc_ker(s_inc_ker),
		.s_inc_sum(s_inc_sum),
		.en_apply_ker(en_apply_ker),
		.s_apply_ker(s_apply_ker),
		.en_inc_nine(en_inc_nine),
		.s_ker(s_ker),
		.en_inc_ker(en_inc_ker),
		.en_key(en_key),
		.s_inc_pix(s_inc_pix),
		.s_inc_nine(s_inc_nine),
		.s_key(s_key),
		.ker_final_addr(ker_final_addr),
		.ker_addr(ker_addr),
		.en_ker_addr(en_ker_addr),
		.s_im(s_im),
		.s_ker_addr(s_ker_addr),
		.nine_flag(nine_flag),
		.pix_final_addr(pix_final_addr),
		.en_read_pix(en_read_pix),
		.en_divide_ker(en_divide_ker),
		.s_divide_ker(s_divide_ker),
		.s_read_pix(s_read_pix),
		.sum_flag(sum_flag),
		.nine_x_addr(nine_x_addr),
		.nine_y_addr(nine_y_addr),
		.en_inc_sum(en_inc_sum),
		.s_load_nine(s_load_nine),
		.en_load_nine(en_load_nine),
		.pix_x_addr(pix_x_addr),
		.pix_y_addr(pix_y_addr),
		.en_inc_pix(en_inc_pix),
		.en_rst_sumnine(en_rst_sumnine),
		.we(we),
		.newpix(newpix),
		.s_mus(s_mus),
		.en_rst_nine(en_rst_nine),
		.en_rst_inc_pix(en_rst_inc_pix)
	);
	
endmodule
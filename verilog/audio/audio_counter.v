module audio_counter(
	input clk,
	input rst,
	input t,
	output reg [4:0] addr
);

	initial addr = 5'd0;
	
	always@(posedge clk)
		if(t)
			addr <= addr + 5'd1;
		else if(rst)
			addr <= 5'd0;

			
endmodule
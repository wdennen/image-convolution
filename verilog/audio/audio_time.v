module audio_time(
	input clk,
	input rst,
	output t
	);
	
	reg [23:0] count;
	
	initial count = 24'd0;
	
	
	assign t = (count == 24'd12500000);
	
	always @ (posedge clk) begin
		if (rst | t)
			count <= 0;
		else
			count <= count + 1;
		end
	
	endmodule
module ker1(		//blur
	input clk,
	input [3:0] addr,
	output reg [4:0] dout
);

reg signed [4:0] mem_array [8:0];

initial begin
	mem_array[0] =5'd3;
	mem_array[1] =5'd3;
	mem_array[2] =5'd3;
	mem_array[3] =5'd3;
	mem_array[4] =5'd8;
	mem_array[5] =5'd3;
	mem_array[6] =5'd3;
	mem_array[7] =5'd3;
	mem_array[8] =5'd3;
end



always @(posedge clk)
	dout <= mem_array[addr];
endmodule

module ker2(		//edge detect
	input clk,
	input [3:0] addr,
	output reg [4:0] dout
);

reg signed [4:0] mem_array [8:0];

initial begin
	mem_array[0] =5'd0;
	mem_array[1] =5'd1;
	mem_array[2] =5'd0;
	mem_array[3] =5'd1;
	mem_array[4] = -5'd4;
	mem_array[5] =5'd1;
	mem_array[6] =5'd0;
	mem_array[7] =5'd1;
	mem_array[8] =5'd0;
end



always @(posedge clk)
	dout <= mem_array[addr];
endmodule

module ker3(			//sharpen
	input clk,
	input [3:0] addr,
	output reg [4:0] dout
);

reg signed [4:0] mem_array [8:0];

initial begin
	mem_array[0] =5'd0;
	mem_array[1] =-5'd1;
	mem_array[2] =5'd0;
	mem_array[3] =-5'd1;
	mem_array[4] =5'd5;
	mem_array[5] =-5'd1;
	mem_array[6] =5'd0;
	mem_array[7] =-5'd1;
	mem_array[8] =5'd0;
end



always @(posedge clk)
	dout <= mem_array[addr];
endmodule
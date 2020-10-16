module rom1(
	input clk_proc,
	input clk_vga,
	input [7:0] x_vga,
	input [6:0] y_vga,
	input [7:0] x_proc,
	input [6:0] y_proc,
	
	output reg [2:0] dout_vga,
	output reg [2:0] dout_proc
);

parameter IMAGE_FILE = "testpicture1b.mem";
wire [14:0] addr_vga = 160*y_vga + x_vga;
wire [14:0] addr_proc = 160* y_proc + x_proc;

reg [2:0] mem [0:19199];

initial $readmemh(IMAGE_FILE, mem);

always @(posedge clk_vga)
		dout_vga <= mem[addr_vga];
		
always @(posedge clk_proc)
		dout_proc <= mem[addr_proc];
			
endmodule

module ram1(
	input we,
	input clk_vga,
	input clk_proc,
	input [7:0] x_proc,
	input [6:0] y_proc,
	input [7:0] x_vga,
	input [6:0] y_vga,
	input [2:0] din,
	
	output reg [2:0] dout_proc,
	output reg [2:0] dout_vga
);


wire [14:0] addr_proc = 160*y_proc + x_proc;
wire [14:0] addr_vga = 160*y_vga + x_vga;

reg [2:0] ram [0:19199];

always@(posedge clk_proc) begin
	if(we)
		ram[addr_proc] <= din;
		
	dout_proc <= ram[addr_proc];
end

always@(posedge clk_vga) begin
	dout_vga <= ram[addr_vga];
end



endmodule

module ram2(
	input we,
	input clk_vga,
	input clk_proc,
	input [7:0] x_proc,
	input [6:0] y_proc,
	input [7:0] x_vga,
	input [6:0] y_vga,
	input [2:0] din,
	
	output reg [2:0] dout_proc,
	output reg [2:0] dout_vga
);


wire [14:0] addr_proc = 160*y_proc + x_proc;
wire [14:0] addr_vga = 160*y_vga + x_vga;

reg [2:0] ram [0:19199];

always@(posedge clk_proc) begin
	if(we)
		ram[addr_proc] <= din;
		
	dout_proc <= ram[addr_proc];
end

always@(posedge clk_vga) begin
	dout_vga <= ram[addr_vga];
end



endmodule



module rom2(
	input clk_proc,
	input clk_vga,
	input [7:0] x_vga,
	input [6:0] y_vga,
	input [7:0] x_proc,
	input [6:0] y_proc,
	
	output reg [2:0] dout_vga,
	output reg [2:0] dout_proc
);

parameter IMAGE_FILE = "zepplinb.mem";
wire [14:0] addr_vga = 160*y_vga + x_vga;
wire [14:0] addr_proc = 160* y_proc + x_proc;

reg [2:0] mem [0:19199];

initial $readmemh(IMAGE_FILE, mem);

always @(posedge clk_vga)
		dout_vga <= mem[addr_vga];
		
always @(posedge clk_proc)
		dout_proc <= mem[addr_proc];
			
endmodule

module rom3(
	input clk_proc,
	input clk_vga,
	input [7:0] x_vga,
	input [6:0] y_vga,
	input [7:0] x_proc,
	input [6:0] y_proc,
	
	output reg [2:0] dout_vga,
	output reg [2:0] dout_proc
);

parameter IMAGE_FILE = "yodab.mem";
wire [14:0] addr_vga = 160*y_vga + x_vga;
wire [14:0] addr_proc = 160* y_proc + x_proc;

reg [2:0] mem [0:19199];

initial $readmemh(IMAGE_FILE, mem);

always @(posedge clk_vga)
		dout_vga <= mem[addr_vga];
		
always @(posedge clk_proc)
		dout_proc <= mem[addr_proc];
			
endmodule



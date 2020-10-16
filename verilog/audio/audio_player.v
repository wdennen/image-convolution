module audio_player( //system that plays sequentially in our memory
	input clk,
	input rst,
	input [2:0] s_mus,
	output reg [19:0]note
);



wire [19:0] note1;
wire [19:0] note2;
wire [19:0] note3;



always @(posedge clk)			//select music based on our s_mus
	case(s_mus)
		1: begin
				note <= note1;
			end
		2:	begin
				note <= note2;
			end
		3: begin
				note <= note3;
			end
	endcase


wire en;

wire [4:0]send_addr;


audio_time timer(
	.clk(clk),
	.rst(rst),
	.t(en)
);


audio_counter count(
	.clk(clk),
	.rst(rst),
	.t(en),
	.addr(send_addr)
);


music1 music1(
	.addr(send_addr),
	.clk(clk),
	.dout(note1)
);

music2 music2(
	.addr(send_addr),
	.clk(clk),
	.dout(note2)
);

music3 music3(
	.addr(send_addr),
	.clk(clk),
	.dout(note3)
);


endmodule
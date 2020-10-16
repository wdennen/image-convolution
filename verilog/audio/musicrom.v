module music1(
	input		  [4:0]  addr,
	input			   	 clk,
	output reg [19:0] dout
);

	reg [19:0] memarray [30:0];
		
	initial begin //(50,000,000/x)/2
		memarray[0]  = 20'd37_921;
		memarray[1]  = 20'd37_921;
		memarray[2] = 20'd37_921;
		memarray[3] = 20'd47_778;
		memarray[4] = 20'd37_921;
		memarray[5] = 20'd31_888;
		memarray[6] = 20'd31_888;
		memarray[7] = 20'd63_775;
		memarray[8] = 20'd63_775;
		memarray[9] = 20'd47_778;
		memarray[10] = 20'd63_775;
		memarray[11] = 20'd75_842;
		memarray[12] = 20'd75_842;
		memarray[13] = 20'd56_818;
		memarray[14] = 20'd53_629;
		memarray[15] = 20'd56_818;
		memarray[16] = 20'd56_818;
		memarray[17] = 20'd63_775;
		memarray[18] = 20'd37_921;
		memarray[19] = 20'd31_888;
		memarray[20] = 20'd28_409;
		memarray[21] = 20'd28_409;
		memarray[22] = 20'd35_793;
		memarray[23] = 20'd35_793;
		memarray[24] = 20'd31_888;
		memarray[25] = 20'd37_921;
		memarray[26] = 20'd47_778;
		memarray[27] = 20'd42_565;
		memarray[28] = 20'd50_607;
		memarray[29] = 20'd50_607;
		memarray[30] = 20'd50_607;
	end

	always @(posedge clk)
		dout <= memarray[addr];

endmodule


module music2(
	input		  [4:0]  addr,
	input			   	 clk,
	output reg [19:0] dout
);

	reg [19:0] memarray [30:0];
		
	initial begin //(50,000,000/x)/2
		memarray[0]  = 20'd57_921;
		memarray[1]  = 20'd57_921;
		memarray[2] = 20'd57_921;
		memarray[3] = 20'd67_778;
		memarray[4] = 20'd57_921;
		memarray[5] = 20'd51_888;
		memarray[6] = 20'd51_888;
		memarray[7] = 20'd83_775;
		memarray[8] = 20'd83_775;
		memarray[9] = 20'd67_778;
		memarray[10] = 20'd83_775;
		memarray[11] = 20'd95_842;
		memarray[12] = 20'd95_842;
		memarray[13] = 20'd76_818;
		memarray[14] = 20'd73_629;
		memarray[15] = 20'd76_818;
		memarray[16] = 20'd76_818;
		memarray[17] = 20'd83_775;
		memarray[18] = 20'd57_921;
		memarray[19] = 20'd51_888;
		memarray[20] = 20'd48_409;
		memarray[21] = 20'd48_409;
		memarray[22] = 20'd55_793;
		memarray[23] = 20'd55_793;
		memarray[24] = 20'd51_888;
		memarray[25] = 20'd57_921;
		memarray[26] = 20'd67_778;
		memarray[27] = 20'd62_565;
		memarray[28] = 20'd70_607;
		memarray[29] = 20'd70_607;
		memarray[30] = 20'd70_607;
	end

	always @(posedge clk)
		dout <= memarray[addr];

endmodule


module music3(
	input		  [4:0]  addr,
	input			   	 clk,
	output reg [19:0] dout
);

	reg [19:0] memarray [30:0];
		
	initial begin //(50,000,000/x)/2
		memarray[0]  = 20'd27_921;
		memarray[1]  = 20'd27_921;
		memarray[2] = 20'd27_921;
		memarray[3] = 20'd37_778;
		memarray[4] = 20'd27_921;
		memarray[5] = 20'd21_888;
		memarray[6] = 20'd21_888;
		memarray[7] = 20'd53_775;
		memarray[8] = 20'd53_775;
		memarray[9] = 20'd37_778;
		memarray[10] = 20'd53_775;
		memarray[11] = 20'd65_842;
		memarray[12] = 20'd65_842;
		memarray[13] = 20'd46_818;
		memarray[14] = 20'd43_629;
		memarray[15] = 20'd46_818;
		memarray[16] = 20'd46_818;
		memarray[17] = 20'd53_775;
		memarray[18] = 20'd27_921;
		memarray[19] = 20'd21_888;
		memarray[20] = 20'd20_409;
		memarray[21] = 20'd20_409;
		memarray[22] = 20'd25_793;
		memarray[23] = 20'd25_793;
		memarray[24] = 20'd21_888;
		memarray[25] = 20'd27_921;
		memarray[26] = 20'd37_778;
		memarray[27] = 20'd32_565;
		memarray[28] = 20'd40_607;
		memarray[29] = 20'd40_607;
		memarray[30] = 20'd40_607;
	end

	always @(posedge clk)
		dout <= memarray[addr];

endmodule
module square_wave_osc (
   input CLOCK_50,
	input [19:0]music,
   input reset,
   output [31:0] out);
   
   reg [19:0]HALF_WAVELENGTH;     // for 440 Hz (50,000,000/440)/2
	initial HALF_WAVELENGTH = 20'd21_321;
	
	always @(posedge CLOCK_50)
		HALF_WAVELENGTH <= music; //constantly plays our notes.
   parameter AMPLITUDE 	      = 32'd10_000_000;
   reg [19:0] count = 0;
   reg phase = 0;

   always @(posedge CLOCK_50)
      if (reset) begin
         count <= 0;
         phase <= 0;
      end
      else if (count == HALF_WAVELENGTH) begin
         count <= 0;
         phase <= ~phase;
      end
      else begin
         count <= count + 1;
      end
      
   assign out = phase ? AMPLITUDE : -AMPLITUDE;

endmodule

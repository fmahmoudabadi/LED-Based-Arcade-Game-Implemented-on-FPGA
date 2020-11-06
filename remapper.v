module remapper(

input [15:0] in,

//output reg [15:0] abs_in,

//output reg neg,

output reg [9:0] board_posit

);

reg [15:0] abs_in;
reg neg;

always @(*) begin

   board_posit = 10'bxx_xxxx_xxxx;
	
	if (in[15] == 1'b1) begin 
		abs_in = (~in) + 16'b0000_0000_0000_0001;
		neg = 1'b1;
	end
	else begin
		abs_in = in;
		neg = 1'b0;
	end
	
	if (neg == 1'b1 && abs_in >= 16'd00_080) begin
		board_posit = 10'b00_0000_0001;
	end
	if (neg == 1'b1 && abs_in >= 16'd00_060 && abs_in < 16'd00_080) begin
		board_posit = 10'b00_0000_0010;
	end
	if (neg == 1'b1 && abs_in >= 16'd00_040 && abs_in < 16'd00_060) begin
		board_posit = 10'b00_0000_0100;
	end
	if (neg == 1'b1 && abs_in >= 16'd00_020 && abs_in < 16'd00_040) begin
		board_posit = 10'b00_0000_1000;
	end
	if (neg == 1'b1 && abs_in > 16'd00_000 && abs_in < 16'd00_020) begin
		board_posit = 10'b00_0001_0000;
	end
	if (neg == 1'b0 && abs_in >= 16'd00_000 && abs_in <= 16'd00_020) begin
		board_posit = 10'b00_0010_0000;
	end
	if (neg == 1'b0 && abs_in > 16'd00_020 && abs_in <= 16'd00_040) begin
		board_posit = 10'b00_0100_0000;
	end
	if (neg == 1'b0 && abs_in > 16'd00_040 && abs_in <= 16'd00_060) begin
		board_posit = 10'b00_1000_0000;
	end
	if (neg == 1'b0 && abs_in > 16'd00_060 && abs_in <= 16'd00_080) begin
		board_posit = 10'b01_0000_0000;
	end
	if (neg == 1'b0 && abs_in > 16'd00_080) begin
		board_posit = 10'b10_0000_0000;
	end
	
end

endmodule 
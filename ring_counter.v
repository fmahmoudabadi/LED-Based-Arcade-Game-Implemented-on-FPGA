module ring_counter(

input clk,
input ring_reset,
input ring_en,
output [9:0] mole_posit

);


reg r1, r2, r3, r4, r5, r6, r7, r8, r9, r10;
wire [9:0] content;
reg [9:0] state;

always @ (posedge clk) begin
	
	if (ring_en == 1'b1) begin
		r1 <= #1 r10;
		r2 <= #1 r1;
		r3 <= #1 r2;
		r4 <= #1 r3;
		r5 <= #1 r4;
		r6 <= #1 r5;
		r7 <= #1 r6;
		r8 <= #1 r7;
		r9 <= #1 r8;
		r10 <= #1 r9;
	end
	if (ring_reset == 1'b1) begin
	   r1 <= #1 1'b1;
		r2 <= #1 1'b0;
		r3 <= #1 1'b0;
		r4 <= #1 1'b0;
		r5 <= #1 1'b0;
		r6 <= #1 1'b0;
		r7 <= #1 1'b0;
		r8 <= #1 1'b0;
		r9 <= #1 1'b0;
		r10 <= #1 1'b0;
	end
	
end

assign content = {r10, r9, r8, r7, r6, r5, r4, r3, r2, r1};

always @(*) begin

state = state;

case (content)

10'b00_0000_0001: begin state = content; end
10'b00_0000_0010: begin state = content; end
10'b00_0000_0100: begin state = content; end
10'b00_0000_1000: begin state = content; end
10'b00_0001_0000: begin state = content; end 
10'b00_0010_0000: begin state = content; end
10'b00_0100_0000: begin state = content; end
10'b00_1000_0000: begin state = content; end
10'b01_0000_0000: begin state = content; end
10'b10_0000_0000: begin state = content; end

endcase

end

assign mole_posit = state;
endmodule 
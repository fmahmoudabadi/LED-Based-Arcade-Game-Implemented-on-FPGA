module ring_counter_tb();


reg clk, ring_reset, ring_en;
wire [9:0] mole_posit;


ring_counter my_ring(.clk(clk),.ring_reset(ring_reset),.ring_en(ring_en),.mole_posit(mole_posit));


initial begin
clk = 1'b1;
ring_reset = 1'b1;
ring_en = 1'b1;
#20;
ring_reset = 1'b0;
#240;
ring_en = 1'b0;
#60;
ring_en = 1'b1;
#240;


$stop;
end


always begin
#10;
clk = ~clk;
end

always @ (posedge clk) begin
	$display("ring_reset =%b, ring_en = %b, mole_posit = %b", ring_reset, ring_en, mole_posit);
end


endmodule 


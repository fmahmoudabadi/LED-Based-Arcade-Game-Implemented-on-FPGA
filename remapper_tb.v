module remapper_tb();

reg [15:0] in;
wire [15:0] abs_in;
wire [9:0] board_posit;
wire neg;

remapper my_remap1(.in(in), .abs_in(abs_in),.neg(neg),.board_posit(board_posit));


initial begin       
	in = 16'd00_085;
   repeat (10) begin   
   #100   
	$display("in = %b, neg =%d, abs_in = %d, board_posit = %b", in, neg, abs_in, board_posit);
   in = in - 16'd00_020;
   end   
end 

endmodule 
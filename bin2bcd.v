module bin2bcd
(
	input wire [9:0] bin,
	output wire [3:0] bcd2,bcd1,bcd0
);


reg [9:0] rem, ones;
reg [3:0] tens, honds;

always @ (*) begin


	if (bin >= 10'd0999)
		begin
		honds = 4'h9;
		rem = 10'd0099; 
		end
	else if (bin >= 10'd0900 && bin < 10'd0999)
	   begin
		honds = 4'h9;
		rem = bin - 10'd0900;
		end
	else if (bin >= 10'd0800 && bin < 10'd0900)
	   begin
		honds = 4'h8;
		rem = bin - 10'd0800;
		end
	else if (bin >= 10'd0700 && bin < 10'd0800)
	   begin
		honds = 4'h7;
		rem = bin - 10'd0700;
		end
	else if (bin >= 10'd0600 && bin < 10'd0700)
	   begin
		honds = 4'h6;
		rem = bin - 10'd0600;
		end
	else if (bin >= 10'd0500 && bin < 10'd0600)
	   begin
		honds = 4'h5;
		rem = bin - 10'd0500;
		end	
	else if (bin >= 10'd0400 && bin < 10'd0500)
	   begin
		honds = 4'h4;
		rem = bin - 10'd0400;
		end
	else if (bin >= 10'd0300 && bin < 10'd0400)
	   begin
		honds = 4'h3;
		rem = bin - 10'd0300;
		end
	else if (bin >= 10'd0200 && bin < 10'd0300)
	   begin
		honds = 4'h2;
		rem = bin - 10'd0200;
		end
	else if (bin >= 10'd0100 && bin < 10'd0200)
	   begin
		honds = 4'h1;
		rem = bin - 10'd0100;
		end
	else 
	   begin
		honds = 4'h0;
		rem = bin;
		end
		
	if (rem >= 10'd0090)
		begin
		tens = 4'h9;
		ones = rem - 10'd0090;
		end
	else if (rem >= 10'd0080 && rem < 10'd0090)
		begin
		tens = 4'h8;
		ones = rem - 10'd0080;
		end
	else if (rem >= 10'd0070 && rem < 10'd0080)
		begin
		tens = 4'h7;
		ones = rem - 10'd0070;
		end
	else if (rem >= 10'd0060 && rem < 10'd0070)
		begin
		tens = 4'h6;
		ones = rem - 10'd0060;
		end
	else if (rem >= 10'd0050 && rem < 10'd0060)
		begin
		tens = 4'h5;
		ones = rem - 10'd0050;
		end
	else if (rem >= 10'd0040 && rem < 10'd0050)
		begin
		tens = 4'h4;
		ones = rem - 10'd0040;
		end
	else if (rem >= 10'd0030 && rem < 10'd0040)
		begin
		tens = 4'h3;
		ones = rem - 10'd0030;
		end
	else if (rem >= 10'd0020 && rem < 10'd0030)
		begin
		tens = 4'h2;
		ones = rem - 10'd0020;
		end
	else if (rem >= 10'd0010 && rem < 10'd0020)
		begin
		tens = 4'h1;
		ones = rem - 10'd0010;
		end
	else 
		begin
		tens = 4'h0;
		ones = rem;
		end
end

assign bcd0 = ones [3:0];
assign bcd1 = tens;
assign bcd2 = honds;

endmodule 
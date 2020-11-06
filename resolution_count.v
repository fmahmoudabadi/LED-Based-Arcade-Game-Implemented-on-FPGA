module resolution_count(

input reset_timer,
input clk,
output res0point01_en

);

reg [17:0] count, count_c;

always @(reset_timer or count) begin
	if (reset_timer == 1'b1 || count == 18'd249_999) begin
		count_c = 18'd000_000;
	end
	else begin
		count_c = count + 18'd000_001;
	end
end

always @ (posedge clk) begin
	count <= #1 count_c;
end

assign res0point01_en = (count == 18'd249_999);

endmodule 
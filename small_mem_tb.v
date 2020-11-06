module small_mem_tb();

integer fd1;
reg clk;
wire [9:0] data_out;
reg [9:0] data_in;
reg [1:0] addr_rd, addr_wr;
reg write_enable;

small_mem my_mem(.clk(clk),.data_in(data_in),.write_enable(write_enable),.addr_wr(addr_wr),
.addr_rd(addr_rd),.data_out(data_out));

initial begin
fd1 = $fopen("small_mem.txt","w");
clk = 1'b1;
write_enable = 1'b0;
#20;
write_enable = 1'b1;
addr_wr = 2'b00;
data_in = 10'b00_0000_0010;
#20;
write_enable = 1'b0;
#60;
write_enable = 1'b1;
addr_wr = 2'b01;
data_in = 10'b00_0000_1000;
#20;
write_enable = 1'b0;
#60;
write_enable = 1'b1;
addr_wr = 2'b10;
data_in = 10'b00_0010_0000;
#20;
write_enable = 1'b0;
#60;
write_enable = 1'b1;
addr_wr = 2'b11;
data_in = 10'b01_0000_0000;
#20;
write_enable = 1'b0;
#60;
addr_rd = 2'b00;
#20;
addr_rd = 2'b01;
#20;
addr_rd = 2'b10;
#20;
addr_rd = 2'b11;
#20;
$fclose(fd1);
$stop;
end


always begin
#10;
clk = ~clk;
end

always @ (posedge clk) begin
		#2;
		$fwrite(fd1,"write_enable = %b, addr_wr = %b, addr_rd = %b, data_in = %b, data_out = %b\n", 
		write_enable, addr_wr, addr_rd, data_in, data_out);
end

endmodule 


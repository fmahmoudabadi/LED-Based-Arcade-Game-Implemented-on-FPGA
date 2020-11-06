module small_mem (

input clk,
input [9:0] data_in,
input write_enable,
input [1:0] addr_wr,
input [1:0] addr_rd,
output [9:0] data_out

);

reg [9:0]    mem [0:3];

always @(posedge clk) begin
  if (write_enable == 1'b1) begin 
   mem[addr_wr] <= #1 data_in;
  end 
end

assign data_out = mem[addr_rd];


endmodule 
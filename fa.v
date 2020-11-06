module fa(
input a,input b,input ci, output s, output co
);

reg s_out,c_out;

always @(*)
begin
s_out=a^b^ci;
c_out=a&b|a&ci|b&ci;
end

assign s=s_out;
assign co=c_out;

endmodule


 
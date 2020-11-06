`timescale 1ns / 1ns
module smooth_filter(
input clk,
input reset,
input [15:0] in,
input [1:0] SW,
output [15:0] out
);

reg [18:0] count, count_c;
wire en;

always @(reset or count) begin
	if (reset == 1'b1 || count == 19'd499_999) begin
		count_c = 19'd000_000;
	end
	else begin
		count_c = count + 19'd000_001;
	end
end

assign en = (count == 19'd499_999);

reg [15:0] r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16;

always @ (posedge clk) begin
	count <= #1 count_c;
	if (en == 1'b1) begin
		r1 <= #1 in;
		r2 <= #1 r1;
		r3 <= #1 r2;
		r4 <= #1 r3;
		r5 <= #1 r4;
		r6 <= #1 r5;
		r7 <= #1 r6;
		r8 <= #1 r7;
		r9 <= #1 r8;
		r10 <= #1 r9;
		r11 <= #1 r10;
		r12 <= #1 r11;
		r13 <= #1 r12;
		r14 <= #1 r13;
		r15 <= #1 r14;
		r16 <= #1 r15;
	end
end

reg [19:0] sum;
wire [19:0] num1, num2, num3, num4, num5, num6, num7, num8;
wire [19:0] num9, num10, num11, num12, num13, num14, num15, num16;

wire ci=1'b0;
wire [19:0] calculate_out1, calculate_out2, calculate_out3, calculate_out4,
            calculate_out5, calculate_out6, calculate_out7, calculate_out8,
				calculate_out9, calculate_out10, calculate_out11, calculate_out12,
				calculate_out13, calculate_out14, calculate_out15;

assign num1 = {{4{r1[15]}},r1};
assign num2 = {{4{r2[15]}},r2};
assign num3 = {{4{r3[15]}},r3};
assign num4 = {{4{r4[15]}},r4};
assign num5 = {{4{r5[15]}},r5};
assign num6 = {{4{r6[15]}},r6};
assign num7 = {{4{r7[15]}},r7};
assign num8 = {{4{r8[15]}},r8};
assign num9 = {{4{r9[15]}},r9};
assign num10 = {{4{r10[15]}},r10};
assign num11 = {{4{r11[15]}},r11};
assign num12 = {{4{r12[15]}},r12};
assign num13 = {{4{r13[15]}},r13};
assign num14 = {{4{r14[15]}},r14};
assign num15 = {{4{r15[15]}},r15};
assign num16 = {{4{r16[15]}},r16};

always @(*) begin

	sum = num1;
	case (SW[1:0]) 
	2'b00:begin 
		sum = num1;
	end
	2'b01:begin
		sum = calculate_out1;
		sum = sum >> 1; 
	end
	2'b10:begin
		sum = calculate_out3;
		sum = sum >> 2;  
	end
	2'b11:begin
		sum = calculate_out15;
		sum = sum >> 4;  
	end
	endcase 
end

assign out = sum[15:0];

add20bit_2sComp my_adder1 (.A(num1),.B(num2),.ci(ci),.calculate_out(calculate_out1));
add20bit_2sComp my_adder2 (.A(calculate_out1),.B(num3),.ci(ci),.calculate_out(calculate_out2));
add20bit_2sComp my_adder3(.A(calculate_out2),.B(num4),.ci(ci),.calculate_out(calculate_out3));
add20bit_2sComp my_adder4(.A(calculate_out3),.B(num5),.ci(ci),.calculate_out(calculate_out4));
add20bit_2sComp my_adder5 (.A(calculate_out4),.B(num6),.ci(ci),.calculate_out(calculate_out5));
add20bit_2sComp my_adder6(.A(calculate_out5),.B(num7),.ci(ci),.calculate_out(calculate_out6));
add20bit_2sComp my_adder7(.A(calculate_out6),.B(num8),.ci(ci),.calculate_out(calculate_out7));
add20bit_2sComp my_adder8 (.A(calculate_out7),.B(num9),.ci(ci),.calculate_out(calculate_out8));
add20bit_2sComp my_adder9(.A(calculate_out8),.B(num10),.ci(ci),.calculate_out(calculate_out9));
add20bit_2sComp my_adder10(.A(calculate_out9),.B(num11),.ci(ci),.calculate_out(calculate_out10));
add20bit_2sComp my_adder11(.A(calculate_out10),.B(num12),.ci(ci),.calculate_out(calculate_out11));
add20bit_2sComp my_adder12(.A(calculate_out11),.B(num13),.ci(ci),.calculate_out(calculate_out12));
add20bit_2sComp my_adder13(.A(calculate_out12),.B(num14),.ci(ci),.calculate_out(calculate_out13));
add20bit_2sComp my_adder14(.A(calculate_out13),.B(num15),.ci(ci),.calculate_out(calculate_out14));
add20bit_2sComp my_adder15(.A(calculate_out14),.B(num16),.ci(ci),.calculate_out(calculate_out15));

endmodule 


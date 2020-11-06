module timers (

input reset_timer,
input clk,
input whack,
//input res0point01_en,
output [9:0] display_timer,
output reg [9:0] timer_stop,
output timer_0point2_edge,
output timer_1_edge,
output timer_3_edge,
output timer_9point99_edge

);

reg [9:0] count_c, count;
wire res0point01_en;


always @ (*) begin
   count_c = count + 10'd00_01;
	timer_stop = timer_stop;
	if (count == 10'd09_99 || whack == 1'b1) begin
		count_c = count;
		timer_stop = count;
	end	
end

always @ (posedge clk) begin
   if (res0point01_en == 1'b1) begin
		count <= #1 count_c;
	end
	if (reset_timer == 1'b1) begin
		count <= #1 10'd00_00;
	end
end

wire timer_0point2, timer_1, timer_3, timer_9point99;

assign timer_0point2 = (count == 10'd00_20);
assign timer_1 = (count == 10'd01_00);
assign timer_3 = (count == 10'd03_00);
assign timer_9point99 = (count == 10'd09_99);

assign display_timer = count;



resolution_count my_res(.reset_timer(reset_timer),.clk(clk),.res0point01_en(res0point01_en));

edge_detection edge1(.clock(clk),.input_signal(timer_0point2),.rising_transition(timer_0point2_edge));

edge_detection edge2(.clock(clk),.input_signal(timer_1),.rising_transition(timer_1_edge));

edge_detection edge3(.clock(clk),.input_signal(timer_3),.rising_transition(timer_3_edge));

edge_detection edge4(.clock(clk),.input_signal(timer_9point99),.rising_transition(timer_9point99_edge));

endmodule 


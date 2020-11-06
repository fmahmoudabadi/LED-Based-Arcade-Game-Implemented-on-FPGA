module timers_tb();

integer fd1;
reg clk;
reg reset_timer;
reg whack;
reg res0point01_en;
wire [9:0] display_timer;
wire [9:0] time_of_game;
wire timer_0point2, timer_1, timer_3, timer_9point99;

timers my_timers(.reset_timer(reset_timer),.clk(clk),.whack(whack),
.res0point01_en(res0point01_en),.display_timer(display_timer),.timer_stop(time_of_game),
.timer_0point2_edge(timer_0point2),.timer_1_edge(timer_1),.timer_3_edge(timer_3),.timer_9point99_edge(timer_9point99));

initial begin
fd1 = $fopen("timers.txt","w");
clk = 1'b1;
reset_timer = 1'b1;
whack = 1'b0;
#20;
reset_timer = 1'b0;
#90_000;
reset_timer = 1'b1;
#20;
reset_timer = 1'b0;
#50_000;
whack = 1'b1;
#20;
whack = 1'b0;
#20_000;
$fclose(fd1);
$stop;
end


always begin
#10;
clk = ~clk;
end


always begin
res0point01_en = 1'b0;
#60;
res0point01_en = 1'b1;
#20;
end


always @ (posedge res0point01_en) begin
		#22;
		$fwrite(fd1,"reset_timer = %b, whack = %b, display_timer = %d, time_of_game = %d, timer_0point2 = %d, timer_1 = %d, timer_3 = %d, timer_9point99 = %d\n", 
		reset_timer, whack, display_timer, time_of_game, timer_0point2, timer_1, timer_3, timer_9point99);
end

endmodule 

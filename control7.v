module control7(

input clk,
input [1:0] KEY,
input [15:0] smooth_out,
output reg init,
output [9:0] LEDR,
output reg [3:0] FSM_state, //FSM state
output reg [3:0] game_number, //game number 1-4
output reg [9:0] BCD_in

);

//-----------declaring wires and registers-------------

reg [9:0] source1, source2, source3, source4;
wire [11:0] num1, num2, num3, num4;
reg [12:0] sum;
wire [12:0] calculate_out1, calculate_out2, calculate_out3;


wire [9:0] mole_posit;
reg ring_reset, ring_en;
reg reset_timer;
wire whack;
wire [9:0] time_of_game;
wire timer_0point2, timer_1, timer_3, timer_9point99;
wire [9:0] data_out;
reg [9:0] data_in;
reg [1:0] addr_rd, addr_wr;
reg write_enable;
wire [9:0] board_posit;
wire [9:0] display_timer;

//-----------edge_detection for KEY bottons (KEY[0] and KEY[1])------------

wire reset, bang; 
wire reset_edge, bang_edge;
reg [9:0] LED;

assign reset = ~KEY[1];
assign bang = ~KEY[0];
assign LEDR = LED;

edge_detection my_edge1(.clock(clk),.input_signal(reset),.rising_transition(reset_edge));
edge_detection my_edge2(.clock(clk),.input_signal(bang),.rising_transition(bang_edge));

//---------------implementing the FSM----------------

reg [3:0] state_c, state;
reg [1:0] count_c, count; //to keep track of the game number 1 to 4
reg [9:0] target; //to store the location of mole


parameter start = 4'h0;
parameter mole = 4'h1;
parameter hammer = 4'h2;
parameter game_ends = 4'h3;
parameter A = 4'h4;
parameter B = 4'h5;
parameter C = 4'h6;
parameter D = 4'h7;
parameter E = 4'h8;



always @(*) begin

	state_c = state;
	count_c  = count;
	reset_timer = 1'b0;
	ring_reset = 1'b0;
	LED = 10'b00_0000_0000;
	init = 1'b0;
	ring_en = 1'b1;
	write_enable = 1'b0;
	game_number = game_number;
	FSM_state = FSM_state;
	target = target;
	addr_wr = addr_wr;
	addr_rd = addr_rd;
	data_in = data_in;
	BCD_in = display_timer;


	case (state)
		start: begin
			LED = 10'b00_0000_0000;
			init = 1'b1;
			FSM_state = start;
			game_number = count;
			BCD_in = display_timer;
			if (timer_3 == 1'b1) begin
				state_c = mole;
				reset_timer = 1'b1;
			end
		end
		mole: begin
		   ring_en = 1'b0;
			LED = mole_posit[9:0];
			target = mole_posit[9:0];
			FSM_state = mole;
			game_number = count;
			BCD_in = display_timer;
			if (timer_0point2 == 1'b1) begin
				state_c = hammer;
			end		
		
		end
		hammer: begin
			LED = board_posit;
			FSM_state = hammer;
			game_number = count;
			BCD_in = display_timer;
			if (timer_9point99 == 1'b1 || whack == 1'b1) begin
			   write_enable = 1'b1;
				addr_wr = count;
				data_in = time_of_game;
				state_c = game_ends;
				reset_timer = 1'b1;
			end
		end
		game_ends: begin
			LED = 10'b00_0000_0000;
			FSM_state = game_ends;
			game_number = count;
         addr_rd = count;
         BCD_in = data_out;
			if (timer_3 == 1'b1) begin
				count_c = count + 2'b01;
				reset_timer = 1'b1;
			   if (count == 2'b11) begin
					state_c = A;
				end
				else begin
					state_c = start;
			   end
			end
		end
		A: begin
		   addr_rd = 2'b00;
         game_number = A;
			BCD_in = data_out;
			source1 = data_out;
			FSM_state = A;
			if (timer_3 == 1'b1) begin
				state_c = B;
				reset_timer = 1'b1;
			end		 
		end
		B: begin
			addr_rd = 2'b01;
			game_number = B;
			BCD_in = data_out;
			source2 = data_out;
			FSM_state = B;
			if (timer_3 == 1'b1) begin
				state_c = C;
				reset_timer = 1'b1;
			end
		end
		C: begin
			addr_rd = 2'b10;
			game_number = C;
			BCD_in = data_out;
			source3 = data_out;
			FSM_state = C;
			if (timer_3 == 1'b1) begin
				state_c = D;
				reset_timer = 1'b1;
			end
		end
		D: begin
			addr_rd = 2'b11;
			game_number = D;
			BCD_in = data_out;
			source4 = data_out;
			FSM_state = D;
			if (timer_3 == 1'b1) begin
            state_c = E;
				reset_timer = 1'b1;
			end
		end
		E: begin
			game_number = E;
			BCD_in = sum[9:0];
			FSM_state = E;
			if (timer_3 == 1'b1) begin
				state_c = A;
				reset_timer = 1'b1;
			end		
		end
	endcase

	if (reset == 1'b1) begin
		state_c = start;
		count_c = 2'b00;
		reset_timer = 1'b1;
		ring_reset = 1'b1;
	end

end


assign whack = ((target == board_posit[9:0]) && (bang_edge == 1'b1) );


always @(posedge clk) begin
	state <= state_c;
	count <= count_c;
end

//---------code to average the time of four games---------

assign num1 = {{2{1'b0}},source1};
assign num2 = {{2{1'b0}},source2};
assign num3 = {{2{1'b0}},source3};
assign num4 = {{2{1'b0}},source4};

add_12plus1bit my_add1(.A(num1), .B(num2), .ci(1'b0), .calculate_out(calculate_out1));
add_12plus1bit my_add2(.A(calculate_out1), .B(num3), .ci(1'b0), .calculate_out(calculate_out2));
add_12plus1bit my_add3(.A(calculate_out2), .B(num4), .ci(1'b0), .calculate_out(calculate_out3));

always @(*) begin

sum = calculate_out3;
sum = sum >> 2;

end

//-----------instantiating the ring_counter, timers, memory, and remapper-------------

ring_counter my_ring (.clk(clk),.ring_reset(ring_reset),.ring_en(ring_en),.mole_posit(mole_posit));

timers my_timers(.reset_timer(reset_timer),.clk(clk),.whack(whack),
.display_timer(display_timer),.timer_stop(time_of_game),.timer_0point2_edge(timer_0point2),
.timer_1_edge(timer_1),.timer_3_edge(timer_3),.timer_9point99_edge(timer_9point99));

small_mem my_mem(.clk(clk),.data_in(data_in),.write_enable(write_enable),.addr_wr(addr_wr),.addr_rd(addr_rd),.data_out(data_out));

remapper my_remapper(.in(smooth_out),.board_posit(board_posit));

endmodule 
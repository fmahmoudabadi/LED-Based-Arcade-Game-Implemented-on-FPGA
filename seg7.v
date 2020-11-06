module seg7(

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	input            [9:0]     SW,
	input                      clk,
	input                      init,
	input            [3:0]     FSM_state, //FSM state
	input            [3:0]     game_number, //game number 1-4
   input 		     [11:0]		display

);



//=======================================================
//  REG/WIRE declarations
//=======================================================

reg [47:0] out;   
  

//=======================================================
//  Structural coding
//=======================================================


always @(*) begin

	 out [31:24]= 8'b11111111; 
	 
	 case (display [3:0])  
	 4'b0000: begin 
	 out [7:0] = 8'b11000000; 
	 end 
	 4'b0001: begin 
	 out [7:0] = 8'b11111001; 
	 end 
	 4'b0010: begin 
	 out [7:0] = 8'b10100100; 
	 end 
	 4'b0011: begin 
	 out [7:0] = 8'b10110000; 
	 end 
	 
	 4'b0100: begin 
	 out [7:0] = 8'b10011001; 
	 end 
	 4'b0101: begin 
	 out [7:0]= 8'b10010010; 
	 end 
	 4'b0110: begin 
	 out [7:0]= 8'b10000010; 
	 end 
	 4'b0111: begin 
	 out [7:0]= 8'b11111000; 
	 end
	 
	 4'b1000: begin 
	 out [7:0]= 8'b10000000; 
	 end 
	 4'b1001: begin 
	 out [7:0]= 8'b10010000; 
	 end 
	 4'b1010: begin 
	 out [7:0]= 8'b10001000; 
	 end 
	 4'b1011: begin 
	 out [7:0]= 8'b10000011; 
	 end
	 
	 4'b1100: begin 
	 out [7:0]= 8'b11000110; 
	 end 
	 4'b1101: begin 
	 out [7:0]= 8'b10100001; 
	 end 
	 4'b1110: begin 
	 out [7:0]= 8'b10000110; 
	 end 
	 4'b1111: begin 
	 out [7:0]= 8'b10001110; 
	 end
	 default: begin 
	 out [7:0]= 8'b11111111; 
	 end 
	 endcase 
	 
	 
	 case (display [7:4])  
	 4'b0000: begin 
	 out [15:8]= 8'b11000000; 
	 end 
	 4'b0001: begin 
	 out [15:8]= 8'b11111001; 
	 end 
	 4'b0010: begin 
	 out [15:8]= 8'b10100100; 
	 end 
	 4'b0011: begin 
	 out [15:8]= 8'b10110000; 
	 end 
	 
	 4'b0100: begin 
	 out [15:8]= 8'b10011001; 
	 end 
	 4'b0101: begin 
	 out [15:8]= 8'b10010010; 
	 end 
	 4'b0110: begin 
	 out [15:8]= 8'b10000010; 
	 end 
	 4'b0111: begin 
	 out [15:8]= 8'b11111000; 
	 end
	 
	 4'b1000: begin 
	 out [15:8]= 8'b10000000; 
	 end 
	 4'b1001: begin 
	 out [15:8]= 8'b10010000; 
	 end 
	 4'b1010: begin 
	 out [15:8]= 8'b10001000; 
	 end 
	 4'b1011: begin 
	 out [15:8]= 8'b10000011; 
	 end
	 
	 4'b1100: begin 
	 out [15:8]= 8'b11000110; 
	 end 
	 4'b1101: begin 
	 out [15:8]= 8'b10100001; 
	 end 
	 4'b1110: begin 
	 out [15:8]= 8'b10000110; 
	 end 
	 4'b1111: begin 
	 out [15:8]= 8'b10001110; 
	 end
	 default: begin 
	 out [15:8]= 8'b11111111; 
	 end 
	 endcase 
	 
	 
	 case (display [11:8])  
	 4'b0000: begin 
	 out [23:16]= 8'b01000000; 
	 end 
	 4'b0001: begin 
	 out [23:16]= 8'b01111001; 
	 end 
	 4'b0010: begin 
	 out [23:16]= 8'b00100100; 
	 end 
	 4'b0011: begin 
	 out [23:16]= 8'b00110000; 
	 end 
	 
	 4'b0100: begin 
	 out [23:16]= 8'b00011001; 
	 end 
	 4'b0101: begin 
	 out [23:16]= 8'b00010010; 
	 end 
	 4'b0110: begin 
	 out [23:16]= 8'b00000010; 
	 end 
	 4'b0111: begin 
	 out [23:16]= 8'b01111000; 
	 end
	 
	 4'b1000: begin 
	 out [23:16]= 8'b00000000; 
	 end 
	 4'b1001: begin 
	 out [23:16]= 8'b00010000; 
	 end 
	 4'b1010: begin 
	 out [23:16]= 8'b00001000; 
	 end 
	 4'b1011: begin 
	 out [23:16]= 8'b00000011; 
	 end
	 
	 4'b1100: begin 
	 out [23:16]= 8'b01000110; 
	 end 
	 4'b1101: begin 
	 out [23:16]= 8'b00100001; 
	 end 
	 4'b1110: begin 
	 out [23:16]= 8'b00000110; 
	 end 
	 4'b1111: begin 
	 out [23:16]= 8'b00001110; 
	 end
	 default: begin 
	 out [23:16]= 8'b11111111; 
	 end 
	 endcase 
	 


	 case (FSM_state)
	 4'h0: begin out[47:40] = 8'b1111_1001; end
	 4'h1: begin out[47:40] = 8'b1010_0100; end
	 4'h2: begin out[47:40] = 8'b1011_0000; end
	 4'h3: begin out[47:40] = 8'b1001_1001; end
	 4'h4: begin out[47:40] = 8'b1000_1000; end
	 4'h5: begin out[47:40] = 8'b1000_0011; end
	 4'h6: begin out[47:40] = 8'b1100_0110; end
	 4'h7: begin out[47:40] = 8'b1010_0001; end
	 4'h8: begin out[47:40] = 8'b1000_0110; end
	 endcase
	 
	 case (game_number)
	 4'h0: begin out[39:32] = 8'b1111_1001; end
	 4'h1: begin out[39:32] = 8'b1010_0100; end
	 4'h2: begin out[39:32] = 8'b1011_0000; end
	 4'h3: begin out[39:32] = 8'b1001_1001; end
	 	 
	 4'h4: begin out[39:32] = 8'b1000_1000; end
	 4'h5: begin out[39:32] = 8'b1000_0011; end
	 4'h6: begin out[39:32] = 8'b1100_0110; end
	 4'h7: begin out[39:32] = 8'b1010_0001; end
	 4'h8: begin out[39:32] = 8'b1000_0110; end
	 endcase
 
 
    if (init == 1'b1) begin 
	 out [7:0] = 8'b1011_1111;
	 out[15:8] = 8'b1011_1111;
	 out[23:16] = 8'b0011_1111;
	 out[31:24] = 8'b1111_1111; 
//	 out[31:24] = 8'b1011_1111;
//	 out[39:32] = 8'b1111_1111;
//	 out[47:40] = 8'b1111_1111;
	 end 	 

	 if (SW[9] == 1'b1) begin
	 out[47:40] = 8'b1111_1111;
	 end
 end 
 

assign HEX0[7:0]=out[7:0];
assign HEX1[7:0]=out[15:8];
assign HEX2[7:0]=out[23:16];
assign HEX3[7:0]=out[31:24];
//assign HEX4[7:0]= out[39:32];
//assign HEX5[7:0]= out[47:40];
assign HEX5[7:0]= out[39:32];
assign HEX4[7:0]= out[47:40];

endmodule

 


//===========================================================================
// accel.v
//
// Template module to get the DE10-Lite's accelerator working very quickly.
//
// 2020/05/17  Written (BB)
//
//===========================================================================

module accel (
   //////////// CLOCK //////////
   input 		          		ADC_CLK_10,
   input 		          		MAX10_CLK1_50,
   input 		          		MAX10_CLK2_50,

   //////////// SEG7 //////////
   output		     [7:0]		HEX0,
   output		     [7:0]		HEX1,
   output		     [7:0]		HEX2,
   output		     [7:0]		HEX3,
   output		     [7:0]		HEX4,
   output		     [7:0]		HEX5,

   //////////// KEY //////////
   input 		     [1:0]		KEY,

   //////////// LED //////////
   output		     [9:0]		LEDR,

   //////////// SW //////////
   input 		     [9:0]		SW,

   //////////// Accelerometer ports //////////
   output		          		GSENSOR_CS_N,
   input 		     [2:1]		GSENSOR_INT,
   output		          		GSENSOR_SCLK,
   inout 		          		GSENSOR_SDI,
   inout 		          		GSENSOR_SDO
   );

//===== Declarations
   localparam SPI_CLK_FREQ  = 200;  // SPI Clock (Hz)
   localparam UPDATE_FREQ   = 1;    // Sampling frequency (Hz)
	
//	localparam SPI_CLK_FREQ  = 2_000_000;  // SPI Clock (Hz)
//   localparam UPDATE_FREQ   = 50;    // Sampling frequency (Hz)

   // clks and reset
   wire reset_n;
   wire clk, spi_clk, spi_clk_out;

   // output data
   wire data_update;
   wire [15:0] data_x, data_y;

//===== Phase-locked Loop (PLL) instantiation. Code was copied from a module
//      produced by Quartus' IP Catalog tool.
//ip ip_inst (
//   .inclk0 ( MAX10_CLK1_50 ),
//   .c0 ( clk ),
//   .c1 ( spi_clk ),
//   .c2 ( spi_clk_out )
//   );
	
pll pll_inst (
   .inclk0 ( MAX10_CLK1_50 ),
   .c0 ( clk ),
   .c1 ( spi_clk ),
   .c2 ( spi_clk_out )
   );

//===== Instantiation of the spi_control module which provides the logic to 
//      interface to the accelerometer.
spi_control #(     // parameters
      .SPI_CLK_FREQ   (SPI_CLK_FREQ),
      .UPDATE_FREQ    (UPDATE_FREQ))
   spi_ctrl (      // port connections
      .reset_n    (reset_n),
      .clk        (clk),
      .spi_clk    (spi_clk),
      .spi_clk_out(spi_clk_out),
      .data_update(data_update),
      .data_x     (data_x),
      .data_y     (data_y),
      .SPI_SDI    (GSENSOR_SDI),
      .SPI_SDO    (GSENSOR_SDO),
      .SPI_CSN    (GSENSOR_CS_N),
      .SPI_CLK    (GSENSOR_SCLK),
      .interrupt  (GSENSOR_INT)
   );

//===== Main block
//      To make the module do something visible, the 16-bit data_x is 
//      displayed on four of the HEX displays in hexadecimal format.

// Pressing KEY0 freezes the accelerometer's output
assign reset_n = KEY[0];

// 7-segment displays HEX0-3 show data_x in hexadecimal
//seg7 s0 (
//   .in      (data_x[3:0]),
//   .display (HEX0) );
//
//seg7 s1 (
//   .in      (data_x[7:4]),
//   .display (HEX1) );
//
//seg7 s2 (
//   .in      (data_x[11:8]),
//   .display (HEX2) );
//
//seg7 s3 (
//   .in      (data_x[15:12]),
//   .display (HEX3) );
//
//// A few statements just to light some LEDs
//seg7 s4 ( .in(SW[5:2]), .display(HEX4) );
//seg7 s5 ( .in(SW[9:6]), .display(HEX5) );
//assign LEDR = {SW[9:8], data_x[7:0]};




wire [3:0] bcd2,bcd1,bcd0;
wire [15:0] smooth_out;
wire res = 1'b0;
wire init;
wire [9:0] BCD_in;
wire [3:0] FSM_state; //FSM state
wire [3:0] game_number; //game number 1-4

smooth_filter(.clk(clk),.reset(res),.in(data_x[15:0]),.SW(SW[1:0]),.out(smooth_out));

bin2bcd my_bin2bcd (.bin(BCD_in),.bcd2(bcd2),.bcd1(bcd1),.bcd0(bcd0));

seg7 my_seg7 (.HEX0(HEX0),.HEX1(HEX1),.HEX2(HEX2),.HEX3(HEX3),.HEX4(HEX4),.HEX5(HEX5),.SW(SW),.clk(clk),.init(init),.FSM_state(FSM_state),.game_number(game_number),.display({bcd2,bcd1,bcd0}));

control7 my_control7(.clk(clk),.KEY(KEY),.smooth_out(smooth_out),.init(init),.LEDR(LEDR),.FSM_state(FSM_state),.game_number(game_number),.BCD_in(BCD_in));

endmodule 

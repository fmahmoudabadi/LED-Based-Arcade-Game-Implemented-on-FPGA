module edge_detection ( 
input clock, 
input input_signal, 
output reg rising_transition
);
// declarations 
reg n; 
wire rising_transition_c;
// logic to detect 0 in previous cycle and 1 in current cycle 
assign rising_transition_c = ~n & input_signal;
// flip-flop instantiations 
always @(posedge clock) begin 
n                 <= #1 input_signal; 
rising_transition <= #1 rising_transition_c; 
end
endmodule

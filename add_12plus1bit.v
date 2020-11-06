module add_12plus1bit(
   input 		     [11:0]		A,
	input 		     [11:0]		B,
	input 		         		ci,
	output		     [12:0]		calculate_out
);


wire [11:0] s;
wire [11:0] co;

fa fa0(A[0],B[0],ci,s[0],co[0]);
fa fa1(A[1],B[1],co[0],s[1],co[1]);
fa fa2(A[2],B[2],co[1],s[2],co[2]);
fa fa3(A[3],B[3],co[2],s[3],co[3]);
fa fa4(A[4],B[4],co[3],s[4],co[4]);
fa fa5(A[5],B[5],co[4],s[5],co[5]);
fa fa6(A[6],B[6],co[5],s[6],co[6]);
fa fa7(A[7],B[7],co[6],s[7],co[7]);
fa fa8(A[8],B[8],co[7],s[8],co[8]);
fa fa9(A[9],B[9],co[8],s[9],co[9]);
fa fa10(A[10],B[10],co[9],s[10],co[10]);
fa fa11(A[11],B[11],co[10],s[11],co[11]);

assign calculate_out[12:0]={co[11],s};

endmodule 
module add20bit_2sComp(
   input 		     [19:0]		A,
	input 		     [19:0]		B,
	input 		         		ci,
	output		     [19:0]		calculate_out
);


wire [19:0] s;
wire [19:0] co;

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
fa fa12(A[12],B[12],co[11],s[12],co[12]);
fa fa13(A[13],B[13],co[12],s[13],co[13]);
fa fa14(A[14],B[14],co[13],s[14],co[14]);
fa fa15(A[15],B[15],co[14],s[15],co[15]);
fa fa16(A[16],B[16],co[15],s[16],co[16]);
fa fa17(A[17],B[17],co[16],s[17],co[17]);
fa fa18(A[18],B[18],co[17],s[18],co[18]);
fa fa19(A[19],B[19],co[18],s[19],co[19]);


assign calculate_out[19:0]=s;

endmodule 
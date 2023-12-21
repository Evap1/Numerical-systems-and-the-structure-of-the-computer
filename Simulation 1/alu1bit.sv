// 1-bit ALU template
module alu1bit (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic [1:0] op,    // Operation
    output logic s,          // Output S
    output logic cout        // Carry out
);

	logic g1, d0, d1, d23, g2, a_ns;
	
	XNOR2 #(.Tpdlh(8),
			.Tpdhl(8)
	) xor1 (
		.A(a),
		.B(b),
		.Z(g1)
		);
	NAND2 #(.Tpdlh(8),
		.Tpdhl(8)
		) xor2 (
		.A(g1),
		.B(g1),
		.Z(d1)
		);	

	OR2 #(.Tpdlh(2),
		  .Tpdhl(2)
		  ) nor1 (
		  .A(a),
		  .B(b),
		  .Z(g2)
		  );
    
	NAND2 #(.Tpdlh(8),
			.Tpdhl(8)
			) nor2 (
			.A(g2),
			.B(g2),
			.Z(d0)
			);	
			
	NAND2 #(.Tpdlh(8),
			.Tpdhl(8)
			) notOp0 (
			.A(op[0]),
			.B(op[0]),
			.Z(a_ns)
			);
			
	fas fas1(
		.a(a),
		.b(b),
		.cin(cin),
		.a_ns(a_ns),
		.s(d23),
		.cout(cout)
		);
	
	mux4 mux (
		.d0(d0),
		.d1(d1),
		.d2(d23),
		.d3(d23),
		.sel(op),
		.z(s)
		);

endmodule

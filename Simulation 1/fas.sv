// Full Adder/Subtractor template
module fas (
    input logic a,           // Input bit a
    input logic b,           // Input bit b
    input logic cin,         // Carry in
    input logic a_ns,        // A_nS (add/not subtract) control
    output logic s,          // Output S
    output logic cout        // Carry out
);

	logic g1,g3,g4,g5,g6,g8,g9;
	
	XNOR2 #(.Tpdlh(8),
			.Tpdhl(8)
			) G1 (
			.A(a),
			.B(b),
			.Z(g1)
			);	
	XNOR2 #(.Tpdlh(8),
			.Tpdhl(8)
			) G2 (
			.A(g1),
			.B(cin),
			.Z(s)
			);
	
	XNOR2 #(.Tpdlh(8),
			.Tpdhl(8)
			) G3 (
			.A(a),
			.B(a_ns),
			.Z(g3)
			);
	
	OR2 #(.Tpdlh(2),
		  .Tpdhl(2)
		  ) G5 (
		  .A(b),
		  .B(cin),
		  .Z(g5)
		  );
    
	NAND2 #(.Tpdlh(8),
			.Tpdhl(8)
			) G4 (
			.A(cin),
			.B(b),
			.Z(g4)
			);	

	NAND2 #(.Tpdlh(8),
			.Tpdhl(8)
			) G6 (
			.A(g4),
			.B(g4),
			.Z(g6)
			);

	NAND2 #(.Tpdlh(8),
			.Tpdhl(8)
			) G8 (
			.A(g3),
			.B(g5),
			.Z(g8)
			);

	NAND2 #(.Tpdlh(8),
			.Tpdhl(8)
			) G9 (
			.A(g8),
			.B(g8),
			.Z(g9)
			);

	OR2 #(.Tpdlh(2),
		  .Tpdhl(2)
		  ) G7 (
		  .A(g9),
		  .B(g6),
		  .Z(cout)
		  );

endmodule

// 2->1 multiplexer template
module mux2 (
    input logic d0,          // Data input 0
    input logic d1,          // Data input 1
    input logic sel,         // Select input
    output logic z           // Output
);

	logic a,b,c;

	NAND2 #(.Tpdlh(8), .Tpdhl(8)) g1(.A(sel), .B(sel), .Z(a));
    NAND2 #(.Tpdlh(8), .Tpdhl(8)) g2(.A(sel), .B(d1), .Z(c));
	NAND2 #(.Tpdlh(8), .Tpdhl(8)) g3(.A(a), .B(d0), .Z(b));
	NAND2 #(.Tpdlh(8), .Tpdhl(8)) g4(.A(b), .B(c), .Z(z));


endmodule

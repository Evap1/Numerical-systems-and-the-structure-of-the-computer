// Full Adder/Subtractor test bench template
module fas_test;

	logic a;
	logic b;
	logic cin;
	logic a_ns;
	
	logic cout;
	logic s;
	
	initial begin
		a = 1'b0;
		b = 1'b0;
		cin = 1'b0;
		a_ns = 1'b0;
		
		#60
		b = 1'b1;
		
		#60
		b = 1'b0;
		
		#60
		$stop;
	end

	fas test_fas(
		.a(a),
		.b(b),
		.cin(cin),
		.a_ns(a_ns),
		.cout(cout),
		.s(s)
	);


endmodule

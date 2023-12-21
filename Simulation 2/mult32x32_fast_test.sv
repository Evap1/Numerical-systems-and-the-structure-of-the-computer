// 32X32 Multiplier test template
module mult32x32_fast_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

	initial begin
		clk = 0;
		reset = 1;
		start = 0;
		busy = 0;
		product = 0;
		
		#35
		reset = 0;
		a = 209381649;
		b = 321882649;
		
		#10
		start = 1;
		
		#10
		start = 0;
		
		#90
		a = a << 16;
		a = a >> 16;
		b = b << 16;
		b = b >> 16;
		
		#10
		start = 1;
		
		#10
		start = 0;
		
	end
	
	always begin
		#5
		clk = ~clk;
	end
	
	mult32x32_fast test_fast_mult32x32(
				.clk(clk),
				.reset(reset),
				.start(start),
				.a(a),
				.b(b),
				.busy(busy),
				.product(product));

endmodule

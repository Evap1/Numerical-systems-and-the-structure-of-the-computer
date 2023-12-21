// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

logic [7:0] calc_a;
logic [15:0] calc_b;
logic [23:0] result16_8;
logic [63:0] shifted_result = 0;

always_ff @ (posedge clk, posedge reset) begin
	if (reset == 1'b1 || clr_prod == 1'b1) begin
		product = 0;
	end
	else if (upd_prod == 1'b1) begin
		product += shifted_result;
	end
	
end

always_comb begin

	
	if (reset == 0) begin
		case (a_sel)
			0: begin
				calc_a = a[7:0];
			end
			1: begin
				calc_a = a[15:8];
			end
			2: begin
				calc_a = a[23:16];
			end
			3: begin
				calc_a = a[31:24];
			end
		endcase
		
		case (b_sel)
			1'b0: begin
				calc_b = b[15:0];
			end
			1'b1: begin
				calc_b = b[31:16];
			end
		endcase
		
		result16_8 = calc_a * calc_b;
		
		if (shift_sel <= 5) begin
			shifted_result = result16_8 << 8*shift_sel;
		end
		else begin
			shifted_result = 0;
		end
	end
	
end
endmodule

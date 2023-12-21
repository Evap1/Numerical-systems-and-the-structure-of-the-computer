// 32X32 Multiplier FSM
module mult32x32_fast_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    input logic a_msb_is_0,       // Indicates MSB of operand A is 0
    input logic b_msw_is_0,       // Indicates MSW of operand B is 0
    output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

typedef enum {
	idle_st,
	A_st,
	B_st,
	C_st,
	D_st,
	E_st,
	F_st,
	G_st,
	H_st
} sm_type;

	sm_type current_state = idle_st;
	sm_type next_state = idle_st;
	always_ff @ (posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			current_state <= idle_st;
		end
		else begin
			current_state <= next_state;
		end
	end
	
	always_comb begin
		next_state = current_state;
		case (current_state)
			idle_st: begin
				a_sel = 2'b00;
				b_sel = 1'b0;
				shift_sel = 3'b000;
				busy = 1'b0;
				if (start == 1'b1) begin
					next_state = A_st;
					upd_prod = 1'b0;
					clr_prod = 1'b1;
				end
				else begin
					next_state = idle_st;
					upd_prod = 1'b0;
					if (reset == 1'b1) begin
						clr_prod = 1'b1;
					end
					else begin
						clr_prod = 1'b0;
					end
				end
			end
			A_st: begin
				if (reset == 1'b1) begin
					next_state = idle_st;
					clr_prod = 1'b1;
				end
				else begin
					next_state = B_st;
					busy = 1'b1;
					a_sel = 2'b00;
					b_sel = 1'b0;
					shift_sel = 3'b000;
					upd_prod = 1'b1;
					clr_prod = 1'b0;
				end
			end
			B_st: begin
				if (reset == 1'b1) begin
					next_state = idle_st;
					clr_prod = 1'b1;
				end
				else begin
					if (a_msb_is_0 == 1'b1 && b_msw_is_0 == 1'b1) begin
						next_state = idle_st;
					end
					else if (a_msb_is_0 == 1'b1) begin
						next_state = E_st;
					end
					else begin
						next_state = C_st;
					end
					busy = 1'b1;
					a_sel = 2'b01;
					b_sel = 1'b0;
					shift_sel = 3'b001;
					upd_prod = 1'b1;
					clr_prod = 1'b0;
				end
			end
			C_st: begin
				if (reset == 1'b1) begin
					next_state = idle_st;
					clr_prod = 1'b1;
				end
				else begin
					next_state = D_st;
					busy = 1'b1;
					a_sel = 2'b10;
					b_sel = 1'b0;
					shift_sel = 3'b010;
					upd_prod = 1'b1;
					clr_prod = 1'b0;
				end
			end
			D_st: begin
				if (reset == 1'b1) begin
					next_state = idle_st;
					clr_prod = 1'b1;
				end
				else begin
					if (b_msw_is_0 == 1'b1 && a_msb_is_0 == 1'b0) begin
						next_state = idle_st;
					end
					else begin
						next_state = E_st;
					end
					busy = 1'b1;
					a_sel = 2'b11;
					b_sel = 1'b0;
					shift_sel = 3'b011;
					upd_prod = 1'b1;
					clr_prod = 1'b0;
				end
			end
			E_st: begin
				if (reset == 1'b1) begin
					next_state = idle_st;
					clr_prod = 1'b1;
				end
				else begin
					next_state = F_st;
					busy = 1'b1;
					a_sel = 2'b00;
					b_sel = 1'b1;
					shift_sel = 3'b010;
					upd_prod = 1'b1;
					clr_prod = 1'b0;
				end
			end
			F_st: begin
				if (reset == 1'b1) begin
					next_state = idle_st;
					clr_prod = 1'b1;
				end
				else begin
					if (a_msb_is_0 == 1'b1 && b_msw_is_0 == 1'b0) begin
						next_state = idle_st;
					end
					else begin
						next_state = G_st;
					end
					busy = 1'b1;
					a_sel = 2'b01;
					b_sel = 1'b1;
					shift_sel = 3'b011;
					upd_prod = 1'b1;
					clr_prod = 1'b0;
				end
			end
			G_st: begin
				if (reset == 1'b1) begin
					next_state = idle_st;
					clr_prod = 1'b1;
				end
				else begin
					next_state = H_st;
					busy = 1'b1;
					a_sel = 2'b10;
					b_sel = 1'b1;
					shift_sel = 3'b100;
					upd_prod = 1'b1;
					clr_prod = 1'b0;
				end
			end
			H_st: begin
				next_state = idle_st;
				if (reset == 1'b1) begin
					clr_prod = 1'b1;
				end
				else begin
					clr_prod = 1'b0;
				end
				busy = 1'b1;
				a_sel = 2'b11;
				b_sel = 1'b1;
				shift_sel = 3'b101;
				upd_prod = 1'b1;
			end
		endcase
end

endmodule
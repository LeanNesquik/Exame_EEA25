module ArithmeticLogicUnit(
    input       [31:0]  operand_a,
    input       [31:0]  operand_b,
    input       [2:0]   control_signal,
    output  reg [31:0]  result,
    output              is_zero
);

    always @(*) begin
        case (control_signal)
            3'b010: result = operand_a + operand_b;      // ADD
            3'b110: result = operand_a - operand_b;      // SUB
            3'b000: result = operand_a & operand_b;      // AND
            3'b001: result = operand_a | operand_b;      // OR
            3'b111: result = (operand_a < operand_b) ? 32'b1 : 32'b0; // SLT
            default: result = 32'bx;                     // Undefined
        endcase
    end

    assign is_zero = (result == 32'b0) ? 1'b1 : 1'b0;

endmodule

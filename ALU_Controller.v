module ALU_Controller(
    input       [5:0]   funct_code,
    input       [1:0]   alu_op,
    output  reg [2:0]   control_signal
);

    always @(*) begin
        case (alu_op)
            2'b00: control_signal = 3'b010; // ADD pro lw/sw
            2'b01: control_signal = 3'b110; // SUB pro beq
            2'b10: begin
                case (funct_code)
                    6'b100000: control_signal = 3'b010; // ADD
                    6'b100010: control_signal = 3'b110; // SUB
                    6'b100100: control_signal = 3'b000; // AND
                    6'b100101: control_signal = 3'b001; // OR
                    6'b101010: control_signal = 3'b111; // SLT
                    default:   control_signal = 3'bxxx; // Undefined
                endcase
            end
            default: control_signal = 3'bxxx; // Undefined
        endcase
    end

endmodule

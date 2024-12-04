module ProcessorControl(
    input        clk,
    input        reset_n,
    output  reg [1:0]    alu_operation,
    output  reg          memory_write, register_write,
    output  reg          register_destination,
    output  reg          memory_to_register,
    output  reg          alu_source,
    output  reg          branch_control,
    output  reg          jump_signal,
    input   [5:0]        opcode_input
);

    always @(*) begin
        case (opcode_input)
            //instrução tipo R
            6'b000000: begin
                register_write       = 1'b1;
                register_destination = 1'b1;
                alu_source           = 1'b0;
                branch_control       = 1'b0;
                memory_write         = 1'b0;
                memory_to_register   = 1'b0;
                alu_operation        = 2'b10;
                jump_signal          = 1'b0;
            end
            //instrução BEQ
            6'b000100: begin
                register_write       = 1'b0;
                register_destination = 1'b0; // Don't care
                alu_source           = 1'b0;
                branch_control       = 1'b1;
                memory_write         = 1'b0;
                memory_to_register   = 1'b0; // Don't care
                alu_operation        = 2'b01;
                jump_signal          = 1'b0;
            end
            //Instrução SW
            6'b101011: begin
                register_write       = 1'b0;
                register_destination = 1'b0;
                alu_source           = 1'b1;
                branch_control       = 1'b0;
                memory_write         = 1'b1;
                memory_to_register   = 1'b1;
                alu_operation        = 2'b00;
                jump_signal          = 1'b0;
            end
            //instrução LW 
            6'b100011: begin
                register_write       = 1'b1;
                register_destination = 1'b0;
                alu_source           = 1'b1;
                branch_control       = 1'b0;
                memory_write         = 1'b0;
                memory_to_register   = 1'b1;
                alu_operation        = 2'b00;
                jump_signal          = 1'b0;
            end
            //instrução ADDI 
            6'b001000: begin
                register_write       = 1'b1;
                register_destination = 1'b0;
                alu_source           = 1'b1;
                branch_control       = 1'b0;
                memory_write         = 1'b0;
                memory_to_register   = 1'b0;
                alu_operation        = 2'b00;
                jump_signal          = 1'b0;
            end
            //instrução tipo J
            6'b000010: begin
                register_write       = 1'b0;
                register_destination = 1'b0;
                alu_source           = 1'b0;
                branch_control       = 1'b0;
                memory_write         = 1'b0;
                memory_to_register   = 1'b0;
                alu_operation        = 2'b00;
                jump_signal          = 1'b1;
            end
            default: begin
                register_write       = 1'b0;
                register_destination = 1'b0;
                alu_source           = 1'b0;
                branch_control       = 1'b0;
                memory_write         = 1'b0;
                memory_to_register   = 1'b0;
                alu_operation        = 2'b00;
                jump_signal          = 1'b0;
            end
        endcase
    end

endmodule

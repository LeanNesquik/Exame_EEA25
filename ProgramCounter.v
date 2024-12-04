module ProgramCounter(
    input        clk,
    input        reset_n,
    input        branch_select,
    input        jump_enable,
    input  [31:0] sign_extended_immediate,
    input  [25:0] jump_address,
    output reg [31:0] pc
);

    wire [31:0] next_pc;
    wire [31:0] pc_plus_4;
    wire [31:0] branch_target;
    wire [31:0] jump_target;

    //PC + 4
    assign pc_plus_4 = pc + 32'd4;

    //endereço de ramificação
    assign branch_target = (sign_extended_immediate << 2) + pc_plus_4;

    //endereço de salto
    assign jump_target = {pc_plus_4[31:28], jump_address, 2'b00};

    //qual é o próximo valor de PC?
    assign next_pc = jump_enable ? jump_target : (branch_select ? branch_target : pc_plus_4);

    always @(posedge clk) begin
        if (reset_n) begin
            pc <= 32'b0;
        end else begin
            pc <= next_pc;
        end
    end

endmodule

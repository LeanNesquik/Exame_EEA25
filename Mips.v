module Mips (
    input clk,
    input reset,
    output [31:0] writedata,    
    output [31:0] aluresult,    
    output memwrite             
);

    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] read_data, write_data;
    wire [31:0] source_a, source_b, alu_result;
    wire        reg_write, mem_write;
    wire        reg_dst, alu_src, mem_to_reg;
    wire [4:0]  write_register;
    wire [31:0] sign_extended_immediate, read_data_2;
    wire [31:0] write_data_3;
    wire        pc_src, branch, zero_flag;
    wire        jump_enable;
    wire [2:0]  alu_control;
    wire [1:0]  alu_op;

    assign pc_src         = branch & zero_flag;
    assign write_register = reg_dst ? instruction[15:11] : instruction[20:16];
    assign source_b       = alu_src ? sign_extended_immediate : read_data_2;
    assign write_data_3   = mem_to_reg ? read_data : alu_result;
    assign write_data     = read_data_2;
    assign writedata = write_data;   
    assign aluresult = alu_result;  
    assign memwrite = mem_write;    



    ProgramCounter program_counter (
        .clk(clk),
        .reset_n(reset),
        .pc(pc),
        .branch_select(pc_src),
        .jump_enable(jump_enable),
        .jump_address(instruction[25:0]),
        .sign_extended_immediate(sign_extended_immediate)
    );

    
    InstructionFetcher instruction_fetcher (
        .instruction(instruction),
        .address(pc)
    );

    
    ProcessorControl processor_control (
        .clk(clk),
        .reset_n(reset),
        .opcode_input(instruction[31:26]),
        .memory_write(mem_write),
        .register_write(reg_write),
        .register_destination(reg_dst),
        .alu_source(alu_src),
        .memory_to_register(mem_to_reg),
        .alu_operation(alu_op),
        .jump_signal(jump_enable),
        .branch_control(branch)
    );

    
    RegisterBank register_bank (
        .clk(clk),
        .read_address_1(instruction[25:21]),
        .read_data_1(source_a),
        .read_address_2(instruction[20:16]),
        .read_data_2(read_data_2),
        .write_address(write_register),
        .write_enable(reg_write),
        .write_data(write_data_3)
    );

    
    SignExtensionUnit sign_extension_unit (
        .input_value(instruction[15:0]),
        .extended_value(sign_extended_immediate)
    );

    
    MemoryModule memory_module (
        .clk(clk),
        .reset(reset),
        .address(alu_result),
        .read_data(read_data),
        .write_enable(mem_write),
        .write_data(write_data)
    );


    ALU_Controller alu_controller (
        .alu_op(alu_op),
        .funct_code(instruction[5:0]),
        .control_signal(alu_control)
    );


    ArithmeticLogicUnit arithmetic_logic_unit (
        .operand_a(source_a),
        .operand_b(source_b),
        .control_signal(alu_control),
        .result(alu_result),
        .is_zero(zero_flag)
    );

endmodule

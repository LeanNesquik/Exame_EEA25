module MemoryModule(
    input        clk,
    input        reset,
    input        [31:0]  address,
    input        [31:0]  write_data,
    input                 write_enable,
    output  reg  [31:0]  read_data
);

    reg [31:0] memory_array[0:84];

    //ler operação
    always @(*) begin
        read_data = memory_array[address];
    end

    //escrever operação
    always @(posedge clk) begin
        if (write_enable) begin
            memory_array[address] <= write_data;
        end
    end

endmodule

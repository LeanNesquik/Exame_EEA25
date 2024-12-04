module RegisterBank(
    input              clk,
    input       [4:0]  read_address_1,
    input       [4:0]  read_address_2,
    input       [4:0]  write_address,
    input              write_enable,
    input       [31:0] write_data,
    output reg  [31:0] read_data_1,
    output reg  [31:0] read_data_2
);

    reg [31:0] registers[31:0]; //banco de registradores (32 registradores de 32 bits)

    //inicializa os registradores no bloco initial
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end

    //leitura dos registradores (sempre que os endereços mudarem)
    always @(*) begin
        read_data_1 = registers[read_address_1];
        read_data_2 = registers[read_address_2];
    end

    //escrita nos registradores no clock de subida
    always @(posedge clk) begin
        if (write_enable && write_address != 5'b00000) begin
            registers[write_address] <= write_data;
        end
    end

endmodule

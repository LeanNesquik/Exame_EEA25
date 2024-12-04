 module InstructionFetcher(
    input  [31:0] address,
    output [31:0] instruction
);

    reg [31:0] instruction_memory[0:31];

    // Carrega as instruções do databank.dat
    initial begin
        $readmemh("./databank.dat", instruction_memory, 0, 17); //ajust do intervalo
    end

    //mapeamento do endereço pra instrução
    assign instruction = instruction_memory[address[31:2]];

endmodule

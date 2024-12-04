# Exame_EEA25
Para rodar o testbench usar os seguintes comandos no terminal:

Compilar:
iverilog -o mips_sim.out Mips.v MipsTestbench.v ArithmeticLogicUnit.v ALU_Controller.v MemoryModule.v InstructionFetcher.v SignExtensionUnit.v RegisterBank.v ProcessorControl.v ProgramCounter.v

Executar a simulação:
vvp mips_sim.out

Visualizar os sinais no gtkwave:
gtkwave mips_wave.vcd

Visualizar na FPGA: conectar a FPGA no computador e carregar o arquivo binário Mips.bin na entrada


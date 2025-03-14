filename = Mips
pcf_file = Mips.pcf

ICELINK_DIR=$(shell df | grep iCELink | awk '{print $$6}')
${warning iCELink path: $(ICELINK_DIR)}

build:
	yosys -p "synth_ice40 -json $(filename).json -blif $(filename).blif" $(filename).v \
     ArithmeticLogicUnit.v ALU_Controller.v MemoryModule.v InstructionFetcher.v SignExtensionUnit.v RegisterBank.v \
     ProcessorControl.v ProgramCounter.v
	nextpnr-ice40 --lp1k --package cm36 --json $(filename).json --pcf $(pcf_file) --asc $(filename).asc --freq 48 
	icepack $(filename).asc $(filename).bin

prog_flash:
	@if [ -d '$(ICELINK_DIR)' ]; \
        then \
            cp $(filename).bin $(ICELINK_DIR); \
        else \
            echo "iCELink not found"; \
            exit 1; \
    fi


clean:
	rm -rf $(filename).blif $(filename).asc $(filename).bin
module MipsTestbench();
    reg clk;
    reg reset;
    wire [31:0] writedata;
    wire [31:0] data_address; 
    wire memwrite;

   
    Mips dut (
        .clk(clk),
        .reset(reset),
        .writedata(writedata),
        .aluresult(data_address), 
        .memwrite(memwrite)
    );

    //inicializa o reset
    initial begin
        $dumpfile("mips_wave.vcd");   //gtkwave
        $dumpvars(0, MipsTestbench); 
        reset <= 1;
        #22;
        reset <= 0;
    end

    //clock 
    always begin
        clk <= 1;
        #5;
        clk <= 0;
        #5;
    end

    //verificar resultados
    always @(negedge clk) begin
        if (memwrite) begin
            if (data_address === 84 && writedata === 7) begin
                $display("Simulacao bem sucedida");
                $stop;
            end else if (data_address !== 80) begin
                $display("Falha da simulacao");
                $display("Falha em %0t | Address: %d | Write Data: %d", $time, data_address, writedata);
                $stop;
            end
        end
    end

    //evitar simulação infinita
    initial begin
        #500; 
        $display("Simulacao timeout");
        $stop;
    end
endmodule
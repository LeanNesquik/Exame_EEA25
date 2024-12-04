module SignExtensionUnit(
    input  [15:0] input_value,
    output [31:0] extended_value
);

    assign extended_value = {{16{input_value[15]}}, input_value};

endmodule

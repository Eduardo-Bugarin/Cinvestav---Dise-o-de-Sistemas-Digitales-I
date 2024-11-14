`timescale 1ns / 1ps

module Adder #(parameter WIDTH = 4)(
    input [(WIDTH - 1): 0] a,
    input [(WIDTH - 1): 0] b,
    output carry_out,
    output [(WIDTH - 1): 0] result
);

assign {carry_out, result} = a + b;

endmodule
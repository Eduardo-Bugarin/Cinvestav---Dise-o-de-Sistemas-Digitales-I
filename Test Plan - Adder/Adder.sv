`timescale 1ns / 1ps

module Adder #(parameter WIDTH = 4)(
    input [(WIDTH - 1): 0] a,
    input [(WIDTH - 1): 0] b,
    output [(WIDTH - 1): 0] result
);

assign result = a + b;

endmodule
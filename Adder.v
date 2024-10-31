module Adder#(parameter WIDTH = 8)(
  input wire[WIDTH-1:0] a,b,
  input carry_in,
  output carry_out,
  output wire [WIDTH-1:0] z
);
  
  assign {carry_out,z} = a+b+carry_in;
  
endmodule
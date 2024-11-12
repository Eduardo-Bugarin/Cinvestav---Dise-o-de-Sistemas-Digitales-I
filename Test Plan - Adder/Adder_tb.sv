`timescale 1ns / 1ps

module Adder_tb;
/////////// Test Cases ////////////////////
//  	`define TEST_1
//   	`define TEST_2
//   	`define TEST_3
//   	`define TEST_4
//   	`define TEST_5
//   	`define TEST_6
//   	`define TEST_7
   	`define TEST_8

    // Parameterizable width
    localparam WIDTH = 4;

    // Instantiation of the object adder_interface
    adder_interface #(.WIDTH(WIDTH)) adder_interface();

    // Instantiation of the object adder 
    Adder #(.WIDTH(WIDTH)) DUT(
        .result(adder_interface.result),
        .a(adder_interface.a),
        .b(adder_interface.b)
    );

  `ifdef TEST_1 //Basic Addition without Overflow
  initial begin
    repeat(10) begin
        adder_interface.input_a_and_b_to_random_range();
        #1;
        $display("a: %d", adder_interface.a);
        $display("b: %d", adder_interface.b);
        $display("Result: %d", adder_interface.result);
    end
    $finish;
  end
  `endif
  
  `ifdef TEST_2 //Zero in the Inputs
  initial begin
    adder_interface.input_a_and_b_to_zero();
    #1;
    $display("a: %d", adder_interface.a);
    $display("b: %d", adder_interface.b);
    $display("Result: %d", adder_interface.result);
    $finish;
  end
  `endif
  
  `ifdef TEST_3 //Middle Values
  initial begin
    adder_interface.inputs_to_middle_value;
    #1;
    $display("a: %d", adder_interface.a);
    $display("b: %d", adder_interface.b);
    $display("Result: %d", adder_interface.result);
    $finish;
  end
  `endif
  
  `ifdef TEST_4//Limit Values
  initial begin
    adder_interface.inputs_to_limit_value;
    adder_interface.inputs_to_limit_value;
    #1;
    $display("a: %d", adder_interface.a);
    $display("b: %d", adder_interface.b);
    $display("Result: %d", adder_interface.result);
    $finish;
  end
  `endif
  
  `ifdef TEST_5//Addition of Even Numbers
  initial begin
    repeat(10) begin
        adder_interface.input_a_to_even_value();
        adder_interface.input_b_to_even_value();
        #1;
        $display("a: %d", adder_interface.a);
        $display("b: %d", adder_interface.b);
        $display("Result: %d", adder_interface.result);
    end
    $finish;
  end
  `endif
  
  `ifdef TEST_6 //Addition of Odd Numbers
  initial begin
    repeat(10) begin
        adder_interface.input_a_to_odd_value;
        adder_interface.input_b_to_odd_value;
        #1;
        $display("a: %d", adder_interface.a);
        $display("b: %d", adder_interface.b);
        $display("Result: %d", adder_interface.result);
    end
    $finish;
  end
  `endif
  
  `ifdef TEST_7//Sum of Even a and Odd b
  initial begin
    repeat(10) begin
        adder_interface.input_a_to_even_value;
        adder_interface.input_b_to_odd_value;
        #1;
        $display("a: %d", adder_interface.a);
        $display("b: %d", adder_interface.b);
        $display("Result: %d", adder_interface.result);
    end
    $finish;
  end
  `endif
  
  `ifdef TEST_8//Sum of Odd a and Even b
  initial begin
    repeat(10) begin
        adder_interface.input_a_to_odd_value;
        adder_interface.input_b_to_even_value;
        #1;
        $display("a: %d", adder_interface.a);
        $display("b: %d", adder_interface.b);
        $display("Result: %d", adder_interface.result);
    end
    $finish;
  end
  `endif
endmodule


interface adder_interface #(parameter WIDTH = 4) ();
    logic [(WIDTH - 1): 0] result;
    logic [(WIDTH - 1): 0] a;
    logic [(WIDTH - 1): 0] b;
    
    // BFM - Bus Functional Model // A set of functions that generate valid stimuli for the DUT.

    // function that generates random values bounded to avoid overflow.     
    function input_a_and_b_to_random_range();
        a = $urandom & ~(1 << (WIDTH - 1));
        b = $urandom & ~(1 << (WIDTH - 1));
    endfunction
    
    // function that assigns zero to both inputs.
    function input_a_and_b_to_zero();
        a = 0;
        b = 0;
    endfunction
    
    // function that assigns the middle value to both inputs.
    function inputs_to_middle_value();
        a = {WIDTH{1'b1}} & ~(1 << (WIDTH - 1));
        b = {WIDTH{1'b1}} & ~(1 << (WIDTH - 1));
    endfunction 

    // function that assigns the limit values to both inputs.
    function inputs_to_limit_value();
        a = {WIDTH{1'b1}};
        b = {WIDTH{1'b1}};
    endfunction

    // function that assigns an even value to input a 
    function input_a_to_even_value();
        a = $urandom & ~({WIDTH{1'b0}}+1'b1);
    endfunction
 
    // function that assigns an even value to input b
    function input_b_to_even_value();
        b = $urandom & ~({WIDTH{1'b0}}+1'b1);
    endfunction
    
    // function that assigns an odd value to input a.
    function input_a_to_odd_value();
        a = $urandom | ({WIDTH{1'b0}}+1'b1);
    endfunction
    
    // function that assigns an odd value to input b.
    function input_b_to_odd_value();
        b = $urandom | ({WIDTH{1'b0}}+1'b1);
    endfunction
    
endinterface
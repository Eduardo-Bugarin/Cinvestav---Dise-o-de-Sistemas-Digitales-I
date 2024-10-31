module Testbench_adder #(parameter WIDTH = 8);
    bit clk;
  	bit f;
  	integer Counter;
  	reg [WIDTH-1:0] a,b;
  	reg carry_in;
  	wire [WIDTH-1:0] z;
  	wire carry_out;
  
  	event Sync;
  	event Sync2;
  	event Done;
  
  	always #5ns clk = ~clk;
  
	Adder #(WIDTH) uut (
        .a(a),
        .b(b),
        .carry_in(carry_in),
        .carry_out(carry_out),
        .z(z)
    );
  
  	always @(Sync2) begin
      if(~f) begin
      	a = $urandom();	
        $display("Valor aleatorio para a %b:",a);
      	Counter = Counter + 1;
      end
      else begin
        a = a;
      end
    end

  	always @(Sync) begin
      if(~f) begin
      	->Sync2;
      	b = $urandom();
        $display("Valor aleatorio para b %b:",b);
      end
  	  else begin
        b = b;
      end
    end

    always @(posedge clk) begin
      if(~f) begin
      	->Sync;
      	carry_in = $urandom();
        $display("Valor aleatorio para Carry in: %b", carry_in);
      end
      else begin
        carry_in = carry_in;
      	Counter = Counter + 1;
      end
    end
    
  	initial begin
      Counter = 0;
      fork
        begin
          @(Counter == 5)
          f = 1;
      	end
      	begin
          @(Counter == 10)
          ->Done;
      	end
      	join
      $display("Ciclos terminados");
      end  
  
    initial begin
	$dumpfile("dump.vcd");
	$dumpvars;
    	@(Done)
        $finish;
    end
endmodule
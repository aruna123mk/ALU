// Code your testbench here
// or browse Examples
`include "interface.sv"
`include "test.sv"
module top;
  bit clock, reset;
  
  always #2 clock = ~clock;
  
  alu_intf vif(clock, reset);
  alu ALU(.clock(vif.clock), .reset(vif.reset), .A(vif.A), .B(vif.B),.ALU_Sel(vif.ALU_Sel), .ALU_Out(vif.ALU_Out));
  test alu_test(vif);
  
 
  initial begin
    clock = 0;
    reset = 1;
    #5; 
    reset = 0;
  end
  
  initial begin
    // Dump waves
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end
 
  
endmodule
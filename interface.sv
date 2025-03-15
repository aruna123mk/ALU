interface alu_intf(input logic clock, reset);
  logic [7:0] A,B;
  logic [1:0] ALU_Sel;
 // logic CarryOut;
  logic [7:0] ALU_Out;
endinterface

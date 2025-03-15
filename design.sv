// Code your design here
module alu(
  input clock,
  input reset,
  input [7:0] A,B,  // ALU 8-bit Inputs  OPERANDS                
  input [1:0] ALU_Sel,// ALU Selection: ADD, SUB, MULTI, DIV, MODULO, SHIFT RIGHT, SHIFT LEFT, lOGICAL OPERATIONS, ARTHIMATIC SHIFTS, ..........
  output reg [7:0] ALU_Out, // ALU 8-bit Output
  output bit CarryOut // Carry Out Flag
);

  reg [7:0] ALU_Result;
  wire [8:0] tmp;

  assign tmp = {1'b0,A} + {1'b0,B};

  
  always @(posedge clock or posedge reset) begin
    if(reset) begin
      ALU_Out  <= 8'd0;
      CarryOut <= 1'd0;
    end
    else begin
      ALU_Out <= ALU_Result;
      CarryOut <= tmp[8];
    end
  end


  always @(A,B,ALU_Sel)
    begin
      case(ALU_Sel)
        2'b00: // Addition
          ALU_Result = A + B ; 
        2'b01: // Subtraction
          ALU_Result = A - B ;
        2'b10: // Multiplication
          ALU_Result = A * B;
        2'b11: // Division
          ALU_Result = A/B;
        default: ALU_Result = 8'hAC ; // Give out random BAD value
      endcase
    end

endmodule
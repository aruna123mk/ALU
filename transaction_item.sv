class transaction_item;
  
// Define inputs here which you want to drive to the DUT.
 rand logic [7:0] A, B;
 rand logic [1:0] ALU_Sel;
// DEFINE OUTPUT: nEED NOT TO HAVE RANDOMIZATION FOR THE OUTPUTS.
      logic [7:0] ALU_Out;
  //    logic CarryOut;
  
// Constraints  
  constraint sel_i {ALU_Sel inside {0,1,2,3};};
 // constraint sel_i {ALU_Sel dist{0:/25, 1:/25, 2:/25, 3:/25};}
  constraint a_value {A inside {[1:10]};}
  constraint b_value {B inside {[2:10]};}
  
// METHODS
  function display();
    $display("----------------------------------------");
    $display("A=%d, B=%d, ALU_Sel=%d, ALU_out=%d",A, B, ALU_Sel, ALU_Out);
    $display("----------------------------------------");
  endfunction
endclass


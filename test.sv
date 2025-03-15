`include "package.sv"
program test(alu_intf vif);
  environment env;
  
  initial begin
    env = new(vif);
    env.agt.gen.count = 50;
    env.run();
  end
endprogram
/*
program test1(alu_intf vif);
  environment env;
  
  initial begin
    env = new(vif);
    env.agt.gen.count = 10;
    env.run();
  end
endprogram
*/
class agent;
  driver drv;
  monitor mon;
  generator gen;
  
  mailbox gen2driv;
  virtual alu_intf vif;
  
  function new(virtual alu_intf vif, mailbox mon2scbd);
    gen2driv = new();
    drv = new(gen2driv, vif);
    mon = new(mon2scbd, vif);
    gen = new(gen2driv);
  endfunction

  task run();
    fork
      drv.run();
      mon.run();
      gen.run();
    join_any
  endtask
  
endclass
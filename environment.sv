class environment;
  agent agt;
  scoreboard scbd;
 
  mailbox mon2scbd;
  function new(virtual alu_intf vif);
    mon2scbd = new();
    agt = new(vif, mon2scbd);
    scbd = new(mon2scbd);
  endfunction

  task run();
    fork
      agt.run();
      scbd.run();
    join_any
    wait(agt.gen.count == scbd.compare_count);
    $finish;
  endtask
endclass
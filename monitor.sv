class monitor;
  virtual alu_intf vif;

  mailbox mon2scbd;
  
  function new(mailbox mon2scbd, virtual alu_intf vif);
    this.mon2scbd = mon2scbd;
    this.vif = vif;
  endfunction
  
  task run;
    forever begin
      transaction_item item;
      wait(!vif.reset);
      @(posedge vif.clock);
       item = new();
     // $display("Got the transaction fron dut to scbd: A=%d, B=%d,ALU_SEL=%d", vif.A, vif.B, vif.ALU_Sel);
       item.A       = vif.A;
       item.B       = vif.B;
       item.ALU_Sel = vif.ALU_Sel; 
      @(posedge vif.clock);
       item.ALU_Out  = vif.ALU_Out;
     //  item.CarryOut = vif.CarryOut;
      mon2scbd.put(item);
    //  $display("Got the transaction fron dut to scbd: A=%d, B=%d,ALU_SEL=%d", item.A, item.B, item.ALU_Sel);
    end
  endtask
endclass
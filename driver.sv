class driver;
  virtual alu_intf vif;
  transaction_item item;
  mailbox gen2driv;
  
  function new(mailbox gen2driv, virtual alu_intf vif);
    this.gen2driv = gen2driv;
    this.vif = vif;
  endfunction
  
  task run;
    forever begin
      @(posedge vif.clock);
      gen2driv.get(item);
    //  $display("BEFORE SENDING TO DUT: A=%d, B=%d, ALU_Sel=%d", item.A, item.B,item.ALU_Sel);
      vif.A       <= item.A;
      vif.B       <= item.B;
      vif.ALU_Sel <= item.ALU_Sel;
     // $display("AFTER SENDING TO DUT: A=%d, B=%d, ALU_Sel=%d", vif.A, vif.B, vif.ALU_Sel);
    /*  @(posedge vif.clock);
      vif.ALU_Out  <= item.ALU_Out;
      vif.CarryOut <= item.CarryOut;
      */
    end
  endtask
  
endclass
class generator;
  // Create an instance for the transaction_item
  transaction_item item;
  // Create a mailbox: To send the data items to the driver.
  mailbox gen2driv;
  int count;
  
  function new(mailbox gen2driv);
    this.gen2driv = gen2driv;
  endfunction
  
  task run();
  //  $display("GENERATOR");
    repeat(count) begin
      item = new();
      if(!item.randomize())
        $display("Randomization failed");
      gen2driv.put(item);
     // $display("Tras stroed in mailbox gen");
    end
  endtask
endclass
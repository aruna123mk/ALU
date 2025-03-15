class scoreboard;
  mailbox mon2scbd;
  transaction_item cov_item;
  int compare_count;
 
  covergroup ALU_COVERAGE;
       option.per_instance = 1; // Enable per-instance coverage      
       A_IN : coverpoint cov_item.A{bins b1[] ={[1:10]};}
       B_IN : coverpoint cov_item.B{bins b2[] ={[4'b00010:4'b1010]};}
       ALU_SEL_IN: coverpoint cov_item.ALU_Sel;
  endgroup
  
  function new(mailbox mon2scbd);
    this.mon2scbd = mon2scbd;
    cov_item = new();
    ALU_COVERAGE  = new();
  endfunction
  
  
  task run;
    forever begin
      transaction_item item;
      item = new();
      mon2scbd.get(item);
      cov_item = item;
    //  $display("Got in scbd: A=%d, B=%d,ALU_SEL=%d", item.A, item.B, item.ALU_Sel);
      if(item.ALU_Sel=='h0) begin
         ALU_COVERAGE.sample();
        if(item.A + item.B == item.ALU_Out) begin
          $display("ADDITION: Matched: A = %0d, B = %0d, ALU_Sel=%d, ALU_Out = %0d", item.A, item.B, item.ALU_Sel, item.ALU_Out);
        end
        else begin
          $display("ADDITION: NOT matched: A = %0d, B = %0d, , ALU_Sel=%d, ALU_Out = %0d", item.A, item.B, item.ALU_Sel, item.ALU_Out);
        end
      end
     else if(item.ALU_Sel=='h1) begin
        ALU_COVERAGE.sample();
        if(item.A - item.B == item.ALU_Out) begin
          $display("SUBTRACTION: Matched: A = %0d, B = %0d, , ALU_Sel=%d, ALU_Out = %0d", item.A, item.B, item.ALU_Sel, item.ALU_Out);
        end
        else begin
          $display("SUBTRACTION: NOT matched: A = %0d, B = %0d, , ALU_Sel=%d, ALU_Out = %0d", item.A, item.B, item.ALU_Sel, item.ALU_Out);
        end
      end
      else if(item.ALU_Sel=='h2) begin
         ALU_COVERAGE.sample();
        if(item.A * item.B == item.ALU_Out) begin
          $display("MULTIPLICATION: Matched: A = %0d, B = %0d, ALU_Sel=%d, ALU_Out = %0d", item.A, item.B, item.ALU_Sel, item.ALU_Out);
        end
        else begin
          $display("MULTIPLICATION: NOT matched: A = %0d, B = %0d, ALU_Sel=%d, ALU_Out = %0d", item.A, item.B, item.ALU_Sel, item.ALU_Out);
        end
      end
     else if(item.ALU_Sel=='h3) begin
        ALU_COVERAGE.sample();
        if(item.A / item.B == item.ALU_Out) begin
          $display("DIVISION: Matched: A = %0d, B = %0d, ALU_Sel=%d, ALU_Out = %0d", item.A, item.B,item.ALU_Sel, item.ALU_Out);
        end
        else begin
          $display("DIVISION: NOT matched: A = %0d, B = %0d, ALU_Sel=%d, ALU_Out = %0d", item.A, item.B, item.ALU_Sel, item.ALU_Out);
        end
      end
    /*  if (cov_item != null) begin
         $display("Sampling Coverage: A = %0d, B = %0d, ALU_Sel = %0d", cov_item.A, cov_item.B, cov_item.ALU_Sel);
         ALU_COVERAGE.sample();
      end
      */
      sample();
      compare_count++;
    end
  endtask
  
 function void sample;
  $display("-------------------------------------------------");
  $display("Overall Coverage:                               %0.2f%%", $get_coverage());
  $display("Coverage of covergroup 'ALU_COVERAGE':         %0.2f%%", ALU_COVERAGE.get_coverage());

  // Uncomment to get coverage of individual coverpoints
  $display("Coverage of coverpoint 'A_IN':                 %0.2f%%", ALU_COVERAGE.A_IN.get_inst_coverage());
  $display("Coverage of coverpoint 'B_IN':                 %0.2f%%", ALU_COVERAGE.B_IN.get_inst_coverage());
  $display("Coverage of coverpoint 'ALU_SEL_IN':           %0.2f%%", ALU_COVERAGE.ALU_SEL_IN.get_inst_coverage());
endfunction
  
  
  
  /*
  task run;
    forever begin
      transaction_item item, item_recieved; 
      item = new();
      mon2scbd.get(item);
      $display("SCBD");
      item_queue.push_back(item);
      wait(item_queue.size() !=0);
       item_recieved = item_queue.pop_front();
      compare(item_recieved);
      
      compare_count++;
    end
  endtask
  
  
  //--------------------------------------------------------
  //Compare : Generate Expected Result and Compare with Actual
  //--------------------------------------------------------
  task compare(transaction_item item_recieved);
    logic [7:0] expected;
    logic [7:0] actual;
    
    case(item_recieved.ALU_Sel)
      0: begin //A + B
        expected = item_recieved.A + item_recieved.B;
      end
      1: begin //A - B
        expected = item_recieved.A - item_recieved.B;
      end
      2: begin //A * B
        expected = item_recieved.A * item_recieved.B;
      end
      3: begin //A / B
        expected = item_recieved.A / item_recieved.B;
      end
    endcase
    
    actual = item_recieved.ALU_Out;
    
    if(actual != expected) begin
      $display("Transaction failed! ACT=%d, EXP=%d", actual, expected);
    end
    else begin
      // Note: Can display the input and op_code as well if you want to see what's happening
      $display("Transaction Passed! ACT=%d, EXP=%d", actual, expected);
    end
  
  endtask: compare
  */
  
endclass
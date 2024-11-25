# Key changes to provided scripts/testbenches

## `tb_dist_sort.sv`

```
//----------Store outs into memory for comparison--------------//
int k =0;
always@ (posedge clk) begin
 if(out_valid) begin
   if (k < num_of_inputs+1) begin
     addr_1st_mem[k] = addr_1st;
     addr_2nd_mem[k] = addr_2nd;
     k++;
     end // if k<num_of_inputs
  else begin
      $display("!!!!!!!!!!!!!!!!!!!!!!!!!Out Valid is high for too long. More outputs than inputs are present!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
   end//  else
   end // out_valid
end
//-------------------------------------------------------------//
```

From the original file, I changed `negedge clk` to `posedge clk`. This is because of a one-off error that resulted in design outputs being compared to the *next* golden output. 
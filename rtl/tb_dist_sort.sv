`timescale 1ps/1ps

module tb_dist_sort();

//--------------------To be read in from .txt-------------------//
parameter num_of_inputs = 1000;
integer fp1,fp2,p,q,i;

logic  [num_of_inputs-1:0] [63:0] query_ip;
logic  [num_of_inputs-1:0] [63:0] S_0_ip;
logic  [num_of_inputs-1:0] [63:0] S_1_ip;
logic  [num_of_inputs-1:0] [63:0] S_2_ip;
logic  [num_of_inputs-1:0] [63:0] S_3_ip;
logic  [num_of_inputs-1:0] [63:0] S_4_ip;
logic  [num_of_inputs-1:0] [63:0] S_5_ip;
logic  [num_of_inputs-1:0] [63:0] S_6_ip;
logic  [num_of_inputs-1:0] [63:0] S_7_ip;
logic  [num_of_inputs-1:0] [2:0] addr_1st_gold;
logic  [num_of_inputs-1:0] [2:0] addr_2nd_gold;
//-------------------------------------------------------------//

//-------------Inputs/Outputs to DUT instance-----------------//
`include "./params.vh"
parameter START_IN_VALID = CLK_PERIOD*7;
parameter RUN_TIME = CLK_PERIOD * (num_of_inputs+PIPE_STAGES); 


logic [63:0] query;
logic [63:0] sv_0,sv_1,sv_2,sv_3,sv_4,sv_5,sv_6,sv_7;
logic [2:0] addr_1st,addr_2nd;
logic clk,rst;
logic in_valid;
logic out_valid;
//-------------------------------------------------------------//


//---------------- Memory to hold DUT outs--------------------//
logic [num_of_inputs-1:0] [2:0] addr_1st_mem;
logic [num_of_inputs-1:0] [2:0] addr_2nd_mem;
logic [num_of_inputs-1:0] [87:0] dist_mem;
//------------------------------------------------------------//


//--------------------Instance DUT-----------------------------//
dist_sort DUT (.clk(clk),
	       .rst(rst),
	       .query(query),
	       .search_0(sv_0),
	       .search_1(sv_1),
	       .search_2(sv_2),
	       .search_3(sv_3),
	       .search_4(sv_4),
	       .search_5(sv_5),
	       .search_6(sv_6),
	       .search_7(sv_7),
	       .in_valid(in_valid),
	       .out_valid(out_valid),
	       .addr_1st(addr_1st),
	       .addr_2nd(addr_2nd)	  
);

//-------------------------------------------------------------//

//-----------------Task to get query and sv--------------------//
task get_query_and_sv();
fp1=$fopen("./inputs.txt","r");
for(i=0;i<num_of_inputs;i++) begin
	p=$fscanf(fp1,"%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\t%h\n",query_ip[i], S_0_ip[i], S_1_ip[i], S_2_ip[i], S_3_ip[i], S_4_ip[i], S_5_ip[i], S_6_ip[i], S_7_ip[i]);       
end

$fclose(fp1);
endtask
//-------------------------------------------------------------//

//-----------------Task to get golden outputs------------------//
task get_golden_outputs();
fp2 = $fopen("/home/sh2663/asap7_rundir/asic-final/rtl/golden_bin.txt","r");
for(i=0;i<num_of_inputs;i++) begin
   q = $fscanf(fp2,"%b\t%b\n",addr_1st_gold[i],addr_2nd_gold[i]);   
end

$fclose(fp2);
endtask
//-------------------------------------------------------------//

//------------------Task to reset the design-------------------//
task reset_dut();
  #(CLK_PERIOD/2) rst=1;
  @(posedge clk);
    #(CLK_PERIOD/3)  rst=0;	
endtask
//-------------------------------------------------------------//

//-------------------------Clk_gen-----------------------------//
initial begin
clk   = 1'b0;
forever begin 
#(CLK_PERIOD/2)
clk = ~clk;
end
end

//------------------ Counter for giving the inputs--------------//
int count = 0;
always @(negedge clk) begin
  if(count<10)
   count++;
  else count =10;
end
//-------------------------------------------------------------//

//----------Store outs into memory for comparison--------------//
int k =0;
always@ (negedge clk) begin
 if(out_valid) begin
   if (k < num_of_inputs) begin
     addr_1st_mem[k] = addr_1st;
     addr_2nd_mem[k] = addr_2nd;
     k++;
     end // if k<num_of_inputs
  else begin
      $display("!!!!!!!!!!!!!!!!!!!!!!!!!Out Valid is high for too long. More outputs than inputs are present!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
   end//  else
   end // out_valid
end //negedge
//-------------------------------------------------------------//

//-------Task to compare results stored in mem vs golden-------//
task compare_golden_addr();
 int j;
@(negedge clk) begin
 for (j=0;j<num_of_inputs;j++) begin
   if (addr_1st_mem[j] == addr_1st_gold[j] && addr_2nd_mem[j] == addr_2nd_gold[j]) begin
    $display("Ip No:%d Passed",j);
   end
   else begin
    $display("Ip No:%d Error in query:%h Design_result:%b %b Golden_Result:%b %b",j,query_ip[j],addr_1st_mem[j],addr_2nd_mem[j],addr_1st_gold[j],addr_2nd_gold[j]);
   end
 end
end
endtask
//-------------------------------------------------------------//

//----------------------Switch valid and invalid---------------//
task init_valid();
#(START_IN_VALID)
@(negedge clk)
in_valid <= ~in_valid;
#(RUN_TIME) //After the design ends invalidate the inputs
in_valid <= ~in_valid;
endtask
//-------------------------------------------------------------//

//------------------Pass every input to DUT--------------------//
int n = 0;
always@(negedge clk) begin
if(count == 10) begin
query <= query_ip[n];
sv_0  <= S_0_ip[n];
sv_1  <= S_1_ip[n];
sv_2  <= S_2_ip[n];
sv_3  <= S_3_ip[n];
sv_4  <= S_4_ip[n];
sv_5  <= S_5_ip[n];
sv_6  <= S_6_ip[n];
sv_7  <= S_7_ip[n];
n++;
end
end
//-------------------------------------------------------------//

//------------------Initialize in_valid------------------------//
task init_inputs();
#0
in_valid = 1'b0;
endtask
//-------------------------------------------------------------//

//-----------------Initialize all the tasks--------------------//
initial begin
$display("---------Fetching Input values------------");
get_query_and_sv();
$display("---------Fetching Golden values-----------");
get_golden_outputs();
$display("---------Initializing the inputs----------");
init_inputs();
$display("---------Resetting the flops--------------");
reset_dut();
$display("---------Passing the inputs to the design---------");
init_valid(); 
$display("------Starting Comparison with golden values-----");
// Last out_valid delayed by the number of pipe stages in design
// +2 to compensate for input and output latching
#((PIPE_STAGES+2)*CLK_PERIOD) 
compare_golden_addr();
$display("----Done with comparing against golden values------");
end
//-------------------------------------------------------------//

//----------------------To Dump vpd for waveviewer-------------//
initial begin
    $vcdplusfile("wave.vpd");
    $vcdplusmemon();
    $vcdpluson(0,tb_dist_sort);
end
//-------------------------------------------------------------//

//-------------------------------------------------------------//
initial begin
#(RUN_TIME*2)
$display("!!!!!!!!!!!!!!!!!!!!!!!END OF TB!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
$finish(1);
end
//-------------------------------------------------------------//
endmodule

set_clock_latency -source -early -max -rise  -55.3885 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -54.1455 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -55.3885 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -54.1455 [get_ports {clk}] -clock clk 

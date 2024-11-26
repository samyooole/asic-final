set_clock_latency -source -early -max -rise  -30.8429 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -29.0571 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -30.8429 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -29.0571 [get_ports {clk}] -clock clk 

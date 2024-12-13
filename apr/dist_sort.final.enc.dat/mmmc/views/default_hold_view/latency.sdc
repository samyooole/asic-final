set_clock_latency -source -early -max -rise  -50.2545 [get_ports {clk}] -clock clk 
set_clock_latency -source -early -max -fall  -49.6467 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -rise  -50.2545 [get_ports {clk}] -clock clk 
set_clock_latency -source -late -max -fall  -49.6467 [get_ports {clk}] -clock clk 

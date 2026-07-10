create_clock -period 20.000 -name vclk [get_ports cin]

set_input_delay  0.000 -clock vclk [get_ports {a[*] b[*] cin}]
set_output_delay 0.000 -clock vclk [get_ports {sum_out[*] cout_out}]

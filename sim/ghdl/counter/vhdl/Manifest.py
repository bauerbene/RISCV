action = "simulation"
sim_tool = "ghdl"
sim_top = "counter_tb"

sim_post_cmd = "ghdl -r counter_testbench --stop-time=6us --vcd=counter_testbench.vcd; gtkwave counter_testbench.vcd"

modules = {
    "local": ["../../../../testbench/counter_testbench"]
}
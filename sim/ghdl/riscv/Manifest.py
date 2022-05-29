action = "simulation"
sim_tool = "ghdl"
sim_top = "riscv_tb"

sim_post_cmd = "ghdl -r riscv_tb --stop-time=6us --vcd=riscv_tb.vcd; gtkwave riscv_tb.vcd"

modules = {
    "local": ["../../../testbench/riscv_tb"]
}

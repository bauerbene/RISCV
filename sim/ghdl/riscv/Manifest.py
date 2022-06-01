action = "simulation"
sim_tool = "ghdl"
sim_top = "riscv_tb"

sim_post_cmd = "ghdl -r riscv_tb --stop-time=6us --wave=riscv_tb.ghw; gtkwave riscv_tb.ghw"

modules = {
    "local": ["../../../testbench/riscv_tb"]
}

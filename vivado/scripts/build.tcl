set origin_dir [file normalize [file dirname [info script]]]
set project_dir [file normalize [file join $origin_dir ../riscv_project]]
set src_dir [file normalize [file join $origin_dir ../../src/modules]]
set test_dir_vhdl [file normalize [file join $origin_dir ../../src/test/vhdl]]
set test_dir_coe [file normalize [file join $origin_dir ../../src/test/coe]]
set testbench_dir [file normalize [file join $origin_dir ../../src/testbench]]

source $origin_dir/helper.tcl

set project_name "RISCV"

create_project $project_name $project_dir -part xc7z020clg484-1 -force

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "digilentinc.com:zedboard:part0:1.0" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
#set_property -name "enable_resource_estimation" -value "0" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${project_name}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "platform.board_id" -value "zedboard" -objects $obj
set_property -name "revised_directory_structure" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${project_name}.ip_user_files" -objects $obj
set_property -name "sim.ip.auto_export_scripts" -value "1" -objects $obj
set_property -name "simulator_language" -value "Mixed" -objects $obj
set_property -name "target_language" -value "VHDL" -objects $obj
set_property -name "webtalk.activehdl_export_sim" -value "31" -objects $obj
set_property -name "webtalk.modelsim_export_sim" -value "31" -objects $obj
set_property -name "webtalk.questa_export_sim" -value "31" -objects $obj
set_property -name "webtalk.riviera_export_sim" -value "31" -objects $obj
set_property -name "webtalk.vcs_export_sim" -value "31" -objects $obj
set_property -name "webtalk.xsim_export_sim" -value "31" -objects $obj
set_property -name "webtalk.xsim_launch_sim" -value "239" -objects $obj
set_property -name "xpm_libraries" -value "XPM_CDC XPM_MEMORY" -objects $obj

set srcFiles [findVhdFiles $src_dir false]
set testFiles [findVhdFiles $test_dir_vhdl true]
set testbenchFiles [findVhdFiles $testbench_dir true]

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}
# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
add_files -norecurse -fileset $obj $srcFiles
add_files -norecurse -fileset $obj $testFiles

foreach file $srcFiles {
    set file [file normalize $file]
    set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
    set_property -name "file_type" -value "VHDL" -objects $file_obj
}

foreach file $testFiles {
    set file [file normalize $file]
    set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
    set_property -name "file_type" -value "VHDL" -objects $file_obj
}


# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# add constraints here

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}
# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
add_files -norecurse -fileset $obj $testbenchFiles

foreach file $testbenchFiles {
    set file [file normalize $file]
    set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
    set_property -name "file_type" -value "VHDL" -objects $file_obj
}

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "riscv_tb" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Set 'utils_1' fileset properties
set obj [get_filesets utils_1]

set idrFlowPropertiesConstraints ""
catch {
 set idrFlowPropertiesConstraints [get_param runs.disableIDRFlowPropertyConstraints]
 set_param runs.disableIDRFlowPropertyConstraints 1
}

puts "INFO: Project created:${project_name}"
# set some other settings (auto generated from vivado)
# Create 'drc_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "drc_1" ] ] ""]} {
create_dashboard_gadget -name {drc_1} -type drc
}
set obj [get_dashboard_gadgets [ list "drc_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_drc_0" -objects $obj

# Create 'methodology_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "methodology_1" ] ] ""]} {
create_dashboard_gadget -name {methodology_1} -type methodology
}
set obj [get_dashboard_gadgets [ list "methodology_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_methodology_0" -objects $obj

# Create 'power_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "power_1" ] ] ""]} {
create_dashboard_gadget -name {power_1} -type power
}
set obj [get_dashboard_gadgets [ list "power_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_power_0" -objects $obj

# Create 'timing_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "timing_1" ] ] ""]} {
create_dashboard_gadget -name {timing_1} -type timing
}
set obj [get_dashboard_gadgets [ list "timing_1" ] ]
set_property -name "reports" -value "impl_1#impl_1_route_report_timing_summary_0" -objects $obj

# Create 'utilization_1' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_1" ] ] ""]} {
create_dashboard_gadget -name {utilization_1} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_1" ] ]
set_property -name "reports" -value "synth_1#synth_1_synth_report_utilization_0" -objects $obj
set_property -name "run.step" -value "synth_design" -objects $obj
set_property -name "run.type" -value "synthesis" -objects $obj

# Create 'utilization_2' gadget (if not found)
if {[string equal [get_dashboard_gadgets  [ list "utilization_2" ] ] ""]} {
create_dashboard_gadget -name {utilization_2} -type utilization
}
set obj [get_dashboard_gadgets [ list "utilization_2" ] ]
set_property -name "reports" -value "impl_1#impl_1_place_report_utilization_0" -objects $obj

move_dashboard_gadget -name {utilization_1} -row 0 -col 0
move_dashboard_gadget -name {power_1} -row 1 -col 0
move_dashboard_gadget -name {drc_1} -row 2 -col 0
move_dashboard_gadget -name {timing_1} -row 0 -col 1
move_dashboard_gadget -name {utilization_2} -row 1 -col 1
move_dashboard_gadget -name {methodology_1} -row 2 -col 1

source ${origin_dir}/block_diagrams/design_aes.tcl

source ${origin_dir}/block_diagrams/design_riscv.tcl

make_wrapper -files [get_files design_riscv.bd] -top -import
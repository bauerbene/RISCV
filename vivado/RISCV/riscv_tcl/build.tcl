# Check file required for this script exists
proc checkRequiredFiles { origin_dir} {
  set status true

  set files [list \
 "[file normalize "$origin_dir/../../../src/modules/FetchStage/FetchStage.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/General/RegisterSet.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/General/MUX.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/General/constants.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/General/Forward.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/ExeStage/ExecutionStage.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/DecodeStage/DecodeStage.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/MemStage/MemMux.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/MemStage/AXI_Mem_Interface.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/test06mem.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/FetchStage/Fetch.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/MemStage/MemStage.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/ExeStage/ALU.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/DecodeStage/Decode.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/test02fwd.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/JALR_test.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/General/Inc10Bit.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/General/Inverse.vhd"]"\
 "[file normalize "$origin_dir/../../../src/modules/SevenSeg/SevenSeg.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/test04jalr.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/Task26.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/SRA_SRL_Test.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/Task31.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/test03jal.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/Task27.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/Task37.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/test05branch.vhd"]"\
 "[file normalize "$origin_dir/../../../src/test/vhdl/TestLB_SB.vhd"]"\
 "[file noramlize "$origin_dir/../../../src/test/vhdl/memory_test.vhd"]"\
  ]
  foreach ifile $files {
    if { ![file isfile $ifile] } {
      puts " Could not find remote file $ifile "
      set status false
    }
  }

  return $status
}
# Set the reference directory for source file relative paths
set origin_dir [file dirname [info script]]

# Set the project name
set _xil_proj_name_ "RISCV"

variable script_file
set script_file "test_RISCV.tcl"

# Check for paths and files needed for project creation
set validate_required 0
if { $validate_required } {
  if { [checkRequiredFiles $origin_dir] } {
    puts "Tcl file $script_file is valid. All files required for project creation is accesable. "
  } else {
    puts "Tcl file $script_file is not valid. Not all files required for project creation is accesable. "
    return
  }
}

# Create project
create_project ${_xil_proj_name_} ${origin_dir}/../riscv_project/${_xil_proj_name_} -part xc7z020clg484-1 -force

# Set the directory path for the new project
set proj_dir [get_property directory [current_project]]

# Set project properties
set obj [current_project]
set_property -name "board_part" -value "digilentinc.com:zedboard:part0:1.0" -objects $obj
set_property -name "default_lib" -value "xil_defaultlib" -objects $obj
#set_property -name "enable_resource_estimation" -value "0" -objects $obj
set_property -name "enable_vhdl_2008" -value "1" -objects $obj
set_property -name "ip_cache_permissions" -value "read write" -objects $obj
set_property -name "ip_output_repo" -value "$proj_dir/${_xil_proj_name_}.cache/ip" -objects $obj
set_property -name "mem.enable_memory_map_generation" -value "1" -objects $obj
set_property -name "platform.board_id" -value "zedboard" -objects $obj
set_property -name "revised_directory_structure" -value "1" -objects $obj
set_property -name "sim.central_dir" -value "$proj_dir/${_xil_proj_name_}.ip_user_files" -objects $obj
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

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}

# Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set files [list \
 [file normalize "${origin_dir}/../../../src/modules/FetchStage/FetchStage.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/General/RegisterSet.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/General/MUX.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/General/constants.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/General/Forward.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/ExeStage/ExecutionStage.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/DecodeStage/DecodeStage.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/MemStage/MemMux.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/MemStage/AXI_Mem_Interface.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/test06mem.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/FetchStage/Fetch.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/MemStage/MemStage.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/ExeStage/ALU.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/DecodeStage/Decode.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/test02fwd.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/JALR_test.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/General/Inc10Bit.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/General/Inverse.vhd"] \
 [file normalize "${origin_dir}/../../../src/modules/SevenSeg/SevenSeg.vhd"]\
 [file normalize "${origin_dir}/../../../src/test/vhdl/test04jalr.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/Task26.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/SRA_SRL_Test.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/Task31.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/test03jal.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/Task27.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/Task37.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/test05branch.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/TestLB_SB.vhd"] \
 [file normalize "${origin_dir}/../../../src/test/vhdl/memory_test.vhd"] \
]
add_files -norecurse -fileset $obj $files

# Set 'sources_1' fileset file properties for remote files
set file "$origin_dir/../../../src/modules/FetchStage/FetchStage.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/General/RegisterSet.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/General/MUX.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/General/constants.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/General/Forward.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/ExeStage/ExecutionStage.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/DecodeStage/DecodeStage.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/MemStage/MemMux.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/MemStage/AXI_Mem_Interface.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/test06mem.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/FetchStage/Fetch.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/MemStage/MemStage.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/ExeStage/ALU.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/DecodeStage/Decode.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/test02fwd.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/JALR_test.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/General/Inc10Bit.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/General/Inverse.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/modules/SevenSeg/SevenSeg.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/test04jalr.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/Task26.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/SRA_SRL_Test.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/Task31.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/test03jal.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/Task27.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/Task37.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/test05branch.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/TestLB_SB.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj

set file "$origin_dir/../../../src/test/vhdl/memory_test.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}

# Set 'constrs_1' fileset object
set obj [get_filesets constrs_1]

# Empty (no sources present)

# Set 'constrs_1' fileset properties
set obj [get_filesets constrs_1]

# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}

# Set 'sim_1' fileset object
set obj [get_filesets sim_1]
set files [list \
 [file normalize "${origin_dir}/../../../src/testbench/riscv_tb.vhd"] \
]
add_files -norecurse -fileset $obj $files

# Set 'sim_1' fileset file properties for remote files
set file "${origin_dir}/../../../src/testbench/riscv_tb.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sim_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj


# Set 'sim_1' fileset file properties for local files
# None

# Set 'sim_1' fileset properties
set obj [get_filesets sim_1]
set_property -name "top" -value "riscv_tb" -objects $obj
set_property -name "top_auto_set" -value "0" -objects $obj

# Set 'utils_1' fileset object
set obj [get_filesets utils_1]


# Set 'utils_1' fileset properties
set obj [get_filesets utils_1]

set idrFlowPropertiesConstraints ""
catch {
 set idrFlowPropertiesConstraints [get_param runs.disableIDRFlowPropertyConstraints]
 set_param runs.disableIDRFlowPropertyConstraints 1
}

puts "INFO: Project created:${_xil_proj_name_}"
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


source ${origin_dir}/bd/riscv_bd.tcl

set design_name [get_bd_designs]
make_wrapper -files [get_files ${design_name}.bd] -top -import
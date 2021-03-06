
################################################################
# This is a generated script based on design: design_riscv
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2021.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_riscv_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# ALU, AXI_Mem_Interface, AesStageStart, AesStage, Combine, Decode, DecodeStage, ExecutionStage, Fetch, FetchStage, Forward, MUX, MemMux, MemStage, RegisterSet, SevenSeg, Split, inverse

# Please add the sources of those modules before sourcing this Tcl script.


# The design that will be created by this Tcl script contains the following 
# block design container source references:
# design_aes

# Please add the sources before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg484-1
   set_property BOARD_PART digilentinc.com:zedboard:part0:1.0 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_riscv

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:axi_bram_ctrl:4.1\
xilinx.com:ip:xlslice:1.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
ALU\
AXI_Mem_Interface\
AesStageStart\
AesStage\
Combine\
Decode\
DecodeStage\
ExecutionStage\
Fetch\
FetchStage\
Forward\
MUX\
MemMux\
MemStage\
RegisterSet\
SevenSeg\
Split\
inverse\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

##################################################################
# CHECK Block Design Container Sources
##################################################################
set bCheckSources 1
set list_bdc_active "design_aes"

array set map_bdc_missing {}
set map_bdc_missing(ACTIVE) ""
set map_bdc_missing(BDC) ""

if { $bCheckSources == 1 } {
   set list_check_srcs "\ 
design_aes \
"

   common::send_gid_msg -ssname BD::TCL -id 2056 -severity "INFO" "Checking if the following sources for block design container exist in the project: $list_check_srcs .\n\n"

   foreach src $list_check_srcs {
      if { [can_resolve_reference $src] == 0 } {
         if { [lsearch $list_bdc_active $src] != -1 } {
            set map_bdc_missing(ACTIVE) "$map_bdc_missing(ACTIVE) $src"
         } else {
            set map_bdc_missing(BDC) "$map_bdc_missing(BDC) $src"
         }
      }
   }

   if { [llength $map_bdc_missing(ACTIVE)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2057 -severity "ERROR" "The following source(s) of Active variants are not found in the project: $map_bdc_missing(ACTIVE)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
      set bCheckIPsPassed 0
   }
   if { [llength $map_bdc_missing(BDC)] > 0 } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2059 -severity "WARNING" "The following source(s) of variants are not found in the project: $map_bdc_missing(BDC)" }
      common::send_gid_msg -ssname BD::TCL -id 2060 -severity "INFO" "Please add source files for the missing source(s) above."
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set BTNL [ create_bd_port -dir I BTNL ]
  set GCLK [ create_bd_port -dir I GCLK ]
  set JA [ create_bd_port -dir O -from 3 -to 0 JA ]
  set JB [ create_bd_port -dir O -from 3 -to 0 JB ]
  set JC [ create_bd_port -dir O -from 3 -to 0 JC ]
  set JD [ create_bd_port -dir O -from 3 -to 0 JD ]

  # Create instance: ALU, and set properties
  set block_name ALU
  set block_cell_name ALU
  if { [catch {set ALU [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ALU eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AXI_Mem_Interface_0, and set properties
  set block_name AXI_Mem_Interface
  set block_cell_name AXI_Mem_Interface_0
  if { [catch {set AXI_Mem_Interface_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AXI_Mem_Interface_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesStageStart_0, and set properties
  set block_name AesStageStart
  set block_cell_name AesStageStart_0
  if { [catch {set AesStageStart_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesStageStart_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesStage_0, and set properties
  set block_name AesStage
  set block_cell_name AesStage_0
  if { [catch {set AesStage_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesStage_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Combine_0, and set properties
  set block_name Combine
  set block_cell_name Combine_0
  if { [catch {set Combine_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Combine_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Decode, and set properties
  set block_name Decode
  set block_cell_name Decode
  if { [catch {set Decode [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Decode eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: DecodeStage, and set properties
  set block_name DecodeStage
  set block_cell_name DecodeStage
  if { [catch {set DecodeStage [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $DecodeStage eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ExecutionStage, and set properties
  set block_name ExecutionStage
  set block_cell_name ExecutionStage
  if { [catch {set ExecutionStage [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ExecutionStage eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Fetch, and set properties
  set block_name Fetch
  set block_cell_name Fetch
  if { [catch {set Fetch [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Fetch eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: FetchStage, and set properties
  set block_name FetchStage
  set block_cell_name FetchStage
  if { [catch {set FetchStage [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $FetchStage eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Forward, and set properties
  set block_name Forward
  set block_cell_name Forward
  if { [catch {set Forward [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Forward eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: IMemory, and set properties
  set IMemory [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 IMemory ]
  set_property -dict [ list \
   CONFIG.Byte_Size {9} \
   CONFIG.Coe_File {/cfs/home/b/a/bauerben/projects/github/RISCV/src/test/coe/test.coe} \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_32bit_Address {false} \
   CONFIG.Enable_B {Always_Enabled} \
   CONFIG.Load_Init_File {true} \
   CONFIG.Memory_Type {Dual_Port_ROM} \
   CONFIG.Port_A_Write_Rate {0} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
   CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
   CONFIG.Use_Byte_Write_Enable {false} \
   CONFIG.Use_RSTA_Pin {false} \
   CONFIG.Write_Depth_A {1024} \
   CONFIG.use_bram_block {Stand_Alone} \
 ] $IMemory

  # Create instance: MUX, and set properties
  set block_name MUX
  set block_cell_name MUX
  if { [catch {set MUX [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MUX eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MemMux_0, and set properties
  set block_name MemMux
  set block_cell_name MemMux_0
  if { [catch {set MemMux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MemMux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: MemStage, and set properties
  set block_name MemStage
  set block_cell_name MemStage
  if { [catch {set MemStage [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $MemStage eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: RegisterSet, and set properties
  set block_name RegisterSet
  set block_cell_name RegisterSet
  if { [catch {set RegisterSet [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $RegisterSet eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: SevenSeg_0, and set properties
  set block_name SevenSeg
  set block_cell_name SevenSeg_0
  if { [catch {set SevenSeg_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $SevenSeg_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Split_0, and set properties
  set block_name Split
  set block_cell_name Split_0
  if { [catch {set Split_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Split_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property -dict [ list \
   CONFIG.PROTOCOL {AXI4LITE} \
   CONFIG.SINGLE_PORT_BRAM {1} \
 ] $axi_bram_ctrl_0

  # Create instance: blk_mem_gen_1, and set properties
  set blk_mem_gen_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_1 ]
  set_property -dict [ list \
   CONFIG.EN_SAFETY_CKT {false} \
 ] $blk_mem_gen_1

  # Create instance: design_aes_0, and set properties
  set design_aes_0 [ create_bd_cell -type container -reference design_aes design_aes_0 ]
  set_property -dict [ list \
   CONFIG.ACTIVE_SIM_BD {design_aes.bd} \
   CONFIG.ACTIVE_SYNTH_BD {design_aes.bd} \
   CONFIG.ENABLE_DFX {0} \
   CONFIG.LIST_SIM_BD {design_aes.bd} \
   CONFIG.LIST_SYNTH_BD {design_aes.bd} \
   CONFIG.LOCK_PROPAGATE {0} \
 ] $design_aes_0

  # Create instance: inverse_0, and set properties
  set block_name inverse
  set block_cell_name inverse_0
  if { [catch {set inverse_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $inverse_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
   CONFIG.DIN_FROM {11} \
   CONFIG.DIN_TO {2} \
   CONFIG.DOUT_WIDTH {10} \
 ] $xlslice_0

  # Create interface connections
  connect_bd_intf_net -intf_net AXI_Mem_Interface_0_M_AXI [get_bd_intf_pins AXI_Mem_Interface_0/M_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_1/BRAM_PORTA]

  # Create port connections
  connect_bd_net -net ALU_0_DestRegNoO [get_bd_pins ALU/DestRegNoO] [get_bd_pins MemStage/DestRegNoI]
  connect_bd_net -net ALU_0_DestWrEnO [get_bd_pins ALU/DestWrEnO] [get_bd_pins MemStage/DestWrEnI]
  connect_bd_net -net ALU_0_JumpO [get_bd_pins ALU/JumpO] [get_bd_pins DecodeStage/ClearI] [get_bd_pins ExecutionStage/ClearI] [get_bd_pins Fetch/Jump]
  connect_bd_net -net ALU_0_JumpTargetO [get_bd_pins ALU/JumpTargetO] [get_bd_pins Fetch/JumpTarget]
  connect_bd_net -net ALU_0_X [get_bd_pins ALU/X] [get_bd_pins Forward/DestData_EX] [get_bd_pins MemStage/DestDataI] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net ALU_FunctO [get_bd_pins ALU/FunctO] [get_bd_pins MemStage/FunctI]
  connect_bd_net -net ALU_MemAccessO [get_bd_pins ALU/MemAccessO] [get_bd_pins IMemory/ena] [get_bd_pins MemStage/MemAccessI]
  connect_bd_net -net ALU_MemByteEna [get_bd_pins ALU/MemByteEna] [get_bd_pins MemStage/MemByteEna]
  connect_bd_net -net ALU_MemWrData [get_bd_pins ALU/MemWrData] [get_bd_pins MemStage/MemWrData]
  connect_bd_net -net AXI_Mem_Interface_0_DataOut [get_bd_pins AXI_Mem_Interface_0/DataOut] [get_bd_pins MemStage/RamRdData]
  connect_bd_net -net AXI_Mem_Interface_0_busy [get_bd_pins AXI_Mem_Interface_0/busy] [get_bd_pins MemStage/RamBusy]
  connect_bd_net -net AesStageStart_0_AesMemRdAccessO [get_bd_pins AesStageStart_0/AesMemRdAccessO] [get_bd_pins MemStage/AesRdEn]
  connect_bd_net -net AesStageStart_0_AesMemRdAddressO [get_bd_pins AesStageStart_0/AesMemRdAddressO] [get_bd_pins MemStage/AesRdAddress]
  connect_bd_net -net AesStageStart_0_AesWrToRamAddressO [get_bd_pins AesStageStart_0/AesWrToRamAddressO] [get_bd_pins design_aes_0/WrRamAddressI]
  connect_bd_net -net AesStageStart_0_AesWrToRamO [get_bd_pins AesStageStart_0/AesWrToRamO] [get_bd_pins design_aes_0/WrToRamI]
  connect_bd_net -net AesStageStart_0_CypherO [get_bd_pins AesStageStart_0/CypherO] [get_bd_pins design_aes_0/CypherI]
  connect_bd_net -net AesStageStart_0_DecryptO [get_bd_pins AesStageStart_0/DecryptO] [get_bd_pins design_aes_0/DecryptI]
  connect_bd_net -net AesStageStart_0_DestRegNoO [get_bd_pins AesStageStart_0/DestRegNoO] [get_bd_pins design_aes_0/DestRegNoI]
  connect_bd_net -net AesStageStart_0_EncryptO [get_bd_pins AesStageStart_0/EncryptO] [get_bd_pins design_aes_0/EncryptI]
  connect_bd_net -net AesStageStart_0_LastAddressO [get_bd_pins AesStageStart_0/LastAddressO] [get_bd_pins MemStage/AesRdLastAddressI]
  connect_bd_net -net AesStage_0_AesMemAccessO [get_bd_pins AesStage_0/AesMemAccessO] [get_bd_pins MemStage/AesWrEn]
  connect_bd_net -net AesStage_0_AesMemAddress [get_bd_pins AesStage_0/AesMemAddress] [get_bd_pins MemStage/AesWrAddress]
  connect_bd_net -net AesStage_0_AesMemWrData [get_bd_pins AesStage_0/AesMemWrData] [get_bd_pins MemStage/AesWrData]
  connect_bd_net -net AesStage_0_AesStallO [get_bd_pins AesStage_0/AesStallO] [get_bd_pins DecodeStage/AesStall] [get_bd_pins ExecutionStage/AesStall] [get_bd_pins Fetch/AesStall] [get_bd_pins MemStage/AesStall] [get_bd_pins RegisterSet/AesWr] [get_bd_pins design_aes_0/AesStall]
  connect_bd_net -net AesStage_0_CypherO [get_bd_pins AesStage_0/CypherO] [get_bd_pins Split_0/I]
  connect_bd_net -net AesStage_0_DestRegNoO [get_bd_pins AesStage_0/DestRegNoO] [get_bd_pins RegisterSet/AesDestRegNo]
  connect_bd_net -net BTNL_1 [get_bd_pins AXI_Mem_Interface_0/M_AXI_aresetn] [get_bd_pins AesStageStart_0/Reset] [get_bd_pins AesStage_0/Reset] [get_bd_pins DecodeStage/Reset] [get_bd_pins ExecutionStage/Reset] [get_bd_pins FetchStage/Reset] [get_bd_pins MemStage/Reset] [get_bd_pins RegisterSet/Reset] [get_bd_pins SevenSeg_0/Reset] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins design_aes_0/Reset] [get_bd_pins inverse_0/inv]
  connect_bd_net -net BTNL_2 [get_bd_ports BTNL] [get_bd_pins inverse_0/val]
  connect_bd_net -net Combine_0_O [get_bd_pins AesStageStart_0/CypherI] [get_bd_pins Combine_0/O]
  connect_bd_net -net DecodeStage_0_ClearO [get_bd_pins Decode/Clear] [get_bd_pins DecodeStage/ClearO]
  connect_bd_net -net DecodeStage_0_InstO [get_bd_pins Decode/Inst] [get_bd_pins DecodeStage/InstO]
  connect_bd_net -net DecodeStage_0_PCO [get_bd_pins Decode/PC] [get_bd_pins DecodeStage/PCO]
  connect_bd_net -net DecodeStage_InterlockO [get_bd_pins Decode/InterlockI] [get_bd_pins DecodeStage/InterlockO]
  connect_bd_net -net Decode_0_Aux [get_bd_pins Decode/Aux] [get_bd_pins ExecutionStage/AuxI]
  connect_bd_net -net Decode_0_DestRegNo [get_bd_pins Decode/DestRegNo] [get_bd_pins ExecutionStage/DestRegNoI]
  connect_bd_net -net Decode_0_DestWrEn [get_bd_pins Decode/DestWrEn] [get_bd_pins ExecutionStage/DestWrEnI]
  connect_bd_net -net Decode_0_Funct [get_bd_pins Decode/Funct] [get_bd_pins ExecutionStage/FunctI]
  connect_bd_net -net Decode_0_Imm [get_bd_pins Decode/Imm] [get_bd_pins ExecutionStage/ImmI]
  connect_bd_net -net Decode_0_Jump [get_bd_pins Decode/Jump] [get_bd_pins ExecutionStage/JumpI]
  connect_bd_net -net Decode_0_JumpRel [get_bd_pins Decode/JumpRel] [get_bd_pins ExecutionStage/JumpRelI]
  connect_bd_net -net Decode_0_JumpTarget [get_bd_pins Decode/JumpTarget] [get_bd_pins ExecutionStage/JumpTargetI]
  connect_bd_net -net Decode_0_PCNext [get_bd_pins Decode/PCNext] [get_bd_pins ExecutionStage/PCNextI]
  connect_bd_net -net Decode_0_SelSrc2 [get_bd_pins Decode/SelSrc2] [get_bd_pins ExecutionStage/SelSrc2I]
  connect_bd_net -net Decode_0_SrcRegNo1 [get_bd_pins AesStageStart_0/DestRegNoI] [get_bd_pins Decode/SrcRegNo1] [get_bd_pins Forward/SrcRegNo1] [get_bd_pins RegisterSet/RdRegNo1]
  connect_bd_net -net Decode_0_SrcRegNo2 [get_bd_pins Decode/SrcRegNo2] [get_bd_pins Forward/SrcRegNo2] [get_bd_pins RegisterSet/RdRegNo2]
  connect_bd_net -net Decode_AESDecrypt [get_bd_pins AesStageStart_0/DecryptI] [get_bd_pins Decode/AESDecrypt]
  connect_bd_net -net Decode_AESEncrypt [get_bd_pins AesStageStart_0/EncryptI] [get_bd_pins Decode/AESEncrypt]
  connect_bd_net -net Decode_AesRdFromRam [get_bd_pins AesStageStart_0/AesRdFromRamI] [get_bd_pins Decode/AesRdFromRam]
  connect_bd_net -net Decode_InterlockO [get_bd_pins Decode/InterlockO] [get_bd_pins DecodeStage/InterlockI] [get_bd_pins Fetch/InterlockI]
  connect_bd_net -net Decode_LoadAes [get_bd_pins Decode/LoadAes] [get_bd_pins RegisterSet/LoadAesData]
  connect_bd_net -net Decode_MemAccess [get_bd_pins Decode/MemAccess] [get_bd_pins ExecutionStage/MemAccessI]
  connect_bd_net -net Decode_MemWrEn [get_bd_pins Decode/MemWrEn] [get_bd_pins ExecutionStage/MemWrEnI]
  connect_bd_net -net Decode_RamRdAddressRegNo [get_bd_pins Decode/RamRdAddressRegNo] [get_bd_pins Forward/AesRamRdRegNo] [get_bd_pins RegisterSet/AesRdRamAddressRegNo]
  connect_bd_net -net Decode_RamWrAdressRegNo [get_bd_pins Decode/RamWrAddressRegNo] [get_bd_pins Forward/AesRamAddressRegNo] [get_bd_pins RegisterSet/AesWrRamAddressRegNo]
  connect_bd_net -net Decode_Set7Seg [get_bd_pins Decode/Set7Seg] [get_bd_pins ExecutionStage/Set7SegI]
  connect_bd_net -net Decode_WriteAesToRam [get_bd_pins AesStageStart_0/AesWrToRamI] [get_bd_pins Decode/WriteAesToRam]
  connect_bd_net -net ExecutionStage_0_AuxO [get_bd_pins ALU/Aux] [get_bd_pins ExecutionStage/AuxO]
  connect_bd_net -net ExecutionStage_0_ClearO [get_bd_pins ALU/Clear] [get_bd_pins ExecutionStage/ClearO]
  connect_bd_net -net ExecutionStage_0_DestRegNoO [get_bd_pins ALU/DestRegNoI] [get_bd_pins ExecutionStage/DestRegNoO] [get_bd_pins Forward/DestRegNo_EX]
  connect_bd_net -net ExecutionStage_0_DestWrEnO [get_bd_pins ALU/DestWrEnI] [get_bd_pins ExecutionStage/DestWrEnO] [get_bd_pins Forward/DestWrEn_EX]
  connect_bd_net -net ExecutionStage_0_FunctO [get_bd_pins ALU/Funct] [get_bd_pins ExecutionStage/FunctO]
  connect_bd_net -net ExecutionStage_0_ImmO [get_bd_pins ExecutionStage/ImmO] [get_bd_pins MUX/In1]
  connect_bd_net -net ExecutionStage_0_JumpO [get_bd_pins ALU/JumpI] [get_bd_pins ExecutionStage/JumpO]
  connect_bd_net -net ExecutionStage_0_JumpRelO [get_bd_pins ALU/JumpRel] [get_bd_pins ExecutionStage/JumpRelO]
  connect_bd_net -net ExecutionStage_0_JumpTargetO [get_bd_pins ALU/JumpTargetI] [get_bd_pins ExecutionStage/JumpTargetO]
  connect_bd_net -net ExecutionStage_0_PCNextO [get_bd_pins ALU/PCNext] [get_bd_pins ExecutionStage/PCNextO]
  connect_bd_net -net ExecutionStage_0_SelSrc2O [get_bd_pins ExecutionStage/SelSrc2O] [get_bd_pins MUX/Sel]
  connect_bd_net -net ExecutionStage_0_SrcData1O [get_bd_pins ALU/A] [get_bd_pins ExecutionStage/SrcData1O] [get_bd_pins SevenSeg_0/V]
  connect_bd_net -net ExecutionStage_0_SrcData2O [get_bd_pins ALU/SrcData2] [get_bd_pins ExecutionStage/SrcData2O] [get_bd_pins MUX/In2]
  connect_bd_net -net ExecutionStage_MemAccessO [get_bd_pins ALU/MemAccessI] [get_bd_pins ExecutionStage/MemAccessO]
  connect_bd_net -net ExecutionStage_MemWrEnO [get_bd_pins ALU/MemWrEn] [get_bd_pins ExecutionStage/MemWrEnO]
  connect_bd_net -net ExecutionStage_Set7SegO [get_bd_pins ExecutionStage/Set7SegO] [get_bd_pins SevenSeg_0/Set]
  connect_bd_net -net FetchStage_0_PCO [get_bd_pins Fetch/PCI] [get_bd_pins FetchStage/PCO]
  connect_bd_net -net Fetch_0_PC [get_bd_pins DecodeStage/PCI] [get_bd_pins Fetch/PC]
  connect_bd_net -net Fetch_0_PCNext [get_bd_pins Fetch/PCNext] [get_bd_pins FetchStage/PCI]
  connect_bd_net -net Fetch_ImemAddr [get_bd_pins Fetch/ImemAddr] [get_bd_pins IMemory/addrb]
  connect_bd_net -net Forward_0_FwdData1 [get_bd_pins ExecutionStage/SrcData1I] [get_bd_pins Forward/FwdData1]
  connect_bd_net -net Forward_0_FwdData2 [get_bd_pins ExecutionStage/SrcData2I] [get_bd_pins Forward/FwdData2]
  connect_bd_net -net Forward_AesData1O [get_bd_pins Combine_0/In1] [get_bd_pins Forward/AesData1O]
  connect_bd_net -net Forward_AesData2O [get_bd_pins Combine_0/In2] [get_bd_pins Forward/AesData2O]
  connect_bd_net -net Forward_AesData3O [get_bd_pins Combine_0/In3] [get_bd_pins Forward/AesData3O]
  connect_bd_net -net Forward_AesData4O [get_bd_pins Combine_0/In4] [get_bd_pins Forward/AesData4O]
  connect_bd_net -net Forward_AesRdRamAddressO [get_bd_pins AesStageStart_0/AesRdRamAddressI] [get_bd_pins Forward/AesRdRamAddressO]
  connect_bd_net -net Forward_AesWrRamAddressO [get_bd_pins AesStageStart_0/AesWrRamAddressI] [get_bd_pins Forward/AesWrRamAddressO]
  connect_bd_net -net GCLK_1 [get_bd_ports GCLK] [get_bd_pins AXI_Mem_Interface_0/M_AXI_aclk] [get_bd_pins AesStageStart_0/Clock] [get_bd_pins AesStage_0/Clock] [get_bd_pins DecodeStage/Clock] [get_bd_pins ExecutionStage/Clock] [get_bd_pins FetchStage/Clock] [get_bd_pins IMemory/clka] [get_bd_pins IMemory/clkb] [get_bd_pins MemStage/Clock] [get_bd_pins RegisterSet/Clock] [get_bd_pins SevenSeg_0/Clock] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk] [get_bd_pins design_aes_0/Clock]
  connect_bd_net -net IMemory_douta [get_bd_pins IMemory/douta] [get_bd_pins MemMux_0/ROMDataIn]
  connect_bd_net -net IMemory_doutb [get_bd_pins DecodeStage/InstI] [get_bd_pins IMemory/doutb]
  connect_bd_net -net MUX_0_O [get_bd_pins ALU/B] [get_bd_pins MUX/O]
  connect_bd_net -net MemMux_0_WrData [get_bd_pins Forward/DestData_MEM] [get_bd_pins MemMux_0/WrData] [get_bd_pins RegisterSet/WrData]
  connect_bd_net -net MemStage_0_DestRegNoO [get_bd_pins Forward/DestRegNo_MEM] [get_bd_pins MemStage/DestRegNoO] [get_bd_pins RegisterSet/WrRegNo]
  connect_bd_net -net MemStage_0_DestWrEnO [get_bd_pins Forward/DestWrEn_MEM] [get_bd_pins MemStage/DestWrEnO] [get_bd_pins RegisterSet/WrEn]
  connect_bd_net -net MemStage_AesDataFromRamEn [get_bd_pins AesStageStart_0/AesDataFromRamEn] [get_bd_pins MemStage/AesDataFromRamEn]
  connect_bd_net -net MemStage_AesLastAddressO [get_bd_pins AesStageStart_0/LastAddressI] [get_bd_pins MemStage/AesLastAddressO]
  connect_bd_net -net MemStage_AesRdData [get_bd_pins AesStageStart_0/AesDataFromRam] [get_bd_pins MemStage/AesRdData]
  connect_bd_net -net MemStage_DestDataO [get_bd_pins MemMux_0/ALUDataIn] [get_bd_pins MemStage/DestDataO]
  connect_bd_net -net MemStage_FunctO [get_bd_pins MemMux_0/FunctI] [get_bd_pins MemStage/FunctO]
  connect_bd_net -net MemStage_MemAccessO [get_bd_pins MemMux_0/Sel] [get_bd_pins MemStage/MemAccessO]
  connect_bd_net -net MemStage_MemRdData [get_bd_pins MemMux_0/MemoryDataIn] [get_bd_pins MemStage/MemRdData]
  connect_bd_net -net MemStage_RamAddress [get_bd_pins AXI_Mem_Interface_0/Address] [get_bd_pins MemStage/RamAddress]
  connect_bd_net -net MemStage_RamByteEna [get_bd_pins AXI_Mem_Interface_0/WrByteEna] [get_bd_pins MemStage/RamByteEna]
  connect_bd_net -net MemStage_RamReadEn [get_bd_pins AXI_Mem_Interface_0/ReadEn] [get_bd_pins MemStage/RamReadEn]
  connect_bd_net -net MemStage_RamWrData [get_bd_pins AXI_Mem_Interface_0/DataIn] [get_bd_pins MemStage/RamWrData]
  connect_bd_net -net MemStage_RamWriteEn [get_bd_pins AXI_Mem_Interface_0/WriteEn] [get_bd_pins MemStage/RamWriteEn]
  connect_bd_net -net MemStage_StallO [get_bd_pins AesStageStart_0/Stall] [get_bd_pins AesStage_0/Stall] [get_bd_pins DecodeStage/Stall] [get_bd_pins ExecutionStage/Stall] [get_bd_pins Fetch/Stall] [get_bd_pins MemStage/StallI] [get_bd_pins MemStage/StallO] [get_bd_pins RegisterSet/Stall]
  connect_bd_net -net RegisterSet_0_RdData1 [get_bd_pins Forward/SrcData1] [get_bd_pins RegisterSet/RdData1]
  connect_bd_net -net RegisterSet_0_RdData2 [get_bd_pins Forward/SrcData2] [get_bd_pins RegisterSet/RdData2]
  connect_bd_net -net RegisterSet_AesData1 [get_bd_pins Forward/AesData1] [get_bd_pins RegisterSet/AesData1]
  connect_bd_net -net RegisterSet_AesData2 [get_bd_pins Forward/AesData2] [get_bd_pins RegisterSet/AesData2]
  connect_bd_net -net RegisterSet_AesData3 [get_bd_pins Forward/AesData3] [get_bd_pins RegisterSet/AesData3]
  connect_bd_net -net RegisterSet_AesData4 [get_bd_pins Forward/AesData4] [get_bd_pins RegisterSet/AesData4]
  connect_bd_net -net RegisterSet_AesRdRamAddress [get_bd_pins Forward/AesRdRamAddressI] [get_bd_pins RegisterSet/AesRdRamAddress]
  connect_bd_net -net RegisterSet_AesWrRamAddress [get_bd_pins Forward/AesWrRamAddressI] [get_bd_pins RegisterSet/AesWrRamAddress]
  connect_bd_net -net SevenSeg_0_Pmod0 [get_bd_ports JA] [get_bd_pins SevenSeg_0/Pmod0]
  connect_bd_net -net SevenSeg_0_Pmod1 [get_bd_ports JB] [get_bd_pins SevenSeg_0/Pmod1]
  connect_bd_net -net SevenSeg_0_Pmod2 [get_bd_ports JC] [get_bd_pins SevenSeg_0/Pmod2]
  connect_bd_net -net SevenSeg_0_Pmod3 [get_bd_ports JD] [get_bd_pins SevenSeg_0/Pmod3]
  connect_bd_net -net Split_0_Out1 [get_bd_pins RegisterSet/AesWrData1] [get_bd_pins Split_0/Out1]
  connect_bd_net -net Split_0_Out2 [get_bd_pins RegisterSet/AesWrData2] [get_bd_pins Split_0/Out2]
  connect_bd_net -net Split_0_Out3 [get_bd_pins RegisterSet/AesWrData3] [get_bd_pins Split_0/Out3]
  connect_bd_net -net Split_0_Out4 [get_bd_pins RegisterSet/AesWrData4] [get_bd_pins Split_0/Out4]
  connect_bd_net -net design_aes_0_CypherO [get_bd_pins AesStage_0/CypherI] [get_bd_pins design_aes_0/CypherO]
  connect_bd_net -net design_aes_0_DecryptO [get_bd_pins AesStage_0/AesDecrypt] [get_bd_pins design_aes_0/DecryptO]
  connect_bd_net -net design_aes_0_DestRegNoO [get_bd_pins AesStage_0/DestRegNoI] [get_bd_pins design_aes_0/DestRegNoO]
  connect_bd_net -net design_aes_0_EncryptO [get_bd_pins AesStage_0/AesEncrypt] [get_bd_pins design_aes_0/EncryptO]
  connect_bd_net -net design_aes_0_WrRamAddressO [get_bd_pins AesStage_0/RamWrAddress] [get_bd_pins design_aes_0/WrRamAddressO]
  connect_bd_net -net design_aes_0_WrToRamO [get_bd_pins AesStage_0/WrCypherToRam] [get_bd_pins design_aes_0/WrToRamO]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins IMemory/addra] [get_bd_pins xlslice_0/Dout]

  # Create address segments
  assign_bd_address -offset 0x00000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces AXI_Mem_Interface_0/M_AXI] [get_bd_addr_segs axi_bram_ctrl_0/S_AXI/Mem0] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



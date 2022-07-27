
################################################################
# This is a generated script based on design: design_aes
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
# source design_aes_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# AESKey, AesAddRoundKey, AesDecryptionFirstRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesEncryptionLastRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesMux, AesSync, AesSync, AesSync, AesSync, AesSync, AesSync, AesSync, AesSync, AesSync, AesSync, AesAddRoundKey

# Please add the sources of those modules before sourcing this Tcl script.

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
set design_name design_aes

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
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
AESKey\
AesAddRoundKey\
AesDecryptionFirstRound\
AesDecryptionRound\
AesDecryptionRound\
AesDecryptionRound\
AesDecryptionRound\
AesDecryptionRound\
AesDecryptionRound\
AesDecryptionRound\
AesDecryptionRound\
AesDecryptionRound\
AesEncryptionLastRound\
AesEncryptionRound\
AesEncryptionRound\
AesEncryptionRound\
AesEncryptionRound\
AesEncryptionRound\
AesEncryptionRound\
AesEncryptionRound\
AesEncryptionRound\
AesEncryptionRound\
AesMux\
AesSync\
AesSync\
AesSync\
AesSync\
AesSync\
AesSync\
AesSync\
AesSync\
AesSync\
AesSync\
AesAddRoundKey\
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
  set AesStall [ create_bd_port -dir I AesStall ]
  set Clock [ create_bd_port -dir I Clock ]
  set CypherI [ create_bd_port -dir I -from 127 -to 0 CypherI ]
  set CypherO [ create_bd_port -dir O -from 127 -to 0 CypherO ]
  set DecryptI [ create_bd_port -dir I DecryptI ]
  set DecryptO [ create_bd_port -dir O DecryptO ]
  set DestRegNoI [ create_bd_port -dir I -from 4 -to 0 DestRegNoI ]
  set DestRegNoO [ create_bd_port -dir O -from 4 -to 0 DestRegNoO ]
  set EncryptI [ create_bd_port -dir I EncryptI ]
  set EncryptO [ create_bd_port -dir O EncryptO ]
  set Reset [ create_bd_port -dir I Reset ]

  # Create instance: AESKey_0, and set properties
  set block_name AESKey
  set block_cell_name AESKey_0
  if { [catch {set AESKey_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AESKey_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesAddRoundKey_0, and set properties
  set block_name AesAddRoundKey
  set block_cell_name AesAddRoundKey_0
  if { [catch {set AesAddRoundKey_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesAddRoundKey_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionFirstRo_0, and set properties
  set block_name AesDecryptionFirstRound
  set block_cell_name AesDecryptionFirstRo_0
  if { [catch {set AesDecryptionFirstRo_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionFirstRo_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_0, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_0
  if { [catch {set AesDecryptionRound_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_1, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_1
  if { [catch {set AesDecryptionRound_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_2, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_2
  if { [catch {set AesDecryptionRound_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_3, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_3
  if { [catch {set AesDecryptionRound_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_4, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_4
  if { [catch {set AesDecryptionRound_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_5, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_5
  if { [catch {set AesDecryptionRound_5 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_5 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_6, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_6
  if { [catch {set AesDecryptionRound_6 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_6 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_7, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_7
  if { [catch {set AesDecryptionRound_7 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_7 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesDecryptionRound_8, and set properties
  set block_name AesDecryptionRound
  set block_cell_name AesDecryptionRound_8
  if { [catch {set AesDecryptionRound_8 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesDecryptionRound_8 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionLastRou_0, and set properties
  set block_name AesEncryptionLastRound
  set block_cell_name AesEncryptionLastRou_0
  if { [catch {set AesEncryptionLastRou_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionLastRou_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound1, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound1
  if { [catch {set AesEncryptionRound1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound2, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound2
  if { [catch {set AesEncryptionRound2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound3, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound3
  if { [catch {set AesEncryptionRound3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound4, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound4
  if { [catch {set AesEncryptionRound4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound5, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound5
  if { [catch {set AesEncryptionRound5 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound5 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound6, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound6
  if { [catch {set AesEncryptionRound6 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound6 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound7, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound7
  if { [catch {set AesEncryptionRound7 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound7 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound8, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound8
  if { [catch {set AesEncryptionRound8 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound8 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesEncryptionRound9, and set properties
  set block_name AesEncryptionRound
  set block_cell_name AesEncryptionRound9
  if { [catch {set AesEncryptionRound9 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesEncryptionRound9 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesMux_0, and set properties
  set block_name AesMux
  set block_cell_name AesMux_0
  if { [catch {set AesMux_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesMux_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_0, and set properties
  set block_name AesSync
  set block_cell_name AesSync_0
  if { [catch {set AesSync_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_1, and set properties
  set block_name AesSync
  set block_cell_name AesSync_1
  if { [catch {set AesSync_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_2, and set properties
  set block_name AesSync
  set block_cell_name AesSync_2
  if { [catch {set AesSync_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_3, and set properties
  set block_name AesSync
  set block_cell_name AesSync_3
  if { [catch {set AesSync_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_4, and set properties
  set block_name AesSync
  set block_cell_name AesSync_4
  if { [catch {set AesSync_4 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_4 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_5, and set properties
  set block_name AesSync
  set block_cell_name AesSync_5
  if { [catch {set AesSync_5 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_5 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_6, and set properties
  set block_name AesSync
  set block_cell_name AesSync_6
  if { [catch {set AesSync_6 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_6 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_7, and set properties
  set block_name AesSync
  set block_cell_name AesSync_7
  if { [catch {set AesSync_7 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_7 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_8, and set properties
  set block_name AesSync
  set block_cell_name AesSync_8
  if { [catch {set AesSync_8 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_8 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: AesSync_9, and set properties
  set block_name AesSync
  set block_cell_name AesSync_9
  if { [catch {set AesSync_9 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $AesSync_9 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: LastDecryption, and set properties
  set block_name AesAddRoundKey
  set block_cell_name LastDecryption
  if { [catch {set LastDecryption [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $LastDecryption eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create port connections
  connect_bd_net -net AESKey_0_KeyO [get_bd_pins AESKey_0/KeyO] [get_bd_pins AesAddRoundKey_0/RoundKey] [get_bd_pins LastDecryption/RoundKey]
  connect_bd_net -net AESKey_0_KeyR1 [get_bd_pins AESKey_0/KeyR1] [get_bd_pins AesDecryptionRound_8/RoundKey] [get_bd_pins AesEncryptionRound1/RoundKey]
  connect_bd_net -net AESKey_0_KeyR2 [get_bd_pins AESKey_0/KeyR2] [get_bd_pins AesDecryptionRound_7/RoundKey] [get_bd_pins AesEncryptionRound2/RoundKey]
  connect_bd_net -net AESKey_0_KeyR3 [get_bd_pins AESKey_0/KeyR3] [get_bd_pins AesDecryptionRound_6/RoundKey] [get_bd_pins AesEncryptionRound3/RoundKey]
  connect_bd_net -net AESKey_0_KeyR4 [get_bd_pins AESKey_0/KeyR4] [get_bd_pins AesDecryptionRound_5/RoundKey] [get_bd_pins AesEncryptionRound4/RoundKey]
  connect_bd_net -net AESKey_0_KeyR5 [get_bd_pins AESKey_0/KeyR5] [get_bd_pins AesDecryptionRound_4/RoundKey] [get_bd_pins AesEncryptionRound5/RoundKey]
  connect_bd_net -net AESKey_0_KeyR6 [get_bd_pins AESKey_0/KeyR6] [get_bd_pins AesDecryptionRound_3/RoundKey] [get_bd_pins AesEncryptionRound6/RoundKey]
  connect_bd_net -net AESKey_0_KeyR7 [get_bd_pins AESKey_0/KeyR7] [get_bd_pins AesDecryptionRound_2/RoundKey] [get_bd_pins AesEncryptionRound7/RoundKey]
  connect_bd_net -net AESKey_0_KeyR8 [get_bd_pins AESKey_0/KeyR8] [get_bd_pins AesDecryptionRound_1/RoundKey] [get_bd_pins AesEncryptionRound8/RoundKey]
  connect_bd_net -net AESKey_0_KeyR9 [get_bd_pins AESKey_0/KeyR9] [get_bd_pins AesDecryptionRound_0/RoundKey] [get_bd_pins AesEncryptionRound9/RoundKey]
  connect_bd_net -net AESKey_0_KeyR10 [get_bd_pins AESKey_0/KeyR10] [get_bd_pins AesDecryptionFirstRo_0/RoundKey] [get_bd_pins AesEncryptionLastRou_0/RoundKey]
  connect_bd_net -net AesAddRoundKey_0_CypherO [get_bd_pins AesAddRoundKey_0/CypherO] [get_bd_pins AesSync_0/EncryptCypherI]
  connect_bd_net -net AesDecryptionFirstRo_0_CypherO [get_bd_pins AesDecryptionFirstRo_0/CypherO] [get_bd_pins AesSync_0/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_0_CypherO [get_bd_pins AesDecryptionRound_0/CypherO] [get_bd_pins AesSync_1/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_1_CypherO [get_bd_pins AesDecryptionRound_1/CypherO] [get_bd_pins AesSync_2/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_2_CypherO [get_bd_pins AesDecryptionRound_2/CypherO] [get_bd_pins AesSync_3/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_3_CypherO [get_bd_pins AesDecryptionRound_3/CypherO] [get_bd_pins AesSync_4/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_4_CypherO [get_bd_pins AesDecryptionRound_4/CypherO] [get_bd_pins AesSync_5/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_5_CypherO [get_bd_pins AesDecryptionRound_5/CypherO] [get_bd_pins AesSync_6/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_6_CypherO [get_bd_pins AesDecryptionRound_6/CypherO] [get_bd_pins AesSync_7/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_7_CypherO [get_bd_pins AesDecryptionRound_7/CypherO] [get_bd_pins AesSync_8/DecryptCypherI]
  connect_bd_net -net AesDecryptionRound_8_CypherO [get_bd_pins AesDecryptionRound_8/CypherO] [get_bd_pins AesSync_9/DecryptCypherI]
  connect_bd_net -net AesEncryptionLastRou_0_CypherO [get_bd_pins AesEncryptionLastRou_0/CypherO] [get_bd_pins AesMux_0/EncryptedCypherI]
  connect_bd_net -net AesEncryptionRound1_CypherO [get_bd_pins AesEncryptionRound1/CypherO] [get_bd_pins AesSync_1/EncryptCypherI]
  connect_bd_net -net AesEncryptionRound2_CypherO [get_bd_pins AesEncryptionRound2/CypherO] [get_bd_pins AesSync_2/EncryptCypherI]
  connect_bd_net -net AesEncryptionRound3_CypherO [get_bd_pins AesEncryptionRound3/CypherO] [get_bd_pins AesSync_3/EncryptCypherI]
  connect_bd_net -net AesEncryptionRound4_CypherO [get_bd_pins AesEncryptionRound4/CypherO] [get_bd_pins AesSync_4/EncryptCypherI]
  connect_bd_net -net AesEncryptionRound5_CypherO [get_bd_pins AesEncryptionRound5/CypherO] [get_bd_pins AesSync_5/EncryptCypherI]
  connect_bd_net -net AesEncryptionRound6_CypherO [get_bd_pins AesEncryptionRound6/CypherO] [get_bd_pins AesSync_6/EncryptCypherI]
  connect_bd_net -net AesEncryptionRound7_CypherO [get_bd_pins AesEncryptionRound7/CypherO] [get_bd_pins AesSync_7/EncryptCypherI]
  connect_bd_net -net AesEncryptionRound8_CypherO [get_bd_pins AesEncryptionRound8/CypherO] [get_bd_pins AesSync_8/EncryptCypherI]
  connect_bd_net -net AesEncryptionRound9_CypherO [get_bd_pins AesEncryptionRound9/CypherO] [get_bd_pins AesSync_9/EncryptCypherI]
  connect_bd_net -net AesMux_0_CypherO [get_bd_ports CypherO] [get_bd_pins AesMux_0/CypherO]
  connect_bd_net -net AesStall_1 [get_bd_ports AesStall] [get_bd_pins AesSync_0/AesStall] [get_bd_pins AesSync_1/AesStall] [get_bd_pins AesSync_2/AesStall] [get_bd_pins AesSync_3/AesStall] [get_bd_pins AesSync_4/AesStall] [get_bd_pins AesSync_5/AesStall] [get_bd_pins AesSync_6/AesStall] [get_bd_pins AesSync_7/AesStall] [get_bd_pins AesSync_8/AesStall] [get_bd_pins AesSync_9/AesStall]
  connect_bd_net -net AesSync_0_DecryptCypherO [get_bd_pins AesDecryptionRound_0/CypherI] [get_bd_pins AesSync_0/DecryptCypherO]
  connect_bd_net -net AesSync_0_DecryptO [get_bd_pins AesSync_0/DecryptO] [get_bd_pins AesSync_1/DecryptI]
  connect_bd_net -net AesSync_0_DestRegNoO [get_bd_pins AesSync_0/DestRegNoO] [get_bd_pins AesSync_1/DestRegNoI]
  connect_bd_net -net AesSync_0_EncryptCypherO [get_bd_pins AesEncryptionRound1/CypherI] [get_bd_pins AesSync_0/EncryptCypherO]
  connect_bd_net -net AesSync_0_EncryptO [get_bd_pins AesSync_0/EncryptO] [get_bd_pins AesSync_1/EncryptI]
  connect_bd_net -net AesSync_1_DecryptCypherO [get_bd_pins AesDecryptionRound_1/CypherI] [get_bd_pins AesSync_1/DecryptCypherO]
  connect_bd_net -net AesSync_1_DecryptO [get_bd_pins AesSync_1/DecryptO] [get_bd_pins AesSync_2/DecryptI]
  connect_bd_net -net AesSync_1_DestRegNoO [get_bd_pins AesSync_1/DestRegNoO] [get_bd_pins AesSync_2/DestRegNoI]
  connect_bd_net -net AesSync_1_EncryptCypherO [get_bd_pins AesEncryptionRound2/CypherI] [get_bd_pins AesSync_1/EncryptCypherO]
  connect_bd_net -net AesSync_1_EncryptO [get_bd_pins AesSync_1/EncryptO] [get_bd_pins AesSync_2/EncryptI]
  connect_bd_net -net AesSync_2_DecryptCypherO [get_bd_pins AesDecryptionRound_2/CypherI] [get_bd_pins AesSync_2/DecryptCypherO]
  connect_bd_net -net AesSync_2_DecryptO [get_bd_pins AesSync_2/DecryptO] [get_bd_pins AesSync_3/DecryptI]
  connect_bd_net -net AesSync_2_DestRegNoO [get_bd_pins AesSync_2/DestRegNoO] [get_bd_pins AesSync_3/DestRegNoI]
  connect_bd_net -net AesSync_2_EncryptCypherO [get_bd_pins AesEncryptionRound3/CypherI] [get_bd_pins AesSync_2/EncryptCypherO]
  connect_bd_net -net AesSync_2_EncryptO [get_bd_pins AesSync_2/EncryptO] [get_bd_pins AesSync_3/EncryptI]
  connect_bd_net -net AesSync_3_DecryptCypherO [get_bd_pins AesDecryptionRound_3/CypherI] [get_bd_pins AesSync_3/DecryptCypherO]
  connect_bd_net -net AesSync_3_DecryptO [get_bd_pins AesSync_3/DecryptO] [get_bd_pins AesSync_4/DecryptI]
  connect_bd_net -net AesSync_3_DestRegNoO [get_bd_pins AesSync_3/DestRegNoO] [get_bd_pins AesSync_4/DestRegNoI]
  connect_bd_net -net AesSync_3_EncryptCypherO [get_bd_pins AesEncryptionRound4/CypherI] [get_bd_pins AesSync_3/EncryptCypherO]
  connect_bd_net -net AesSync_3_EncryptO [get_bd_pins AesSync_3/EncryptO] [get_bd_pins AesSync_4/EncryptI]
  connect_bd_net -net AesSync_4_DecryptCypherO [get_bd_pins AesDecryptionRound_4/CypherI] [get_bd_pins AesSync_4/DecryptCypherO]
  connect_bd_net -net AesSync_4_DecryptO [get_bd_pins AesSync_4/DecryptO] [get_bd_pins AesSync_5/DecryptI]
  connect_bd_net -net AesSync_4_DestRegNoO [get_bd_pins AesSync_4/DestRegNoO] [get_bd_pins AesSync_5/DestRegNoI]
  connect_bd_net -net AesSync_4_EncryptCypherO [get_bd_pins AesEncryptionRound5/CypherI] [get_bd_pins AesSync_4/EncryptCypherO]
  connect_bd_net -net AesSync_4_EncryptO [get_bd_pins AesSync_4/EncryptO] [get_bd_pins AesSync_5/EncryptI]
  connect_bd_net -net AesSync_5_DecryptCypherO [get_bd_pins AesDecryptionRound_5/CypherI] [get_bd_pins AesSync_5/DecryptCypherO]
  connect_bd_net -net AesSync_5_DecryptO [get_bd_pins AesSync_5/DecryptO] [get_bd_pins AesSync_6/DecryptI]
  connect_bd_net -net AesSync_5_DestRegNoO [get_bd_pins AesSync_5/DestRegNoO] [get_bd_pins AesSync_6/DestRegNoI]
  connect_bd_net -net AesSync_5_EncryptCypherO [get_bd_pins AesEncryptionRound6/CypherI] [get_bd_pins AesSync_5/EncryptCypherO]
  connect_bd_net -net AesSync_5_EncryptO [get_bd_pins AesSync_5/EncryptO] [get_bd_pins AesSync_6/EncryptI]
  connect_bd_net -net AesSync_6_DecryptCypherO [get_bd_pins AesDecryptionRound_6/CypherI] [get_bd_pins AesSync_6/DecryptCypherO]
  connect_bd_net -net AesSync_6_DecryptO [get_bd_pins AesSync_6/DecryptO] [get_bd_pins AesSync_7/DecryptI]
  connect_bd_net -net AesSync_6_DestRegNoO [get_bd_pins AesSync_6/DestRegNoO] [get_bd_pins AesSync_7/DestRegNoI]
  connect_bd_net -net AesSync_6_EncryptCypherO [get_bd_pins AesEncryptionRound7/CypherI] [get_bd_pins AesSync_6/EncryptCypherO]
  connect_bd_net -net AesSync_6_EncryptO [get_bd_pins AesSync_6/EncryptO] [get_bd_pins AesSync_7/EncryptI]
  connect_bd_net -net AesSync_7_DecryptCypherO [get_bd_pins AesDecryptionRound_7/CypherI] [get_bd_pins AesSync_7/DecryptCypherO]
  connect_bd_net -net AesSync_7_DecryptO [get_bd_pins AesSync_7/DecryptO] [get_bd_pins AesSync_8/DecryptI]
  connect_bd_net -net AesSync_7_DestRegNoO [get_bd_pins AesSync_7/DestRegNoO] [get_bd_pins AesSync_8/DestRegNoI]
  connect_bd_net -net AesSync_7_EncryptCypherO [get_bd_pins AesEncryptionRound8/CypherI] [get_bd_pins AesSync_7/EncryptCypherO]
  connect_bd_net -net AesSync_7_EncryptO [get_bd_pins AesSync_7/EncryptO] [get_bd_pins AesSync_8/EncryptI]
  connect_bd_net -net AesSync_8_DecryptCypherO [get_bd_pins AesDecryptionRound_8/CypherI] [get_bd_pins AesSync_8/DecryptCypherO]
  connect_bd_net -net AesSync_8_DecryptO [get_bd_pins AesSync_8/DecryptO] [get_bd_pins AesSync_9/DecryptI]
  connect_bd_net -net AesSync_8_DestRegNoO [get_bd_pins AesSync_8/DestRegNoO] [get_bd_pins AesSync_9/DestRegNoI]
  connect_bd_net -net AesSync_8_EncryptCypherO [get_bd_pins AesEncryptionRound9/CypherI] [get_bd_pins AesSync_8/EncryptCypherO]
  connect_bd_net -net AesSync_8_EncryptO [get_bd_pins AesSync_8/EncryptO] [get_bd_pins AesSync_9/EncryptI]
  connect_bd_net -net AesSync_9_DecryptCypherO [get_bd_pins AesSync_9/DecryptCypherO] [get_bd_pins LastDecryption/CypherI]
  connect_bd_net -net AesSync_9_DecryptO [get_bd_ports DecryptO] [get_bd_pins AesMux_0/AesDecrypt] [get_bd_pins AesSync_9/DecryptO]
  connect_bd_net -net AesSync_9_DestRegNoO [get_bd_ports DestRegNoO] [get_bd_pins AesSync_9/DestRegNoO]
  connect_bd_net -net AesSync_9_EncryptCypherO [get_bd_pins AesEncryptionLastRou_0/CypherI] [get_bd_pins AesSync_9/EncryptCypherO]
  connect_bd_net -net AesSync_9_EncryptO [get_bd_ports EncryptO] [get_bd_pins AesMux_0/AesEncrypt] [get_bd_pins AesSync_9/EncryptO]
  connect_bd_net -net Clock_1 [get_bd_ports Clock] [get_bd_pins AesSync_0/Clock] [get_bd_pins AesSync_1/Clock] [get_bd_pins AesSync_2/Clock] [get_bd_pins AesSync_3/Clock] [get_bd_pins AesSync_4/Clock] [get_bd_pins AesSync_5/Clock] [get_bd_pins AesSync_6/Clock] [get_bd_pins AesSync_7/Clock] [get_bd_pins AesSync_8/Clock] [get_bd_pins AesSync_9/Clock]
  connect_bd_net -net CypherI_1 [get_bd_ports CypherI] [get_bd_pins AesAddRoundKey_0/CypherI] [get_bd_pins AesDecryptionFirstRo_0/CypherI]
  connect_bd_net -net DecryptI_1 [get_bd_ports DecryptI] [get_bd_pins AesSync_0/DecryptI]
  connect_bd_net -net DestRegNoI_1 [get_bd_ports DestRegNoI] [get_bd_pins AesSync_0/DestRegNoI]
  connect_bd_net -net EncryptI_1 [get_bd_ports EncryptI] [get_bd_pins AesSync_0/EncryptI]
  connect_bd_net -net LastDecryption_CypherO [get_bd_pins AesMux_0/DecryptedCypherI] [get_bd_pins LastDecryption/CypherO]
  connect_bd_net -net Reset_1 [get_bd_ports Reset] [get_bd_pins AesSync_0/Reset] [get_bd_pins AesSync_1/Reset] [get_bd_pins AesSync_2/Reset] [get_bd_pins AesSync_3/Reset] [get_bd_pins AesSync_4/Reset] [get_bd_pins AesSync_5/Reset] [get_bd_pins AesSync_6/Reset] [get_bd_pins AesSync_7/Reset] [get_bd_pins AesSync_8/Reset] [get_bd_pins AesSync_9/Reset]

  # Create address segments


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



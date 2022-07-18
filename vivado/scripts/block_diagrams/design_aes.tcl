
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
set scripts_vivado_version 2022.1
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
# AESKey, AesAddRoundKey, AesDecryptionFirstRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesDecryptionRound, AesEncryptionLastRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesEncryptionRound, AesAddRoundKey, ZeroPadding

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
AesAddRoundKey\
ZeroPadding\
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
  set AesDecrypt [ create_bd_port -dir I AesDecrypt ]
  set AesEncrypt [ create_bd_port -dir I AesEncrypt ]
  set ClearText [ create_bd_port -dir I -from 31 -to 0 ClearText ]
  set Decrypted [ create_bd_port -dir O -from 127 -to 0 Decrypted ]
  set Encrypted [ create_bd_port -dir O -from 127 -to 0 Encrypted ]

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
  
  # Create instance: ZeroPadding_0, and set properties
  set block_name ZeroPadding
  set block_cell_name ZeroPadding_0
  if { [catch {set ZeroPadding_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ZeroPadding_0 eq "" } {
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
  connect_bd_net -net AesAddRoundKey_0_CypherO [get_bd_pins AesAddRoundKey_0/CypherO] [get_bd_pins AesEncryptionRound1/CypherI]
  connect_bd_net -net AesDecrypt_1 [get_bd_ports AesDecrypt] [get_bd_pins AesDecryptionFirstRo_0/CypherI]
  connect_bd_net -net AesDecryptionFirstRo_0_CypherO [get_bd_pins AesDecryptionFirstRo_0/CypherO] [get_bd_pins AesDecryptionRound_0/CypherI]
  connect_bd_net -net AesDecryptionRound_0_CypherO [get_bd_pins AesDecryptionRound_0/CypherO] [get_bd_pins AesDecryptionRound_1/CypherI]
  connect_bd_net -net AesDecryptionRound_1_CypherO [get_bd_pins AesDecryptionRound_1/CypherO] [get_bd_pins AesDecryptionRound_2/CypherI]
  connect_bd_net -net AesDecryptionRound_2_CypherO [get_bd_pins AesDecryptionRound_2/CypherO] [get_bd_pins AesDecryptionRound_3/CypherI]
  connect_bd_net -net AesDecryptionRound_3_CypherO [get_bd_pins AesDecryptionRound_3/CypherO] [get_bd_pins AesDecryptionRound_4/CypherI]
  connect_bd_net -net AesDecryptionRound_4_CypherO [get_bd_pins AesDecryptionRound_4/CypherO] [get_bd_pins AesDecryptionRound_5/CypherI]
  connect_bd_net -net AesDecryptionRound_5_CypherO [get_bd_pins AesDecryptionRound_5/CypherO] [get_bd_pins AesDecryptionRound_6/CypherI]
  connect_bd_net -net AesDecryptionRound_6_CypherO [get_bd_pins AesDecryptionRound_6/CypherO] [get_bd_pins AesDecryptionRound_7/CypherI]
  connect_bd_net -net AesDecryptionRound_7_CypherO [get_bd_pins AesDecryptionRound_7/CypherO] [get_bd_pins AesDecryptionRound_8/CypherI]
  connect_bd_net -net AesDecryptionRound_8_CypherO [get_bd_pins AesDecryptionRound_8/CypherO] [get_bd_pins LastDecryption/CypherI]
  connect_bd_net -net AesEncrypt_1 [get_bd_ports AesEncrypt] [get_bd_pins AesAddRoundKey_0/CypherI]
  connect_bd_net -net AesEncryptionLastRou_0_CypherO [get_bd_ports Encrypted] [get_bd_pins AesEncryptionLastRou_0/CypherO]
  connect_bd_net -net AesEncryptionRound9_CypherO [get_bd_pins AesEncryptionLastRou_0/CypherI] [get_bd_pins AesEncryptionRound9/CypherO]
  connect_bd_net -net AesEncryptionRound_1_CypherO [get_bd_pins AesEncryptionRound1/CypherO] [get_bd_pins AesEncryptionRound2/CypherI]
  connect_bd_net -net AesEncryptionRound_2_CypherO [get_bd_pins AesEncryptionRound2/CypherO] [get_bd_pins AesEncryptionRound3/CypherI]
  connect_bd_net -net AesEncryptionRound_3_CypherO [get_bd_pins AesEncryptionRound3/CypherO] [get_bd_pins AesEncryptionRound4/CypherI]
  connect_bd_net -net AesEncryptionRound_4_CypherO [get_bd_pins AesEncryptionRound4/CypherO] [get_bd_pins AesEncryptionRound5/CypherI]
  connect_bd_net -net AesEncryptionRound_5_CypherO [get_bd_pins AesEncryptionRound5/CypherO] [get_bd_pins AesEncryptionRound6/CypherI]
  connect_bd_net -net AesEncryptionRound_6_CypherO [get_bd_pins AesEncryptionRound6/CypherO] [get_bd_pins AesEncryptionRound7/CypherI]
  connect_bd_net -net AesEncryptionRound_7_CypherO [get_bd_pins AesEncryptionRound7/CypherO] [get_bd_pins AesEncryptionRound8/CypherI]
  connect_bd_net -net AesEncryptionRound_8_CypherO [get_bd_pins AesEncryptionRound8/CypherO] [get_bd_pins AesEncryptionRound9/CypherI]
  connect_bd_net -net ClearText_1 [get_bd_ports ClearText] [get_bd_pins ZeroPadding_0/DataI]
  connect_bd_net -net LastDecryption_CypherO [get_bd_ports Decrypted] [get_bd_pins LastDecryption/CypherO]

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



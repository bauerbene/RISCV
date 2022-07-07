# Adding new vhdl source files to Vivado Project

1. Create and implement the vhdl code in the src directory
2. add the following lines to the build.tcl

in the set files area (starting at line 5) and in the source_1 area (starting at line 97) add
```
 "[file normalize "$origin_dir/../../../src/path/to/new/file/new_file.vhd"]"\

```

3. add file properties 

```
set file "$origin_dir/../../../src/path/to/new/file/new_file.vhd"
set file [file normalize $file]
set file_obj [get_files -of_objects [get_filesets sources_1] [list "*$file"]]
set_property -name "file_type" -value "VHDL" -objects $file_obj
```

# Running on a different computer
1. in the config of the IMemory moduel in riscv_bd.tcl change the path of the .coe file to the absolute path on the curren computer

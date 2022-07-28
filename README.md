# Infos zur Abgabe

Das Vivado Project befindet sich in ${worspaceFolder}/vivado/riscv_project/RISCV.xpr

Da die RISCV Pipeline nicht auf dem Board funktioniert, gibt es nur eine Simulation. Für die Simulation gibt es eine gespeicherte Waveform "final.wcfg", welche sich im Projekt befindet. Dabei sind die relevanten Register sowie alle Aes Stufen zu sehen, damit man das pipelining des AesModuls gut nachverfolgen kann.

Das Simulierte Programm befindet sich in ${workspaceFolder}/src/test/coe/final_with_correct_nops.coe bzw. die zugehörige assembler datei in ${workspaceFolder}/src/test/assembler/final_with_correct_nops.S

Die Abgabe ist auf dem Branch temp (aktuell ausgecheckter Branch). Fall Ansätze für die in der Doku erwähnten *store encrypted* bzw. *load decrypted* interessant sein sollten, befinden diese sich auf dem master branch.


# Notes for Development

The complete Project is available on [github](https://github.com/bauerbene/RISCV)
The complete vivado project can be build with TCL Scripts. The build Script is located in ${workspaceFolder}/vivado/scripts/build.tcl

Some hints to work with this Configuration:

Build the vivado Project:
1. modify the /vivado/scripts/block_diagrams/design_riscv.tcl
   - set the absolute path of the .coe file to the correct path on your computer
2. Start Vivado and open the tcl console
3. source the /vivado/scripts/build.tcl script. This will automatically build the vivado project

Editing the block designs:\
After Editing one of the block designs you have to export the new design manually: 
1. open the modified block design in vivado
2. go to File -> Export -> Export Block Diagram
3. Select /vivado/scripts/block_diagrams/<name_of_the_block_design>.tcl as destination and safe

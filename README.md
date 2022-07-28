# Infos zur Abgabe

Das Vivado Project befindet sich in ${worspaceFolder}/vivado/riscv_project/RISCV.xpr

Da die RISCV Pipeline nicht auf dem Board funktioniert, gibt es nur eine Simulation. Für die Simulation gibt es eine gespeicherte Waveform "final.wcfg", welche sich im Projekt befindet. Dabei sind die relevanten Register, sowie alle Aes Stufen damit man das pipelining des AesModuls gut nachverfolgen kann.

Das Simulierte Programm befindet sich in ${workspaceFolder}/src/test/coe/final_with_correct_nops.coe bzw. die zugehörige assembler datei in ${workspaceFolder}/src/test/assembler/final_with_correct_nops.S

Die Abgabe ist auf dem Branch temp. Fall Ansätze für die in der Doku erwähnten *store encrypted* bzw *load decrypted* interessant sein sollten, befinden diese sich auf dem master branch
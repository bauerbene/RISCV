# Dokumentation: Aes Erweiterung für die RISCV-Pipeline

Nur aes 128

## Umsetzung
### Das Aes Block Diagram

Das Aes Modul wurde als eigenes Block Diagram umgesetzt. Im folgenden werden die einzelnen Komponenten des Block-Diagramms kurz erläutert.

- AESKey-Modul
    - Diese Modul gibt den fixen Schlüssel zurück, welcher für die Ver- und Entschlüsselung benutzt wird. 
    - Desweiteren werden auch die im vorraus berechneten Rundenschlüssel für jeder Runde ausgegeben.

- AesAddRoundKey
    - Dieser Block wird sowohl für die Verschlüsselung (als ersten Schritt), als auch für die Entschlüsselung (als letzten Schritt) benutzt und entspricht der bekannten AddRoundKey-Operation der AES-Verschlüsselung

- AesEncryptionRoundX
    - Dieses Modul spiegelt eine einzelne Verschlüsselungsrunde im Aes-Algorithmus wieder. Die Verschlüsselungsrunde besteht aus folgenden 4 Funktionen
        - SubBytes 
        - 


- interface des Aes Moduls
- Aes start und end stage zur einbindung in die Riscv pipeline

## befehle

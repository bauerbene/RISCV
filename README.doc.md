# Dokumentation: Aes Erweiterung für die RISCV-Pipeline

In diesem Projekte wurde die RISCV Pipeline um ein Aes Modul erweitert.

Die Erweiterung beschränkt sich dabei auf AES-128 Ver- und Entschlüsselung
## Umsetzung

---
### Das Aes Block Diagram

---

>Das Aes Modul wurde als eigenes Block Diagram umgesetzt. Im folgenden werden die einzelnen Komponenten des Block-Diagramms kurz erläutert.

- *AESKey*
    - Diese Modul gibt den fixen Schlüssel zurück, welcher für die Ver- und Entschlüsselung benutzt wird. 
    - Da der AES-Schlüssel fix im Modul ist, und die einzelnen Rundenschlüssel die für jede Ver- und Entschlüsselte Runde benötigt werden nur von diesem Schlüssel abhängen, wurde der Algorithmus zur Schlüsselexpansion (welcher die einzelnen Rundenschlüssel generiert) nicht implementiert. Das AESKey Modul gibt also auch die fixen (im vorraus berechneten Rundenschlüssel zurück).

- *AesAddRoundKey*
    - Dieser Block wird sowohl für die Verschlüsselung (als ersten Schritt), als auch für die Entschlüsselung (als letzten Schritt) benutzt und entspricht der bekannten AddRoundKey-Operation der AES-Verschlüsselung
    - In der Praxis handelt es sich um Eine XOR-Operation der aktuellen Cypher und dem zugehörigen Rundenschlüssel

- *AesEncryptionRound*
    - Dieses Modul spiegelt eine einzelne Verschlüsselungsrunde im Aes-Algorithmus wieder. Die Verschlüsselungsrunde besteht aus folgenden 4 Funktionen
        - SubBytes 
        - ShiftRows
        - MixColumns
        - AddRoundKey
    - Die einzelnen Funktionen die in dem Modul benutzt werden sind im *AesEncryptionOperations* Package, bzw. im *AesGeneralOperations* Package implementiert.

- *AedEncryptionLastRound*
  - Enspricht dem Module *AesEncryptionRound* bis auf die fehlende MixColumns Operation. Und spiegelt damit die letzte Verschlüsselungsrunde des AES-Algorithmus wieder

- *AesDecryptionRound*
  - Implementiert die inversen zu *AesEncryptionRound*, d.h. es besteht aus den Methoden 
    - AddRoundKey
    - InvMixColumns
    - InvShiftRows
    - InvSubBytes
  - Die Methoden sin im *AesDecryptionOperations* Package, bzw im *AesGeneralOperations* Package implementiert

- *AesDecryptionFirstRound*
  - Enspricht der inversen *AesEncryptionLastRound*

Das AesModul Rundenweise gepipelined. Es dauert also 10 Takte bis nach dem Start einer Ver- oder Entschlüsselung das Ergebnis zur Verfügung steht.

---
---
### Einbindung in die RISCV Pipeline
---
Das Aes Modul ist neben der Execution-Stage in die RISCV-Pipeline integriert. Eine davorgeschatelte *AesStageStart* sorgt dafür, dass alle benötigten Signale an das AES Moduls weitergegeben wird. Eine *AesStage* hinter dem Aes Modul sorgt dann wiederum dafür, dass die Ver- bzw. Entschlüsselten Daten in die entsprechenden Register (oder in den Speicher) geschrieben werden

> Note: Die Anbindung der *AesStage* an den Speicher wurde leider nicht vollständig fertiggestellt.

---
---

## Befehle

Das *Decode* Modul decoded folgende zusätliche Befehle: 

```
    csrw 0x1, rs
```
Dieser Befehl verschlüsselt die Register rs, rs+1, rs+2, rs+3 (Da Aes-128) auf 128-Bit großen Daten arbeitet, werden diese hier zusammengesetzt

```
    csrw 0x2, rs
```

Dieser Befehl entschlüsselt die Register rs, rs+1, rs+2, rs+3

> Note: Bei der Programmierung ist darauf zu achten, dass beide Befehle nicht blockierend implementiert sind. Das heißt nachdem die Ver- bzw. Entschlüsselung fertiggestellt ist, wird das Ergebnis in die Register geschrieben, unabhängig davon ob sich die Register danach schon geändert haben.\
> Die Entscheidung diese Befehle nicht blockierend zu machen ist, dass so die Pipelining funktionalität des Aes-Moduls getestet werden kann.



### Angefangene Erweiterungen (bisher nur auf Branch master verfügbar und noch nicht vollständig fuktional)
```
    csrs 0x01, rs2
```
Dieser Befehl enspricht einem *store encrypted*. Er verschlüsselt den Inhalt der Register x1, x2, x3, x4 und speichert den Verschlüsselten Inhalt an der Speicheraddress die in rs2 steht

```
    csrc 0xf, x13
```
Dieser Befehl enspricht einem *load decrypted*. Er lädt 4 wörter von der Speicheradress die in x13 steht, Entschlüsselt diese und schreibt sie zurück in xf, x10, x11 und x12.

Beide Befehle werden von der Decode Stage korrekt dekodiert. Für den *store encrypted* befehl hat die *AesStage* am Ende des Aes Moduls die Logik um das Ergebnis im Ram zu speichern. Für *load decrypted übernimmt diese Logik die *AesStageStart* am Anfang des Aes Moduls

## Notes for Development

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

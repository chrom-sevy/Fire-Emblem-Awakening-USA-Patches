.3ds
.open "shared/code.bin","target/solidarity_hit_not_crit.bin",0x100000

; 0xf = hit
; 0x10 = avoid
; 0x11 = crit
; 0x12 = critical avoid
; 
; decompiled in ghidra, you get the indices above. In assembly the adresses are the same multiplied by 4

.org 0x00219ba8
    ldrd    r2,r3,[r4,#0x3c] ; load hit instead of crit

.org 0x00219bb4
    strd    r2,r3,[r4,#0x3c] ; save hit instead of crit

.close

.3ds
.open "shared/code.bin","target/super_breaker_skills.bin",0x100000

; I don't know which breaker is which, but these are the hit and avoid bonuses for all breakers

; 0.
.org 0x0021aa0c
    add     r0,r0,#250 ; hit + 250
.org 0x0021aa18
    add     r0,r0,#250 ; avoid + 250

; repeat for the rest

; 1.
.org 0x0021aa80
    add     r0,r0,#250 ; hit + 250
.org 0x0021aa8c
    add     r0,r0,#250 ; avoid + 250

; 2.
.org 0x0021aaf4
    add     r0,r0,#250 ; hit + 250
.org 0x0021ab00
    add     r0,r0,#250 ; avoid + 250

; 3.
.org 0x0021ab68
    add     r0,r0,#250 ; hit + 250
.org 0x0021ab74
    add     r0,r0,#250 ; avoid + 250

; 4.
.org 0x0021abdc
    add     r0,r0,#250 ; hit + 250
.org 0x0021abe8
    add     r0,r0,#250 ; avoid + 250

.close

.3ds
.open "shared/code.bin","target/certain_blow.bin",0x100000

.org 0x0021a6b0
    add     r0,r0,#40 ; add 40 hit instead of 15
.org 0x0021a6b8
    add     r0,r0,#0 ; don't add any avoid

; similar stuff happens here, though I do not know what the difference is.
; maybe different phases?
.org 0x0021a96c
    add     r0,r0,#40

.org 0x0021a978
    add     r0,r0,#0

.close

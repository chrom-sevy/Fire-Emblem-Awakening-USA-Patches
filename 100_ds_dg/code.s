.3ds
.open "shared/code.bin","target/100_ds_dg.bin",0x100000

.org 0x003eef6c
    mov     r8, #100

.org 0x003eef78
attack_stance:
    // if weapon is equipped
    ldr     r0,[r4,#0x4c]
    bl      0x002f226c
    cmp     r0,#0
    nop
    blt     empty_attack_stance 
    // idk what this is for
    ldr     r0,[r4,#0x1c]
    tst     r0,#8
    beq     return
empty_attack_stance:
    mov     r0,#0
    str     r0,[r4,#0x54] ; set both to 0
return:
    ldmia   sp!,{r4-r10,pc} ; return right after setting DG and DS to 0

.close

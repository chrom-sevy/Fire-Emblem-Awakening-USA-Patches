.3ds
.open "shared/code.bin","target/attack_stance_awakening.bin",0x100000

.definelabel after_get_pair_up_bonuses,0x0027d440

.org after_get_pair_up_bonuses
    b       extend
.org 0x003eef6c
    mov     r0,#0
    str     r0,[pair_up_state] ; set dual strike data to false by default
    ; get skill function
    ldr     r0,[r4,#0]
    ldr     r1,[r4,#10]
    mov     r2,#3
    bl      0x0027d340 ; skill stat actually doesn't get used after this. In this function the pair up pair_up_state can get set to true
    ldr     r0,[pair_up_state] ; get pair up pair_up_state
    cmp     r0,#1
    beq     guard_stance;true
    b       attack_stance;false

guard_stance:
    mov     r8,#20 ; dual guard starts at 20
    // check for dual guard+ 
    mov     r1,#0x1
    ldrh    r0,[r7,#0x14]
    add     r2,r4,#0x8a
    ldrb    r2,[r2,r0,asr #0x3]
    and     r0,r0,#0x7
    tst     r2,r1,lsl r0
    beq     base_guard_stance
    add     r8,r8,#10 ; +10 dual guard chance if true
base_guard_stance:
    mov     r0,#0
    str     r0,[r4,#0x54] ; set dual strike to 0
    str     r8,[r4,#0x58] ; set dual guard
    b       return
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
    beq     normal_attack_stance
    b       empty_attack_stance
normal_attack_stance:
    mov     r0,#0
    str     r0,[r4,#0x58] ; dual guard 0
    mov     r0,#100
    str     r0,[r4,#0x54] ; dual strike 100
    b       return
empty_attack_stance:
    mov     r0,#0
    str     r0,[r4,#0x58] ; set both to 0
    str     r0,[r4,#0x58]
    b       return
return:
    ldmia   sp!,{r4-r10,pc}

extend:
    str     r0,[sp,#0x0] ; original instruction
    //r0,r1 are free to use
    mov     r0,#1
    str     r0,[pair_up_state] ; set
    b       after_get_pair_up_bonuses + 4 ; jump back
pair_up_state: .word 0
.close
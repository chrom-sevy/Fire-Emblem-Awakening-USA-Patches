.3ds
.open "shared/code.bin","target/1_bonus_per_20.bin",0x100000

; r3 is the bonus
; r0 is current stat
; r1 ??? is some kind of constant i think
.org 0x002b2d08
    mov     r1,r0, asr #3 ; devide by 8 instead of 4. This essentially doubles the required points for a bonus.
.org 0x002b2cf4
    cmp     r0,#60 ; set bonus to 3 if stats are bigger than 60
.close

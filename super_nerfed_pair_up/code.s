.3ds
.open "shared/code.bin","target/super_nerfed_pair_up.bin",0x100000

.org 0x003eef78
    ldmia   sp!,{r4-r10,pc} ; return right after setting DG and DS to 0

.org 0x002b2cf8
    mov     r3,#0 ; scaling bonus is 0
    b       0x002b2d10 ; always skip bonus for every 10th point in any given stat
.org 0x002b2d38
    mov     r3,#0 ; set class-bonus to 0--this is before defender bonuses are added
.close

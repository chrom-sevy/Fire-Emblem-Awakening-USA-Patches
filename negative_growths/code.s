.3ds
.open "shared/code.bin","target/negative_growths.bin",0x100000

.org 0x002cf004
    sublt r5,r5,#1
.org 0x002cf05c
    sublt r5,r5,#1
.close

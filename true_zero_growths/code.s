.3ds
.open "shared/code.bin","target/true_zero_growth.bin",0x100000

.org 0x002cefd4
    b 0x002cf01c

.org 0x002cf030
    b .+52

.close
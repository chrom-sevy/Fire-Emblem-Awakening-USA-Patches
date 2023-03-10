.3ds
.open "shared/code.bin","target/detgrowth.bin",0x100000

.org 0x002cef88
; .region 0x2e433c - 0x2e4230
;.if readu64("shared/code.bin", orga()) != 0xe1a07000e92d47f0
;.org 0x2cf024 - 156
;.endif
;.if readu64("shared/code.bin", orga()) != 0xe1a07000e92d47f0
;.error "did not find start of function"
;.endif

.definelabel GetGrowth,0x0027d230
.definelabel GetStat,0x002edef4
.definelabel GetCap,0x002c48f8

/*
void CalculateLevelUp (void *unit) {
	int level = unit->level@0x8d;
	unit->level@0x8d = level+1;

	for (int stat = 7; stat-- > 0; ) {
		int maxgain = GetCap(unit, stat) - GetStat(unit, stat, 0);
		int growth = GetGrowth(unit, stat) * 41;
		int oldgain = (level * growth + 2048) / 4096;
		int newgain = ((level-1) * growth + 2048) / 4096;
		int gain = newgain - oldgain;
		if (gain > maxgain)
			gain = maxgain;
		unit->u8@0x84[stat] += gain;
	}
}
; r4 = unit
; r5 = level
; r6 = stat
; r7 = maxgain
*/

	stmdb	sp!,{r4-r7,lr}
	mov	r4,r0	; unit
	;; bump up level
	ldrb	r5,[r0,#0x8d]	; unit pre-level
	add	r1,r5,#1
	strb	r1,[r0,#0x8d]	; unit post-level

	mov	r6,#7	; which stat
@@loop:
	mov	r0,r4
	mov	r1,r6
	mov	r2,#0
	bl	GetStat	; GetStat(unit, stat, 0)
	mov	r7,r0
	mov	r0,r4
	mov	r1,r6
	bl	GetCap	; GetCap(unit, stat)
	rsbs	r7,r7,r0	; maximum gain at this level
	ble	@@next

	mov	r0,r4
	mov	r1,r6
	bl	GetGrowth	; GetGrowth(unit, stat)
	mov	r1,#41
	mul	r0,r0,r1

	sub	r1,r5,#1	; level-1
	mul	r2,r0,r5	; growth * level
	mul	r1,r0,r1	; growth * (level-1)
	add	r2,r2,#2048
	add	r1,r1,#2048
	asr	r2,r2,#12	; newgain
	asr	r1,r1,#12	; oldgain

	sub	r2,r2,r1	; newgain - oldgain
	cmp	r2,r7
	movgt	r2,r7

	add	r0,r4,#0x84
	ldrb	r1,[r0,r6]
	add	r1,r1,r2
	strb	r1,[r0,r6]

@@next:
	subs	r6,#1
	bge	@@loop

	ldmia	sp!,{r4-r7,pc}
; .endregion
.close

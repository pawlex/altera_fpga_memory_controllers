pcode dump


	New pBlock

internal pblock, dbName =M
;; Starting pCode block
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2382:genFunction *{*
;; ***	genFunction  2384 curr label offset=19previous max_key=15 
S_main__main	code
_main:
; 2 exit points
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2108:genCall *{*
;; ***	genCall  2110
;; >>> gen.c:2207:genCall
_00140_DS_:
	.line	67; "./main.c"	io_counter();
	PAGESEL	_io_counter
;; >>> gen.c:2215:genCall
	CALL	_io_counter
;; >>> gen.c:2223:genCall
	PAGESEL	$
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2820:genGoto *{*
;; >>> gen.c:2822:genGoto
;; ***	popGetLabel  key=2, label offset 38
	GOTO	_00140_DS_
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2570:genEndFunction *{*
;; ***	genEndFunction  2572
	.line	71; "./main.c"	}
	RETURN	
; exit point of _main
;;	popGetExternal 990 added symbol __sdcc_gsinit_startup
;;	popGetExternal 1008 added extern __sdcc_gsinit_startup

	New pBlock

code, dbName =C
;; Starting pCode block
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2382:genFunction *{*
;; ***	genFunction  2384 curr label offset=10previous max_key=5 
S_main__io_counter	code
_io_counter:
; 2 exit points
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7159:genAssign *{*
;; ***	genAssign  7160
;;	708 register type nRegs=2
;; 	line = 7169 result AOP_REG=r0x1049, size=2, left -=-, size=0, right AOP_LIT=0x00, size=2
;; ***	genAssign  7253
;; >>> gen.c:7265:genAssign
;;	1126 rIdx = r0x1049 
	.line	40; "./main.c"	for(uint16_t i=0;i<MAXVAL;i=i+STRIDE)
	CLRF	r0x1004
;; ***	genAssign  7253
;; >>> gen.c:7265:genAssign
;;	1126 rIdx = r0x104A 
	CLRF	r0x1005
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7353:genCast *{*
;; ***	genCast  7354
;;	708 register type nRegs=2
;;	708 register type nRegs=2
;; 	line = 7362 result AOP_REG=r0x104B, size=2, left -=-, size=0, right AOP_REG=r0x1049, size=2
;; ***	genCast  7504
;; >>> gen.c:7528:genCast
;;	1126 rIdx = r0x1049 
_00122_DS_:
	MOVF	r0x1004,W
;; >>> gen.c:7529:genCast
;;	1126 rIdx = r0x104B 
	MOVWF	r0x1006
;; >>> gen.c:7528:genCast
;;	1126 rIdx = r0x104A 
	MOVF	r0x1005,W
;; >>> gen.c:7529:genCast
;;	1126 rIdx = r0x104C 
	MOVWF	r0x1007
;;; gen.c:2358:resultRemat *{*
;;; gen.c:3652:genCmpLt *{*
;; ***	genCmpLt  3653
;;	708 register type nRegs=2
;;; gen.c:3354:genCmp *{*
;;unsigned compare: left < lit(0xFF=255), size=2
;; >>> gen.c:3325:pic14_mov2w_regOrLit
	MOVLW	0x00
;; >>> gen.c:3492:genCmp
;;	1126 rIdx = r0x104C 
	SUBWF	r0x1007,W
;; >>> gen.c:3537:genCmp
	BTFSS	STATUS,2
;; >>> gen.c:3545:genCmp
;; ***	popGetLabel  key=15, label offset 19
	GOTO	_00134_DS_
;; >>> gen.c:3325:pic14_mov2w_regOrLit
	MOVLW	0xff
;; >>> gen.c:3549:genCmp
;;	1126 rIdx = r0x104B 
	SUBWF	r0x1006,W
;;; gen.c:3297:genSkipc *{*
;; >>> gen.c:3302:genSkipc
_00134_DS_:
	BTFSC	STATUS,0
;; >>> gen.c:3306:genSkipc
;; ***	popGetLabel  key=1, label offset 19
	GOTO	_00120_DS_
;;genSkipc:3307: created from rifx:0x7ffea4f7f8d0
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7353:genCast *{*
;; ***	genCast  7354
;;	708 register type nRegs=2
;;	708 register type nRegs=1
;; 	line = 7362 result AOP_REG=r0x104B, size=1, left -=-, size=0, right AOP_REG=r0x1049, size=2
;; ***	genCast  7504
;; >>> gen.c:7528:genCast
;;	1126 rIdx = r0x1049 
	.line	42; "./main.c"	PORTA = i & 0xff; 
	MOVF	r0x1004,W
	MOVWF	r0x1006
	MOVWF	_PORTA
;;; gen.c:2358:resultRemat *{*
;;; gen.c:5634:genGenericShift *{*
;; ***	genGenericShift  5637
;;	708 register type nRegs=2
;;	708 register type nRegs=2
;;; gen.c:5240:movLeft2Result *{*
;; ***	movLeft2Result  5241
;; >>> gen.c:5246:movLeft2Result
;;	1126 rIdx = r0x104A 
	.line	43; "./main.c"	PORTB = ((i >> 8) & 0xff);
	MOVF	r0x1005,W
;; >>> gen.c:5247:movLeft2Result
;;	1126 rIdx = r0x104C 
	MOVWF	r0x1007
;; ***	addSign  1087
;;; genarith.c:1088:addSign *{*
;; >>> genarith.c:1107:addSign
;;	1126 rIdx = r0x104D 
	CLRF	r0x1008
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7353:genCast *{*
;; ***	genCast  7354
;; ***	aopForSym 324
;;	336 sym->rname = _PORTB, size = 1
;; 	line = 7362 result AOP_DIR=_PORTB, size=1, left -=-, size=0, right AOP_REG=r0x104C, size=2
;; ***	genCast  7504
;; >>> gen.c:7528:genCast
;;	1126 rIdx = r0x104C 
	MOVF	r0x1007,W
;; >>> gen.c:7529:genCast
;;	1027
;;	1045  _PORTB   offset=0
	MOVWF	_PORTB
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7159:genAssign *{*
;; ***	genAssign  7160
;;	708 register type nRegs=1
;; ***	aopForSym 324
;;	336 sym->rname = _EEDATA, size = 1
;; 	line = 7169 result AOP_DIR=_EEDATA, size=1, left -=-, size=0, right AOP_REG=r0x104B, size=1
;; ***	genAssign  7253
;;; gen.c:1357:mov2w_op *{*
;; ***	mov2w  1395  offset=0
;; >>> gen.c:1400:mov2w
;;	1126 rIdx = r0x104B 
	.line	44; "./main.c"	EEDATA = i & 0xff;
	MOVF	r0x1006,W
;; >>> gen.c:7280:genAssign
;;	1027
;;	1045  _EEDATA   offset=0
	MOVWF	_EEDATA
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7353:genCast *{*
;; ***	genCast  7354
;;	589
;;	708 register type nRegs=2
;; 	line = 7362 result AOP_REG=r0x104B, size=2, left -=-, size=0, right AOP_REG=r0x1049, size=2
;; ***	genCast  7504
;; >>> gen.c:7528:genCast
;;	1126 rIdx = r0x1049 
	.line	40; "./main.c"	for(uint16_t i=0;i<MAXVAL;i=i+STRIDE)
	MOVF	r0x1004,W
;; >>> gen.c:7529:genCast
;;	1126 rIdx = r0x104B 
	MOVWF	r0x1006
;; >>> gen.c:7528:genCast
;;	1126 rIdx = r0x104A 
	MOVF	r0x1005,W
;; >>> gen.c:7529:genCast
;;	1126 rIdx = r0x104C 
	MOVWF	r0x1007
;;; gen.c:2358:resultRemat *{*
;; ***	genPlus  707
;;; genarith.c:708:genPlus *{*
;;	708 register type nRegs=2
;;	708 register type nRegs=2
;; 	line = 714 result AOP_REG=r0x104B, size=2, left AOP_REG=r0x104B, size=2, right AOP_LIT=0x01, size=2
;;; genarith.c:159:genPlusIncr *{*
;; ***	genPlusIncr  161
;; 	result AOP_REG, left AOP_REG, right AOP_LIT
;; 	genPlusIncr  173
;; >>> genarith.c:185:genPlusIncr
;;	1126 rIdx = r0x104B 
	INCF	r0x1006,F
;; >>> genarith.c:189:genPlusIncr
	BTFSC	STATUS,2
;; >>> genarith.c:190:genPlusIncr
;;	1126 rIdx = r0x104C 
	INCF	r0x1007,F
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7353:genCast *{*
;; ***	genCast  7354
;;	708 register type nRegs=2
;;	708 register type nRegs=2
;; 	line = 7362 result AOP_REG=r0x1049, size=2, left -=-, size=0, right AOP_REG=r0x104B, size=2
;; ***	genCast  7504
;; >>> gen.c:7528:genCast
;;	1126 rIdx = r0x104B 
	MOVF	r0x1006,W
;; >>> gen.c:7529:genCast
;;	1126 rIdx = r0x1049 
	MOVWF	r0x1004
;; >>> gen.c:7528:genCast
;;	1126 rIdx = r0x104C 
	MOVF	r0x1007,W
;; >>> gen.c:7529:genCast
;;	1126 rIdx = r0x104A 
	MOVWF	r0x1005
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2820:genGoto *{*
;; >>> gen.c:2822:genGoto
;; ***	popGetLabel  key=3, label offset 19
	GOTO	_00122_DS_
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2108:genCall *{*
;; ***	genCall  2110
;; >>> gen.c:2207:genCall
_00120_DS_:
	.line	47; "./main.c"	nopsleep();
	PAGESEL	_nopsleep
;; >>> gen.c:2215:genCall
	CALL	_nopsleep
;; >>> gen.c:2223:genCall
	PAGESEL	$
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2570:genEndFunction *{*
;; ***	genEndFunction  2572
	.line	61; "./main.c"	}
	RETURN	
; exit point of _io_counter
;;; gen.c:7677:genpic14Code *{*

	New pBlock

code, dbName =C
;; Starting pCode block
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2382:genFunction *{*
;; ***	genFunction  2384 curr label offset=4previous max_key=2 
S_main__nopsleep	code
_nopsleep:
; 2 exit points
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7159:genAssign *{*
;; ***	genAssign  7160
;;	708 register type nRegs=4
;; 	line = 7169 result AOP_REG=r0x1045, size=4, left -=-, size=0, right AOP_LIT=0x40, size=4
;; ***	genAssign  7253
;; >>> gen.c:7260:genAssign
	.line	29; "./main.c"	for(uint32_t i=1000000; i>0; i--)
	MOVLW	0x40
;; >>> gen.c:7262:genAssign
;;	1126 rIdx = r0x1045 
	MOVWF	r0x1000
;; ***	genAssign  7253
;; >>> gen.c:7260:genAssign
	MOVLW	0x42
;; >>> gen.c:7262:genAssign
;;	1126 rIdx = r0x1046 
	MOVWF	r0x1001
;; ***	genAssign  7253
;; >>> gen.c:7260:genAssign
	MOVLW	0x0f
;; >>> gen.c:7262:genAssign
;;	1126 rIdx = r0x1047 
	MOVWF	r0x1002
;; ***	genAssign  7253
;; >>> gen.c:7265:genAssign
;;	1126 rIdx = r0x1048 
	CLRF	r0x1003
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:6991:genIfx *{*
;; ***	genIfx  6992
;;	708 register type nRegs=4
;; ***	pic14_toBoolean  1515
;; ***	mov2w  1395  offset=3
;; >>> gen.c:1400:mov2w
;;	1126 rIdx = r0x1048 
_00113_DS_:
	MOVF	r0x1003,W
;; >>> gen.c:1533:pic14_toBoolean
;;	1126 rIdx = r0x1047 
	IORWF	r0x1002,W
;; >>> gen.c:1533:pic14_toBoolean
;;	1126 rIdx = r0x1046 
	IORWF	r0x1001,W
;; >>> gen.c:1533:pic14_toBoolean
;;	1126 rIdx = r0x1045 
	IORWF	r0x1000,W
;; >>> gen.c:7045:genIfx
	BTFSC	STATUS,2
;; >>> gen.c:7046:genIfx
;; ***	popGetLabel  key=5, label offset 10
	GOTO	_00115_DS_
;;; gen.c:2358:resultRemat *{*
;;; gen.c:4884:pic14_genInline *{*
;; ***	pic14_genInline  4885
	nop	
;;; gen.c:2358:resultRemat *{*
;;; gen.c:7568:genDjnz *{*
;; ***	genDjnz  7569
;;; genarith.c:1122:genMinus *{*
;; ***	genMinus  1123
;;	708 register type nRegs=4
;;	589
;; 	result AOP_REG, left AOP_REG, right AOP_LIT
;;; genarith.c:286:genAddLit *{*
;; ***	genAddLit  287
;;  add lit to long	genAddLit  458
;; >>> genarith.c:520:genAddLit
	.line	29; "./main.c"	for(uint32_t i=1000000; i>0; i--)
	MOVLW	0xff
;; >>> genarith.c:521:genAddLit
;;	1126 rIdx = r0x1045 
	ADDWF	r0x1000,F
;; >>> genarith.c:488:genAddLit
	MOVLW	0xff
;; >>> genarith.c:492:genAddLit
	BTFSS	STATUS,0
;; >>> genarith.c:493:genAddLit
;;	1126 rIdx = r0x1046 
	ADDWF	r0x1001,F
;; >>> genarith.c:488:genAddLit
	MOVLW	0xff
;; >>> genarith.c:492:genAddLit
	BTFSS	STATUS,0
;; >>> genarith.c:493:genAddLit
;;	1126 rIdx = r0x1047 
	ADDWF	r0x1002,F
;; >>> genarith.c:488:genAddLit
	MOVLW	0xff
;; >>> genarith.c:492:genAddLit
	BTFSS	STATUS,0
;; >>> genarith.c:493:genAddLit
;;	1126 rIdx = r0x1048 
	ADDWF	r0x1003,F
;; ***	addSign  1087
;;; genarith.c:1088:addSign *{*
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2820:genGoto *{*
;; >>> gen.c:2822:genGoto
;; ***	popGetLabel  key=3, label offset 10
	GOTO	_00113_DS_
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2570:genEndFunction *{*
;; ***	genEndFunction  2572
_00115_DS_:
	.line	33; "./main.c"	}
	RETURN	
; exit point of _nopsleep
;;; gen.c:7677:genpic14Code *{*

	New pBlock

code, dbName =C
;; Starting pCode block
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2382:genFunction *{*
;; ***	genFunction  2384 curr label offset=0previous max_key=0 
S_main__halt	code
_halt:
; 2 exit points
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:4884:pic14_genInline *{*
;; ***	pic14_genInline  4885
_00106_DS_:
	nop	
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2820:genGoto *{*
;; >>> gen.c:2822:genGoto
;; ***	popGetLabel  key=2, label offset 4
	GOTO	_00106_DS_
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2802:genLabel *{*
;; ***	genLabel  2805
;;; gen.c:2358:resultRemat *{*
;;; gen.c:2570:genEndFunction *{*
;; ***	genEndFunction  2572
	.line	22; "./main.c"	}
	RETURN	
; exit point of _halt
;;; gen.c:7677:genpic14Code *{*

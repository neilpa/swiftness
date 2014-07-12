; da65 V2.13.3 - (C) Copyright 2000-2009,  Ullrich von Bassewitz
; Created:    2014-07-11 16:35:22
; Input file: nestest.o
; Page:       1


        .setcpu "6502"

L0200           := $0200
L2020           := $2020
L206C           := $206C
L2D2D           := $2D2D
L414C           := $414C
L4153           := $4153
L4253           := $4253
L4344           := $4344
L4928           := $4928
L4C52           := $4C52
L4C53           := $4C53
L4F4E           := $4F4E
L5253           := $5253
L5320           := $5320
L5349           := $5349
L6241           := $6241
L6341           := $6341
L6469           := $6469
L655A           := $655A
L6574           := $6574
L6C46           := $6C46
L6C78           := $6C78
L6D49           := $6D49
L6F28           := $6F28
L6F4E           := $6F4E
L7055           := $7055
L706F           := $706F
L7242           := $7242
L7453           := $7453
L7475           := $7475
L7552           := $7552
L7572           := $7572
LC000:  brk
        jmp     LC5F5
        rts
        sei
        cld
        ldx     #$FF
        txs
LC00A:  lda     $2002
        bpl     LC00A
LC00F:  lda     $2002
        bpl     LC00F
        lda     #$00
        sta     $2000
        sta     $2001
        sta     $2005
        sta     $2005
        lda     $2002
        ldx     #$20
        stx     $2006
        ldx     #$00
        stx     $2006
        ldx     #$00
        ldy     #$0F
        lda     #$00
LC035:  sta     $2007
        dex
        bne     LC035
        dey
        bne     LC035
        lda     #$3F
        sta     $2006
        lda     #$00
        sta     $2006
        ldx     #$00
LC04A:  lda     LFF78,x
        sta     $2007
        inx
        cpx     #$20
        bne     LC04A
        lda     #$C0
        sta     $4017
        lda     #$00
        sta     $4015
        lda     #$78
        sta     $D0
        lda     #$FB
        sta     $D1
        lda     #$7F
        sta     $D3
        ldy     #$00
        sty     $2006
        .byte   $8C
        .byte   $06
LC072:  jsr     $A9
        sta     $D7
        lda     #$07
        sta     $D0
        lda     #$C3
        sta     $D1
        .byte   $20
        .byte   $A7
LC081:  .byte   $C2
LC082:  jsr     LC28D
        ldx     #$12
        jsr     LC261
        lda     $D5
        lsr     a
        lsr     a
        lsr     a
        bcs     LC0AD
        lsr     a
        bcs     LC0A0
        lsr     a
        bcs     LC0BE
        lsr     a
        bcs     LC09D
        jmp     LC081
LC09D:  jmp     LC126
LC0A0:  jsr     LC66F
        dec     $D7
        bpl     LC082
        lda     #$0D
        sta     $D7
        bne     LC082
LC0AD:  jsr     LC66F
        inc     $D7
        lda     $D7
        cmp     #$0E
        bcc     LC082
        lda     #$00
        sta     $D7
        beq     LC082
LC0BE:  jsr     LC689
        lda     $D7
        beq     LC0CB
        jsr     LC0ED
        jmp     LC081
LC0CB:  lda     #$00
        sta     $D8
        inc     $D7
LC0D1:  jsr     LC0ED
        inc     $D7
        lda     $D7
        cmp     #$0E
        bne     LC0D1
        lda     #$00
        sta     $D7
        lda     $D8
        beq     LC0E6
        lda     #$FF
LC0E6:  sta     $00
        jsr     LC1ED
        .byte   $4C
        .byte   $81
LC0ED:  cpy     #$A5
        .byte   $D7
        asl     a
        tax
        lda     LC10A,x
        sta     L0200
        lda     LC10B,x
        sta     $0201
        lda     #$C1
        pha
        lda     #$DE
        pha
        lda     #$00
        sta     $00
        .byte   $6C
        brk
LC10A:  .byte   $02
LC10B:  and     $2DC7
        .byte   $C7
        .byte   $DB
        .byte   $C7
        sta     $C8
        dec     LF8CB,x
        cmp     LCEEE
        ldx     #$CF
        .byte   $74
        cmp     ($FB),y
        .byte   $D4
        .byte   $D4
        cmp     ($4A,x)
        .byte   $DF
        clv
        .byte   $DB
        tax
LC126:  sbc     ($A9,x)
        brk
        sta     $D7
        lda     #$92
        sta     $D0
        lda     #$C4
        sta     $D1
        .byte   $20
        .byte   $A7
LC135:  .byte   $C2
LC136:  jsr     LC28D
        ldx     #$0F
        jsr     LC261
        lda     $D5
        lsr     a
        lsr     a
        lsr     a
        bcs     LC161
        lsr     a
        bcs     LC154
        lsr     a
        bcs     LC172
        lsr     a
        bcs     LC151
        jmp     LC135
LC151:  jmp     LC072
LC154:  jsr     LC66F
        dec     $D7
        bpl     LC136
        lda     #$0A
        sta     $D7
        bne     LC136
LC161:  jsr     LC66F
        inc     $D7
        lda     $D7
        cmp     #$0B
        bcc     LC136
        lda     #$00
        sta     $D7
        beq     LC136
LC172:  jsr     LC689
        lda     $D7
        beq     LC17F
        jsr     LC1A1
        jmp     LC135
LC17F:  lda     #$00
        sta     $D8
        inc     $D7
LC185:  jsr     LC1A1
        inc     $D7
        lda     $D7
        cmp     #$0B
        bne     LC185
        lda     #$00
        sta     $D7
        lda     $D8
        beq     LC19A
        lda     #$FF
LC19A:  sta     $00
        jsr     LC1ED
        .byte   $4C
        .byte   $35
LC1A1:  cmp     ($A5,x)
        .byte   $D7
        asl     a
        tax
        lda     LC1BE,x
        sta     L0200
        lda     LC1BF,x
        sta     $0201
        lda     #$C1
        pha
        lda     #$DE
        pha
        lda     #$00
        sta     $00
        .byte   $6C
        brk
LC1BE:  .byte   $02
LC1BF:  .byte   $A3
        dec     $A3
        dec     $1E
        sbc     $3D
        .byte   $E7
        .byte   $D3
        inx
        asl     $E9,x
        stx     $EB
        inc     $ED,x
        ror     $F0
        dec     $F2,x
        lsr     $F5
        lda     #$00
        sta     $00
        jsr     LD900
        jsr     LDAE0
        nop
        nop
        nop
        lda     $00
        beq     LC1E8
        sta     $D8
LC1E8:  jmp     LC1ED
        .byte   $4C
        .byte   $81
LC1ED:  cpy     #$20
        sta     $A9C2
        brk
        sta     $D3
        lda     $D7
        clc
        adc     #$04
        asl     a
        rol     $D3
        asl     a
        rol     $D3
        asl     a
        rol     $D3
        asl     a
        rol     $D3
        asl     a
        rol     $D3
        pha
        lda     $D3
        ora     #$20
        sta     $2006
        pla
        ora     #$04
        sta     $2006
        lda     $00
        beq     LC238
        cmp     #$FF
        beq     LC245
        lsr     a
        lsr     a
        lsr     a
        lsr     a
        tax
        lda     LC251,x
        sta     $2007
        lda     $00
        and     #$0F
        tax
        lda     LC251,x
        sta     $2007
        jmp     LC294
LC238:  lda     #$4F
        sta     $2007
        lda     #$4B
        sta     $2007
        jmp     LC294
LC245:  lda     #$45
        sta     $2007
        lda     #$72
        sta     $2007
        .byte   $4C
        .byte   $94
LC251:  .byte   $C2
        bmi     LC285
        .byte   $32
        .byte   $33
        .byte   $34
        and     $36,x
        .byte   $37
        sec
        and     $4241,y
        .byte   $43
        .byte   $44
        .byte   $45
LC261:  lsr     $A5
        .byte   $D7
        clc
        adc     #$04
        tay
        lda     #$84
        sta     $2000
        lda     #$20
        sta     $2006
        lda     #$02
        sta     $2006
        lda     #$20
        dey
        iny
        bne     LC27F
        lda     #$2A
LC27F:  sta     $2007
        dey
        dex
        .byte   $D0
LC285:  sbc     ($A9),y
        .byte   $80
        sta     $2000
        .byte   $4C
        .byte   $94
LC28D:  .byte   $C2
        lda     $D2
LC290:  cmp     $D2
        beq     LC290
LC294:  rts
        lda     #$00
        sta     $2005
        sta     $2005
        lda     #$00
        sta     $2006
        lda     #$00
        sta     $2006
LC2A7:  rts
        lda     #$00
        sta     $2000
        sta     $2001
        jsr     LC2ED
        lda     #$20
        sta     $2006
        ldy     #$00
        sty     $2006
LC2BD:  ldx     #$20
LC2BF:  lda     ($D0),y
        beq     LC2E3
        cmp     #$FF
        beq     LC2D4
        sta     $2007
        iny
        bne     LC2CF
        inc     $D1
LC2CF:  dex
        bne     LC2BF
        beq     LC2BD
LC2D4:  iny
        bne     LC2D9
        inc     $D1
LC2D9:  lda     #$20
        sta     $2007
        dex
        bne     LC2D9
        beq     LC2BD
LC2E3:  lda     #$80
        sta     $2000
        lda     #$0E
        sta     $2001
LC2ED:  rts
        lda     #$20
        sta     $2006
        lda     #$00
        sta     $2006
        ldx     #$1E
        lda     #$20
LC2FC:  ldy     #$20
LC2FE:  sta     $2007
        dey
        bne     LC2FE
        dex
        bne     LC2FC
        rts
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L7552
        ror     $6120
        jmp     (L206C)
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L7242
        adc     ($6E,x)
        .byte   $63
        pla
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L6C46
        adc     ($67,x)
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L6D49
        adc     $6465
        adc     #$61
        .byte   $74
        adc     $20
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L6D49
        bvs     LC3D5
        adc     #$65
        .byte   $64
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L7453
        adc     ($63,x)
        .byte   $6B
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L6341
        .byte   $63
        adc     $6D,x
        adc     $6C,x
        adc     ($74,x)
        .byte   $6F
        .byte   $72
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L4928
        ror     $6964
        .byte   $72
        adc     $63
        .byte   $74
        bit     $2958
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L655A
        .byte   $72
        .byte   $6F
        bvs     LC427
        .byte   $67
        adc     $20
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
LC3D5:  jsr     L6241
        .byte   $73
        .byte   $6F
        jmp     (L7475)
        adc     $20
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L4928
        ror     $6964
        .byte   $72
        adc     $63
        .byte   $74
        and     #$2C
        eor     $7420,y
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L6241
        .byte   $73
        .byte   $6F
        jmp     (L7475)
        adc     $2C
        eor     $7420,y
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L655A
        .byte   $72
        .byte   $6F
        bvs     LC485
        .byte   $67
        adc     $2C
LC427:  cli
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L6241
        .byte   $73
        .byte   $6F
        jmp     (L7475)
        adc     $2C
        cli
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        .byte   $FF
        .byte   $FF
        jsr     L2020
        jsr     L7055
        .byte   $2F
        .byte   $44
        .byte   $6F
        .byte   $77
        ror     $203A
        .byte   $73
        adc     $6C
        adc     $63
        .byte   $74
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $FF
        jsr     L2020
        jsr     L2020
        .byte   $53
        .byte   $74
        adc     ($72,x)
        .byte   $74
        .byte   $3A
        jsr     L7572
        ror     $7420
        adc     $73
        .byte   $74
        .byte   $FF
        jsr     L2020
        jsr     L5320
        adc     $6C
        adc     $63
        .byte   $74
        .byte   $3A
        .byte   $20
LC485:  eor     #$6E
        ror     $61,x
        jmp     (L6469)
        jsr     L706F
        .byte   $73
        and     ($FF,x)
        brk
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L7552
        ror     $6120
        jmp     (L206C)
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L4F4E
        bvc     LC4D7
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L414C
        cli
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L4153
LC4D7:  cli
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L4253
        .byte   $43
        jsr     L6574
        .byte   $73
        .byte   $74
        jsr     L6F28
        bvs     LC556
        .byte   $6F
        .byte   $64
        adc     $20
        bmi     LC53E
        .byte   $42
        pla
        and     #$FF
        jsr     L2020
        jsr     L2D2D
        jsr     L4344
        bvc     LC528
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L5349
        .byte   $42
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L4C53
LC528:  .byte   $4F
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L4C52
        eor     ($20,x)
        .byte   $74
        adc     $73
LC53E:  .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        jsr     L2D2D
        jsr     L5253
        eor     $20
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        jsr     L2020
        .byte   $20
LC556:  and     $202D
        .byte   $52
        .byte   $52
        eor     ($20,x)
        .byte   $74
        adc     $73
        .byte   $74
        .byte   $73
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        .byte   $FF
        jsr     L2020
        jsr     L7055
        .byte   $2F
        .byte   $44
        .byte   $6F
        .byte   $77
        ror     $203A
        .byte   $73
        adc     $6C
        adc     $63
        .byte   $74
        jsr     L6574
        .byte   $73
        .byte   $74
        .byte   $FF
        jsr     L2020
        jsr     L2020
        .byte   $53
        .byte   $74
        adc     ($72,x)
        .byte   $74
        .byte   $3A
        jsr     L7572
        ror     $7420
        adc     $73
        .byte   $74
        .byte   $FF
        jsr     L2020
        jsr     L5320
        adc     $6C
        adc     $63
        .byte   $74
        .byte   $3A
        jsr     L6F4E
        .byte   $72
        adc     $6C61
        jsr     L706F
        .byte   $73
        .byte   $FF
        brk
        pha
        txa
        pha
        lda     $2002
        lda     #$20
        sta     $2006
        lda     #$40
        sta     $2006
        inc     $D2
        lda     #$00
        sta     $2005
        sta     $2005
        lda     #$00
        sta     $2006
        lda     #$00
        sta     $2006
        ldx     #$09
        stx     $4016
        dex
        stx     $4016
LC5DD:  lda     $4016
        lsr     a
        rol     $D4
        dex
        bne     LC5DD
        lda     $D4
        tax
        eor     $D6
        and     $D4
        sta     $D5
        stx     $D6
        pla
        tax
        pla
        rti
LC5F5:  rti
        ldx     #$00
        stx     $00
        stx     $10
        stx     $11
        jsr     LC72D
        .byte   $20
LC602:  .byte   $DB
        .byte   $C7
        jsr     LC885
        jsr     LCBDE
        jsr     LCDF8
        jsr     LCEEE
        jsr     LCFA2
        jsr     LD174
        jsr     LD4FB
        jsr     LD900
        lda     $00
        sta     $10
        lda     #$00
        sta     $00
        jsr     LDAE0
        jsr     LDF4A
        jsr     LDBB8
        jsr     LE1AA
        jsr     LC6A3
        jsr     LE51E
        jsr     LE73D
        jsr     LE8D3
        jsr     LE916
        jsr     LEB86
        jsr     LEDF6
        jsr     LF066
        jsr     LF2D6
        lda     $00
        sta     $11
        lda     #$00
        sta     $00
        jsr     LF546
        lda     $00
        ora     $10
        ora     $11
        beq     LC66C
        jsr     LC66F
        ldx     $00
        stx     $02
        ldx     $10
        stx     $03
        jmp     LC66E
LC66C:  .byte   $20
        .byte   $89
LC66E:  .byte   $C6
LC66F:  rts
        lda     #$03
        sta     $4015
        lda     #$87
        sta     $4000
        lda     #$89
        sta     $4001
        lda     #$F0
        sta     $4002
        lda     #$00
        sta     $4003
LC689:  rts
        lda     #$02
        sta     $4015
        lda     #$3F
        sta     $4004
        lda     #$9A
        sta     $4005
        lda     #$FF
        sta     $4006
        lda     #$00
        sta     $4007
LC6A3:  rts
        ldy     #$4E
        lda     #$FF
        sta     $01
        jsr     LC6B0
        jsr     LC6B7
LC6B0:  rts
        lda     #$FF
        pha
        lda     #$AA
        .byte   $D0
LC6B7:  ora     $A9
        .byte   $34
        pha
        lda     #$55
        plp
        .byte   $04
        lda     #$44
        lda     #$64
        lda     #$EA
        nop
LC6C6:  nop
        nop
        php
        pha
        .byte   $0C
        lda     #$A9
        nop
        nop
        nop
        nop
        php
        pha
        .byte   $14
        lda     #$34
        lda     #$54
        lda     #$74
        lda     #$D4
        lda     #$F4
        lda     #$EA
        nop
        nop
        nop
        php
        pha
        .byte   $1A
        .byte   $3A
        .byte   $5A
        .byte   $7A
        .byte   $DA
        .byte   $FA
        .byte   $80
        .byte   $89
        nop
        nop
        nop
        nop
        php
        pha
        .byte   $1C
        lda     #$A9
        .byte   $3C
        lda     #$A9
        .byte   $5C
        lda     #$A9
        .byte   $7C
        lda     #$A9
        .byte   $DC
        lda     #$A9
        .byte   $FC
        lda     #$A9
        nop
        nop
        nop
        nop
        php
        pha
        ldx     #$05
LC70D:  pla
        cmp     #$55
        beq     LC71C
        cmp     #$AA
        beq     LC71C
        pla
        sty     $00
        jmp     LC728
LC71C:  pla
        and     #$CB
        cmp     #$00
        beq     LC729
        cmp     #$CB
        beq     LC729
        .byte   $84
LC728:  brk
LC729:  iny
        dex
        bne     LC70D
LC72D:  rts
        nop
        sec
        bcs     LC736
        ldx     #$01
        stx     $00
LC736:  nop
        clc
        bcs     LC73D
        jmp     LC740
LC73D:  ldx     #$02
        .byte   $86
LC740:  brk
        nop
        sec
        bcc     LC748
        jmp     LC74B
LC748:  ldx     #$03
        .byte   $86
LC74B:  brk
        nop
        clc
        bcc     LC754
        ldx     #$04
        stx     $00
LC754:  nop
        lda     #$00
        beq     LC75D
        ldx     #$05
        stx     $00
LC75D:  nop
        lda     #$40
        beq     LC765
        jmp     LC768
LC765:  ldx     #$06
        .byte   $86
LC768:  brk
        nop
        lda     #$40
        bne     LC772
        ldx     #$07
        stx     $00
LC772:  nop
        lda     #$00
        bne     LC77A
        jmp     LC77D
LC77A:  ldx     #$08
        .byte   $86
LC77D:  brk
        nop
        lda     #$FF
        sta     $01
        bit     $01
        bvs     LC78B
        ldx     #$09
        stx     $00
LC78B:  nop
        bit     $01
        bvc     LC793
        jmp     LC796
LC793:  ldx     #$0A
        .byte   $86
LC796:  brk
        nop
        lda     #$00
        sta     $01
        bit     $01
        bvc     LC7A4
        ldx     #$0B
        stx     $00
LC7A4:  nop
        bit     $01
        bvs     LC7AC
        jmp     LC7AF
LC7AC:  ldx     #$0C
        .byte   $86
LC7AF:  brk
        nop
        lda     #$00
        bpl     LC7B9
        ldx     #$0D
        stx     $00
LC7B9:  nop
        lda     #$80
        bpl     LC7C1
        jmp     LC7D9
LC7C1:  ldx     #$0E
        stx     $00
        nop
        lda     #$80
        bmi     LC7CE
        ldx     #$0F
        stx     $00
LC7CE:  nop
        lda     #$00
        bmi     LC7D6
        jmp     LC7D9
LC7D6:  ldx     #$10
        .byte   $86
LC7D9:  brk
        nop
LC7DB:  rts
        nop
        lda     #$FF
        sta     $01
        bit     $01
        lda     #$00
        sec
        sei
        sed
        php
        pla
        and     #$EF
        cmp     #$6F
        beq     LC7F4
        ldx     #$11
        stx     $00
LC7F4:  nop
        lda     #$40
        sta     $01
        bit     $01
        cld
        lda     #$10
        clc
        php
        pla
        and     #$EF
        cmp     #$64
        beq     LC80B
        ldx     #$12
        stx     $00
LC80B:  nop
        lda     #$80
        sta     $01
        bit     $01
        sed
        lda     #$00
        sec
        php
        pla
        and     #$EF
        cmp     #$2F
        beq     LC822
        ldx     #$13
        stx     $00
LC822:  nop
        lda     #$FF
        pha
        plp
        bne     LC832
        bpl     LC832
        bvc     LC832
        bcc     LC832
        jmp     LC835
LC832:  ldx     #$14
        .byte   $86
LC835:  brk
        nop
        lda     #$04
        pha
        plp
        beq     LC846
        bmi     LC846
        bvs     LC846
        bcs     LC846
        jmp     LC849
LC846:  ldx     #$15
        .byte   $86
LC849:  brk
        nop
        sed
        lda     #$FF
        sta     $01
        bit     $01
        clc
        lda     #$00
        pha
        lda     #$FF
        pla
        bne     LC864
        bmi     LC864
        bvc     LC864
        bcs     LC864
        jmp     LC867
LC864:  ldx     #$16
        .byte   $86
LC867:  brk
        nop
        lda     #$00
        sta     $01
        bit     $01
        sec
        lda     #$FF
        pha
        lda     #$00
        pla
        beq     LC881
        bpl     LC881
        bvs     LC881
        bcc     LC881
        jmp     LC884
LC881:  ldx     #$17
        .byte   $86
LC884:  brk
LC885:  rts
        nop
        clc
        lda     #$FF
        sta     $01
        bit     $01
        lda     #$55
        ora     #$AA
        bcs     LC89F
        bpl     LC89F
        cmp     #$FF
        bne     LC89F
        bvc     LC89F
        jmp     LC8A2
LC89F:  ldx     #$18
        .byte   $86
LC8A2:  brk
        nop
        sec
        clv
        lda     #$00
        ora     #$00
        bne     LC8B5
        bvs     LC8B5
        bcc     LC8B5
        bmi     LC8B5
        jmp     LC8B8
LC8B5:  ldx     #$19
        .byte   $86
LC8B8:  brk
        nop
        clc
        bit     $01
        lda     #$55
        and     #$AA
        bne     LC8CC
        bvc     LC8CC
        bcs     LC8CC
        bmi     LC8CC
        jmp     LC8CF
LC8CC:  ldx     #$1A
        .byte   $86
LC8CF:  brk
        nop
        sec
        clv
        lda     #$F8
        and     #$EF
        bcc     LC8E4
        bpl     LC8E4
        cmp     #$E8
        bne     LC8E4
        bvs     LC8E4
        jmp     LC8E7
LC8E4:  ldx     #$1B
        .byte   $86
LC8E7:  brk
        nop
        clc
        bit     $01
        lda     #$5F
        eor     #$AA
        bcs     LC8FD
        bpl     LC8FD
        cmp     #$F5
        bne     LC8FD
        bvc     LC8FD
        jmp     LC900
LC8FD:  ldx     #$1C
        .byte   $86
LC900:  brk
        nop
        sec
        clv
        lda     #$70
        eor     #$70
        bne     LC913
        bvs     LC913
        bcc     LC913
        bmi     LC913
        jmp     LC916
LC913:  ldx     #$1D
        .byte   $86
LC916:  brk
        nop
        clc
        bit     $01
        lda     #$00
        adc     #$69
        bmi     LC92C
        bcs     LC92C
        cmp     #$69
        bne     LC92C
        bvs     LC92C
        jmp     LC92F
LC92C:  ldx     #$1E
        .byte   $86
LC92F:  brk
        nop
        sec
        sed
        bit     $01
        lda     #$01
        adc     #$69
        bmi     LC946
        bcs     LC946
        cmp     #$6B
        bne     LC946
        bvs     LC946
        jmp     LC949
LC946:  ldx     #$1F
        .byte   $86
LC949:  brk
        nop
        cld
        sec
        clv
        lda     #$7F
        adc     #$7F
        bpl     LC95F
        bcs     LC95F
        cmp     #$FF
        bne     LC95F
        bvc     LC95F
        jmp     LC962
LC95F:  ldx     #$20
        .byte   $86
LC962:  brk
        nop
        clc
        bit     $01
        lda     #$7F
        adc     #$80
        bpl     LC978
        bcs     LC978
        cmp     #$FF
        bne     LC978
        bvs     LC978
        jmp     LC97B
LC978:  ldx     #$21
        .byte   $86
LC97B:  brk
        nop
        sec
        clv
        lda     #$7F
        adc     #$80
        bne     LC98E
        bmi     LC98E
        bvs     LC98E
        bcc     LC98E
        jmp     LC991
LC98E:  ldx     #$22
        .byte   $86
LC991:  brk
        nop
        sec
        clv
        lda     #$9F
        beq     LC9A2
        bpl     LC9A2
        bvs     LC9A2
        bcc     LC9A2
        jmp     LC9A5
LC9A2:  ldx     #$23
        .byte   $86
LC9A5:  brk
        nop
        clc
        bit     $01
        lda     #$00
        bne     LC9B7
        bmi     LC9B7
        bvc     LC9B7
        bcs     LC9B7
        jmp     LC9BA
LC9B7:  ldx     #$23
        .byte   $86
LC9BA:  brk
        nop
        bit     $01
        lda     #$40
        cmp     #$40
        bmi     LC9CD
        bcc     LC9CD
        bne     LC9CD
        bvc     LC9CD
        jmp     LC9D0
LC9CD:  ldx     #$24
        .byte   $86
LC9D0:  brk
        nop
        clv
        cmp     #$3F
        beq     LC9E0
        bmi     LC9E0
        bcc     LC9E0
        bvs     LC9E0
        jmp     LC9E3
LC9E0:  ldx     #$25
        .byte   $86
LC9E3:  brk
        nop
        cmp     #$41
        beq     LC9F0
        bpl     LC9F0
        bpl     LC9F0
        jmp     LC9F3
LC9F0:  ldx     #$26
        .byte   $86
LC9F3:  brk
        nop
        lda     #$80
        cmp     #$00
        beq     LCA02
        bpl     LCA02
        bcc     LCA02
        jmp     LCA05
LCA02:  ldx     #$27
        .byte   $86
LCA05:  brk
        nop
        cmp     #$80
        bne     LCA12
        bmi     LCA12
        bcc     LCA12
        jmp     LCA15
LCA12:  ldx     #$28
        .byte   $86
LCA15:  brk
        nop
        cmp     #$81
        bcs     LCA22
        beq     LCA22
        bpl     LCA22
        jmp     LCA25
LCA22:  ldx     #$29
        .byte   $86
LCA25:  brk
        nop
        cmp     #$7F
        bcc     LCA32
        beq     LCA32
        bmi     LCA32
        jmp     LCA35
LCA32:  ldx     #$2A
        .byte   $86
LCA35:  brk
        nop
        bit     $01
        ldy     #$40
        cpy     #$40
        bne     LCA48
        bmi     LCA48
        bcc     LCA48
        bvc     LCA48
        jmp     LCA4B
LCA48:  ldx     #$2B
        .byte   $86
LCA4B:  brk
        nop
        clv
        cpy     #$3F
        beq     LCA5B
        bmi     LCA5B
        bcc     LCA5B
        bvs     LCA5B
        jmp     LCA5E
LCA5B:  ldx     #$2C
        .byte   $86
LCA5E:  brk
        nop
        cpy     #$41
        beq     LCA6B
        bpl     LCA6B
        bpl     LCA6B
        jmp     LCA6E
LCA6B:  ldx     #$2D
        .byte   $86
LCA6E:  brk
        nop
        ldy     #$80
        cpy     #$00
        beq     LCA7D
        bpl     LCA7D
        bcc     LCA7D
        jmp     LCA80
LCA7D:  ldx     #$2E
        .byte   $86
LCA80:  brk
        nop
        cpy     #$80
        bne     LCA8D
        bmi     LCA8D
        bcc     LCA8D
        jmp     LCA90
LCA8D:  ldx     #$2F
        .byte   $86
LCA90:  brk
        nop
        cpy     #$81
        bcs     LCA9D
        beq     LCA9D
        bpl     LCA9D
        jmp     LCAA0
LCA9D:  ldx     #$30
        .byte   $86
LCAA0:  brk
        nop
        cpy     #$7F
        bcc     LCAAD
        beq     LCAAD
        bmi     LCAAD
        jmp     LCAB0
LCAAD:  ldx     #$31
        .byte   $86
LCAB0:  brk
        nop
        bit     $01
        ldx     #$40
        cpx     #$40
        bne     LCAC3
        bmi     LCAC3
        bcc     LCAC3
        bvc     LCAC3
        jmp     LCAC6
LCAC3:  lda     #$32
        .byte   $85
LCAC6:  brk
        nop
        clv
        cpx     #$3F
        beq     LCAD6
        bmi     LCAD6
        bcc     LCAD6
        bvs     LCAD6
        jmp     LCAD9
LCAD6:  lda     #$33
        .byte   $85
LCAD9:  brk
        nop
        cpx     #$41
        beq     LCAE6
        bpl     LCAE6
        bpl     LCAE6
        jmp     LCAE9
LCAE6:  lda     #$34
        .byte   $85
LCAE9:  brk
        nop
        ldx     #$80
        cpx     #$00
        beq     LCAF8
        bpl     LCAF8
        bcc     LCAF8
        jmp     LCAFB
LCAF8:  lda     #$35
        .byte   $85
LCAFB:  brk
        nop
        cpx     #$80
        bne     LCB08
        bmi     LCB08
        bcc     LCB08
        jmp     LCB0B
LCB08:  lda     #$36
        .byte   $85
LCB0B:  brk
        nop
        cpx     #$81
        bcs     LCB18
        beq     LCB18
        bpl     LCB18
        jmp     LCB1B
LCB18:  lda     #$37
        .byte   $85
LCB1B:  brk
        nop
        cpx     #$7F
        bcc     LCB28
        beq     LCB28
        bmi     LCB28
        jmp     LCB2B
LCB28:  lda     #$38
        .byte   $85
LCB2B:  brk
        nop
        sec
        clv
        ldx     #$9F
        beq     LCB3C
        bpl     LCB3C
        bvs     LCB3C
        bcc     LCB3C
        jmp     LCB3F
LCB3C:  ldx     #$39
        .byte   $86
LCB3F:  brk
        nop
        clc
        bit     $01
        ldx     #$00
        bne     LCB51
        bmi     LCB51
        bvc     LCB51
        bcs     LCB51
        jmp     LCB54
LCB51:  ldx     #$3A
        .byte   $86
LCB54:  brk
        nop
        sec
        clv
        ldy     #$9F
        beq     LCB65
        bpl     LCB65
        bvs     LCB65
        bcc     LCB65
        jmp     LCB68
LCB65:  ldx     #$3B
        .byte   $86
LCB68:  brk
        nop
        clc
        bit     $01
        ldy     #$00
        bne     LCB7A
        bmi     LCB7A
        bvc     LCB7A
        bcs     LCB7A
        jmp     LCB7D
LCB7A:  ldx     #$3C
        .byte   $86
LCB7D:  brk
        nop
        lda     #$55
        ldx     #$AA
        ldy     #$33
        cmp     #$55
        bne     LCBAC
        cpx     #$AA
        bne     LCBAC
        cpy     #$33
        bne     LCBAC
        cmp     #$55
        bne     LCBAC
        cpx     #$AA
        bne     LCBAC
        cpy     #$33
        bne     LCBAC
        cmp     #$56
        beq     LCBAC
        cpx     #$AB
        beq     LCBAC
        cpy     #$34
        beq     LCBAC
        jmp     LCBAF
LCBAC:  ldx     #$3D
        .byte   $86
LCBAF:  brk
        ldy     #$71
        jsr     LF931
        sbc     #$40
        jsr     LF937
        iny
        jsr     LF947
        sbc     #$3F
        jsr     LF94C
        iny
        jsr     LF95C
        sbc     #$41
        jsr     LF962
        iny
        jsr     LF972
        sbc     #$00
        jsr     LF976
        iny
        jsr     LF980
        sbc     #$7F
        jsr     LF984
LCBDE:  rts
        nop
        lda     #$FF
        sta     $01
        lda     #$44
        ldx     #$55
        ldy     #$66
        inx
        dey
        cpx     #$56
        bne     LCC11
        cpy     #$65
        bne     LCC11
        inx
        inx
        dey
        dey
        cpx     #$58
        bne     LCC11
        cpy     #$63
        bne     LCC11
        dex
        iny
        cpx     #$57
        bne     LCC11
        cpy     #$64
        bne     LCC11
        cmp     #$44
        bne     LCC11
        jmp     LCC14
LCC11:  ldx     #$3E
        .byte   $86
LCC14:  brk
        nop
        sec
        ldx     #$69
        lda     #$96
        bit     $01
        ldy     #$FF
        iny
        bne     LCC5F
        bmi     LCC5F
        bcc     LCC5F
        bvc     LCC5F
        cpy     #$00
        bne     LCC5F
        iny
        beq     LCC5F
        bmi     LCC5F
        bcc     LCC5F
        bvc     LCC5F
        clc
        clv
        ldy     #$00
        dey
        beq     LCC5F
        bpl     LCC5F
        bcs     LCC5F
        bvs     LCC5F
        cpy     #$FF
        bne     LCC5F
        clc
        dey
        beq     LCC5F
        bpl     LCC5F
        bcs     LCC5F
        bvs     LCC5F
        cpy     #$FE
        bne     LCC5F
        cmp     #$96
        bne     LCC5F
        cpx     #$69
        bne     LCC5F
        jmp     LCC62
LCC5F:  ldx     #$3F
        .byte   $86
LCC62:  brk
        nop
        sec
        ldy     #$69
        lda     #$96
        bit     $01
        ldx     #$FF
        inx
        bne     LCCAD
        bmi     LCCAD
        bcc     LCCAD
        bvc     LCCAD
        cpx     #$00
        bne     LCCAD
        inx
        beq     LCCAD
        bmi     LCCAD
        bcc     LCCAD
        bvc     LCCAD
        clc
        clv
        ldx     #$00
        dex
        beq     LCCAD
        bpl     LCCAD
        bcs     LCCAD
        bvs     LCCAD
        cpx     #$FF
        bne     LCCAD
        clc
        dex
        beq     LCCAD
        bpl     LCCAD
        bcs     LCCAD
        bvs     LCCAD
        cpx     #$FE
        bne     LCCAD
        cmp     #$96
        bne     LCCAD
        cpy     #$69
        bne     LCCAD
        jmp     LCCB0
LCCAD:  ldx     #$40
        .byte   $86
LCCB0:  brk
        nop
        lda     #$85
        ldx     #$34
        ldy     #$99
        clc
        bit     $01
        tay
        beq     LCCEC
        bcs     LCCEC
        bvc     LCCEC
        bpl     LCCEC
        cmp     #$85
        bne     LCCEC
        cpx     #$34
        bne     LCCEC
        cpy     #$85
        bne     LCCEC
        lda     #$00
        sec
        clv
        tay
        bne     LCCEC
        bcc     LCCEC
        bvs     LCCEC
        bmi     LCCEC
        cmp     #$00
        bne     LCCEC
        cpx     #$34
        bne     LCCEC
        cpy     #$00
        bne     LCCEC
        jmp     LCCEF
LCCEC:  ldx     #$41
        .byte   $86
LCCEF:  brk
        nop
        lda     #$85
        ldx     #$34
        ldy     #$99
        clc
        bit     $01
        tax
        beq     LCD2B
        bcs     LCD2B
        bvc     LCD2B
        bpl     LCD2B
        cmp     #$85
        bne     LCD2B
        cpx     #$85
        bne     LCD2B
        cpy     #$99
        bne     LCD2B
        lda     #$00
        sec
        clv
        tax
        bne     LCD2B
        bcc     LCD2B
        bvs     LCD2B
        bmi     LCD2B
        cmp     #$00
        bne     LCD2B
        cpx     #$00
        bne     LCD2B
        cpy     #$99
        bne     LCD2B
        jmp     LCD2E
LCD2B:  ldx     #$42
        .byte   $86
LCD2E:  brk
        nop
        lda     #$85
        ldx     #$34
        ldy     #$99
        clc
        bit     $01
        tya
        beq     LCD6A
        bcs     LCD6A
        bvc     LCD6A
        bpl     LCD6A
        cmp     #$99
        bne     LCD6A
        cpx     #$34
        bne     LCD6A
        cpy     #$99
        bne     LCD6A
        ldy     #$00
        sec
        clv
        tya
        bne     LCD6A
        bcc     LCD6A
        bvs     LCD6A
        bmi     LCD6A
        cmp     #$00
        bne     LCD6A
        cpx     #$34
        bne     LCD6A
        cpy     #$00
        bne     LCD6A
        jmp     LCD6D
LCD6A:  ldx     #$43
        .byte   $86
LCD6D:  brk
        nop
        lda     #$85
        ldx     #$34
        ldy     #$99
        clc
        bit     $01
        txa
        beq     LCDA9
        bcs     LCDA9
        bvc     LCDA9
        bmi     LCDA9
        cmp     #$34
        bne     LCDA9
        cpx     #$34
        bne     LCDA9
        cpy     #$99
        bne     LCDA9
        ldx     #$00
        sec
        clv
        txa
        bne     LCDA9
        bcc     LCDA9
        bvs     LCDA9
        bmi     LCDA9
        cmp     #$00
        bne     LCDA9
        cpx     #$00
        bne     LCDA9
        cpy     #$99
        bne     LCDA9
        jmp     LCDAC
LCDA9:  ldx     #$44
        .byte   $86
LCDAC:  brk
        nop
        tsx
        stx     $07FF
        ldy     #$33
        ldx     #$69
        lda     #$84
        clc
        bit     $01
        txs
        beq     LCDF0
        bpl     LCDF0
        bcs     LCDF0
        bvc     LCDF0
        cmp     #$84
        bne     LCDF0
        cpx     #$69
        bne     LCDF0
        cpy     #$33
        bne     LCDF0
        ldy     #$01
        lda     #$04
        sec
        clv
        ldx     #$00
        tsx
        beq     LCDF0
        bmi     LCDF0
        bcc     LCDF0
        bvs     LCDF0
        cpx     #$69
        bne     LCDF0
        cmp     #$04
        bne     LCDF0
        cpy     #$01
        bne     LCDF0
        jmp     LCDF3
LCDF0:  ldx     #$45
        .byte   $86
LCDF3:  brk
        ldx     $07FF
        txs
LCDF8:  rts
        lda     #$FF
        sta     $01
        tsx
        stx     $07FF
        nop
        ldx     #$80
        txs
        lda     #$33
        pha
        lda     #$69
        pha
        tsx
        cpx     #$7E
        bne     LCE30
        pla
        cmp     #$69
        bne     LCE30
        pla
        cmp     #$33
        bne     LCE30
        tsx
        cpx     #$80
        bne     LCE30
        lda     $0180
        cmp     #$33
        bne     LCE30
        lda     $017F
        cmp     #$69
        bne     LCE30
        jmp     LCE33
LCE30:  ldx     #$46
        .byte   $86
LCE33:  brk
        nop
        ldx     #$80
        txs
        jsr     LCE3D
        .byte   $4C
        .byte   $5B
LCE3D:  dec     LE0BA
        ror     $19D0,x
        pla
        pla
        tsx
        cpx     #$80
        bne     LCE5C
        lda     #$00
        .byte   $20
        .byte   $4E
LCE4E:  dec     $C968
        eor     $08D0
        pla
        cmp     #$CE
        bne     LCE5C
        jmp     LCE5F
LCE5C:  ldx     #$47
        .byte   $86
LCE5F:  brk
        nop
        lda     #$CE
        pha
        lda     #$66
LCE66:  pha
        rts
        ldx     #$77
        ldy     #$69
        clc
        bit     $01
        lda     #$83
        jsr     LCE66
        beq     LCE9A
        bpl     LCE9A
        bcs     LCE9A
        bvc     LCE9A
        cmp     #$83
        bne     LCE9A
        cpy     #$69
        bne     LCE9A
        cpx     #$77
        bne     LCE9A
        sec
        clv
        lda     #$00
        jsr     LCE66
        bne     LCE9A
        bmi     LCE9A
        bcc     LCE9A
        bvs     LCE9A
        jmp     LCE9D
LCE9A:  ldx     #$48
        .byte   $86
LCE9D:  brk
        nop
        lda     #$CE
        pha
        lda     #$AE
        pha
        lda     #$65
        pha
        lda     #$55
        ldy     #$88
        ldx     #$99
        rti
        bmi     LCEE6
        bvc     LCEE6
        beq     LCEE6
        bcc     LCEE6
        cmp     #$55
        bne     LCEE6
        cpy     #$88
        bne     LCEE6
        cpx     #$99
        bne     LCEE6
        lda     #$CE
        pha
        lda     #$CE
        pha
        lda     #$87
        pha
        lda     #$55
        rti
        bpl     LCEE6
        bvs     LCEE6
        bne     LCEE6
        bcc     LCEE6
        cmp     #$55
        bne     LCEE6
        cpy     #$88
        bne     LCEE6
        cpx     #$99
        bne     LCEE6
        jmp     LCEE9
LCEE6:  ldx     #$49
        .byte   $86
LCEE9:  brk
        ldx     $07FF
        txs
LCEEE:  rts
        ldx     #$55
        ldy     #$69
        lda     #$FF
        sta     $01
        nop
        bit     $01
        sec
        lda     #$01
        lsr     a
        bcc     LCF1D
        bne     LCF1D
        bmi     LCF1D
        bvc     LCF1D
        cmp     #$00
        bne     LCF1D
        clv
        lda     #$AA
        lsr     a
        bcs     LCF1D
        beq     LCF1D
        bmi     LCF1D
        bvs     LCF1D
        cmp     #$55
        bne     LCF1D
        jmp     LCF20
LCF1D:  ldx     #$4A
        .byte   $86
LCF20:  brk
        nop
        bit     $01
        sec
        lda     #$80
        asl     a
        bcc     LCF48
        bne     LCF48
        bmi     LCF48
        bvc     LCF48
        cmp     #$00
        bne     LCF48
        clv
        sec
        lda     #$55
        asl     a
        bcs     LCF48
        beq     LCF48
        bpl     LCF48
        bvs     LCF48
        cmp     #$AA
        bne     LCF48
        jmp     LCF4B
LCF48:  ldx     #$4B
        .byte   $86
LCF4B:  brk
        nop
        bit     $01
        sec
        lda     #$01
        ror     a
        bcc     LCF73
        beq     LCF73
        bpl     LCF73
        bvc     LCF73
        cmp     #$80
        bne     LCF73
        clv
        clc
        lda     #$55
        ror     a
        bcc     LCF73
        beq     LCF73
        bmi     LCF73
        bvs     LCF73
        cmp     #$2A
        bne     LCF73
        jmp     LCF76
LCF73:  ldx     #$4C
        .byte   $86
LCF76:  brk
        nop
        bit     $01
        sec
        lda     #$80
        rol     a
        bcc     LCF9E
        beq     LCF9E
        bmi     LCF9E
        bvc     LCF9E
        cmp     #$01
        bne     LCF9E
        clv
        clc
        lda     #$55
        rol     a
        bcs     LCF9E
        beq     LCF9E
        bpl     LCF9E
        bvs     LCF9E
        cmp     #$AA
        bne     LCF9E
        jmp     LCFA1
LCF9E:  ldx     #$4D
        .byte   $86
LCFA1:  brk
LCFA2:  rts
        lda     $00
        sta     $07FF
        lda     #$00
        sta     $80
        lda     #$02
        sta     $81
        lda     #$FF
        sta     $01
        lda     #$00
        sta     $82
        lda     #$03
        sta     $83
        sta     $84
        lda     #$00
        sta     $FF
        lda     #$04
        sta     $00
        lda     #$5A
        sta     L0200
        lda     #$5B
        sta     $0300
        lda     #$5C
        sta     $0303
        lda     #$5D
        sta     $0400
        ldx     #$00
        lda     ($80,x)
        cmp     #$5A
        bne     LD001
        inx
        inx
        lda     ($80,x)
        cmp     #$5B
        bne     LD001
        inx
        lda     ($80,x)
        cmp     #$5C
        bne     LD001
        ldx     #$00
        lda     ($FF,x)
        cmp     #$5D
        bne     LD001
        ldx     #$81
        lda     ($FF,x)
        cmp     #$5A
        beq     LD006
LD001:  lda     #$58
        sta     $07FF
LD006:  lda     #$AA
        ldx     #$00
        sta     ($80,x)
        inx
        inx
        lda     #$AB
        sta     ($80,x)
        inx
        lda     #$AC
        sta     ($80,x)
        ldx     #$00
        lda     #$AD
        sta     ($FF,x)
        lda     L0200
        cmp     #$AA
        bne     LD039
        lda     $0300
        cmp     #$AB
        bne     LD039
        lda     $0303
        cmp     #$AC
        bne     LD039
        lda     $0400
        cmp     #$AD
        beq     LD03E
LD039:  lda     #$59
        sta     $07FF
LD03E:  lda     $07FF
        sta     $00
        lda     #$00
        sta     $0300
        lda     #$AA
        sta     L0200
        ldx     #$00
        ldy     #$5A
        jsr     LF7B6
        ora     ($80,x)
        jsr     LF7C0
        iny
        jsr     LF7CE
        ora     ($82,x)
        jsr     LF7D3
        iny
        jsr     LF7DF
        and     ($80,x)
        jsr     LF7E5
        iny
        lda     #$EF
        sta     $0300
        jsr     LF7F1
        and     ($82,x)
        jsr     LF7F6
        iny
        jsr     LF804
        eor     ($80,x)
        jsr     LF80A
        iny
        lda     #$70
        sta     $0300
        jsr     LF818
        eor     ($82,x)
        jsr     LF81D
        iny
        lda     #$69
        sta     L0200
        jsr     LF829
        adc     ($80,x)
        jsr     LF82F
        iny
        jsr     LF83D
        adc     ($80,x)
        jsr     LF843
        iny
        lda     #$7F
        sta     L0200
        jsr     LF851
        adc     ($80,x)
        jsr     LF856
        iny
        lda     #$80
        sta     L0200
        jsr     LF864
        adc     ($80,x)
        jsr     LF86A
        iny
        jsr     LF878
        adc     ($80,x)
        jsr     LF87D
        iny
        lda     #$40
        sta     L0200
        jsr     LF889
        cmp     ($80,x)
        jsr     LF88E
        iny
        pha
        lda     #$3F
        sta     L0200
        pla
        jsr     LF89A
        cmp     ($80,x)
        jsr     LF89C
        iny
        pha
        lda     #$41
        sta     L0200
        pla
        cmp     ($80,x)
        jsr     LF8A8
        iny
        pha
        lda     #$00
        sta     L0200
        pla
        jsr     LF8B2
        cmp     ($80,x)
        jsr     LF8B5
        iny
        pha
        lda     #$80
        sta     L0200
        pla
        cmp     ($80,x)
        jsr     LF8BF
        iny
        pha
        lda     #$81
        sta     L0200
        pla
        cmp     ($80,x)
        jsr     LF8C9
        iny
        pha
        lda     #$7F
        sta     L0200
        pla
        cmp     ($80,x)
        jsr     LF8D3
        iny
        lda     #$40
        sta     L0200
        jsr     LF931
        sbc     ($80,x)
        jsr     LF937
        iny
        lda     #$3F
        sta     L0200
        jsr     LF947
        sbc     ($80,x)
        jsr     LF94C
        iny
        lda     #$41
        sta     L0200
        jsr     LF95C
        sbc     ($80,x)
        jsr     LF962
        iny
        lda     #$00
        sta     L0200
        jsr     LF972
        sbc     ($80,x)
        jsr     LF976
        iny
        lda     #$7F
        sta     L0200
        jsr     LF980
        sbc     ($80,x)
        jsr     LF984
LD174:  rts
        lda     #$55
        sta     $78
        lda     #$FF
        sta     $01
        bit     $01
        ldy     #$11
        ldx     #$23
        lda     #$00
        lda     $78
        beq     LD199
        bmi     LD199
        cmp     #$55
        bne     LD199
        cpy     #$11
        bne     LD199
        cpx     #$23
        bvc     LD199
        beq     LD19D
LD199:  lda     #$76
        sta     $00
LD19D:  lda     #$46
        bit     $01
        sta     $78
        beq     LD1AF
        bpl     LD1AF
        bvc     LD1AF
        lda     $78
        cmp     #$46
        beq     LD1B3
LD1AF:  lda     #$77
        sta     $00
LD1B3:  lda     #$55
        sta     $78
        bit     $01
        lda     #$11
        ldx     #$23
        ldy     #$00
        ldy     $78
        beq     LD1D3
        bmi     LD1D3
        cpy     #$55
        bne     LD1D3
        cmp     #$11
        bne     LD1D3
        cpx     #$23
        bvc     LD1D3
        beq     LD1D7
LD1D3:  lda     #$78
        sta     $00
LD1D7:  ldy     #$46
        bit     $01
        sty     $78
        beq     LD1E9
        bpl     LD1E9
        bvc     LD1E9
        ldy     $78
        cpy     #$46
        beq     LD1ED
LD1E9:  lda     #$79
        sta     $00
LD1ED:  bit     $01
        lda     #$55
        sta     $78
        ldy     #$11
        lda     #$23
        ldx     #$00
        ldx     $78
        beq     LD20D
        bmi     LD20D
        cpx     #$55
        bne     LD20D
        cpy     #$11
        bne     LD20D
        cmp     #$23
        bvc     LD20D
        beq     LD211
LD20D:  lda     #$7A
        sta     $00
LD211:  ldx     #$46
        bit     $01
        stx     $78
        beq     LD223
        bpl     LD223
        bvc     LD223
        ldx     $78
        cpx     #$46
        beq     LD227
LD223:  lda     #$7B
        sta     $00
LD227:  lda     #$C0
        sta     $78
        ldx     #$33
        ldy     #$88
        lda     #$05
        bit     $78
        bpl     LD245
        bvc     LD245
        bne     LD245
        cmp     #$05
        bne     LD245
        cpx     #$33
        bne     LD245
        cpy     #$88
        beq     LD249
LD245:  lda     #$7C
        sta     $00
LD249:  lda     #$03
        sta     $78
        lda     #$01
        bit     $78
        bmi     LD25B
        bvs     LD25B
        beq     LD25B
        cmp     #$01
        beq     LD25F
LD25B:  lda     #$7D
        sta     $00
LD25F:  ldy     #$7E
        lda     #$AA
        sta     $78
        jsr     LF7B6
        ora     $78
        jsr     LF7C0
        iny
        lda     #$00
        sta     $78
        jsr     LF7CE
        ora     $78
        jsr     LF7D3
        iny
        lda     #$AA
        sta     $78
        jsr     LF7DF
        and     $78
        jsr     LF7E5
        iny
        lda     #$EF
        sta     $78
        jsr     LF7F1
        and     $78
        jsr     LF7F6
        iny
        lda     #$AA
        sta     $78
        jsr     LF804
        eor     $78
        jsr     LF80A
        iny
        lda     #$70
        sta     $78
        jsr     LF818
        eor     $78
        jsr     LF81D
        iny
        lda     #$69
        sta     $78
        jsr     LF829
        adc     $78
        jsr     LF82F
        iny
        jsr     LF83D
        adc     $78
        jsr     LF843
        iny
        lda     #$7F
        sta     $78
        jsr     LF851
        adc     $78
        jsr     LF856
        iny
        lda     #$80
        sta     $78
        jsr     LF864
        adc     $78
        jsr     LF86A
        iny
        jsr     LF878
        adc     $78
        jsr     LF87D
        iny
        lda     #$40
        sta     $78
        jsr     LF889
        cmp     $78
        jsr     LF88E
        iny
        pha
        lda     #$3F
        sta     $78
        pla
        jsr     LF89A
        cmp     $78
        jsr     LF89C
        iny
        pha
        lda     #$41
        sta     $78
        pla
        cmp     $78
        jsr     LF8A8
        iny
        pha
        lda     #$00
        sta     $78
        pla
        jsr     LF8B2
        cmp     $78
        jsr     LF8B5
        iny
        pha
        lda     #$80
        sta     $78
        pla
        cmp     $78
        jsr     LF8BF
        iny
        pha
        lda     #$81
        sta     $78
        pla
        cmp     $78
        jsr     LF8C9
        iny
        pha
        lda     #$7F
        sta     $78
        pla
        cmp     $78
        jsr     LF8D3
        iny
        lda     #$40
        sta     $78
        jsr     LF931
        sbc     $78
        jsr     LF937
        iny
        lda     #$3F
        sta     $78
        jsr     LF947
        sbc     $78
        jsr     LF94C
        iny
        lda     #$41
        sta     $78
        jsr     LF95C
        sbc     $78
        jsr     LF962
        iny
        lda     #$00
        sta     $78
        jsr     LF972
        sbc     $78
        jsr     LF976
        iny
        lda     #$7F
        sta     $78
        jsr     LF980
        sbc     $78
        jsr     LF984
        iny
        lda     #$40
        sta     $78
        jsr     LF889
        tax
        cpx     $78
        jsr     LF88E
        iny
        lda     #$3F
        sta     $78
        jsr     LF89A
        cpx     $78
        jsr     LF89C
        iny
        lda     #$41
        sta     $78
        cpx     $78
        jsr     LF8A8
        iny
        lda     #$00
        sta     $78
        jsr     LF8B2
        tax
        cpx     $78
        jsr     LF8B5
        iny
        lda     #$80
        sta     $78
        cpx     $78
        jsr     LF8BF
        iny
        lda     #$81
        sta     $78
        cpx     $78
        jsr     LF8C9
        iny
        lda     #$7F
        sta     $78
        cpx     $78
        jsr     LF8D3
        iny
        tya
        tax
        lda     #$40
        sta     $78
        jsr     LF8DD
        cpy     $78
        jsr     LF8E2
        inx
        lda     #$3F
        sta     $78
        jsr     LF8EE
        cpy     $78
        jsr     LF8F0
        inx
        lda     #$41
        sta     $78
        cpy     $78
        jsr     LF8FC
        inx
        lda     #$00
        sta     $78
        jsr     LF906
        cpy     $78
        jsr     LF909
        inx
        lda     #$80
        sta     $78
        cpy     $78
        jsr     LF913
        inx
        lda     #$81
        sta     $78
        cpy     $78
        jsr     LF91D
        inx
        lda     #$7F
        sta     $78
        cpy     $78
        jsr     LF927
        inx
        txa
        tay
        jsr     LF990
        sta     $78
        lsr     $78
        lda     $78
        jsr     LF99D
        iny
        sta     $78
        lsr     $78
        lda     $78
        jsr     LF9AD
        iny
        jsr     LF9BD
        sta     $78
        asl     $78
        lda     $78
        jsr     LF9C3
        iny
        sta     $78
        asl     $78
        lda     $78
        jsr     LF9D4
        iny
        jsr     LF9E4
        sta     $78
        ror     $78
        lda     $78
        jsr     LF9EA
        iny
        sta     $78
        ror     $78
        lda     $78
        jsr     LF9FB
        iny
        jsr     LFA0A
        sta     $78
        rol     $78
        lda     $78
        jsr     LFA10
        iny
        sta     $78
        rol     $78
        lda     $78
        jsr     LFA21
        lda     #$FF
        sta     $78
        sta     $01
        bit     $01
        sec
        inc     $78
        bne     LD49C
        bmi     LD49C
        bvc     LD49C
        bcc     LD49C
        lda     $78
        cmp     #$00
        beq     LD4A0
LD49C:  lda     #$AB
        sta     $00
LD4A0:  lda     #$7F
        sta     $78
        clv
        clc
        inc     $78
        beq     LD4B6
        bpl     LD4B6
        bvs     LD4B6
        bcs     LD4B6
        lda     $78
        cmp     #$80
        beq     LD4BA
LD4B6:  lda     #$AC
        sta     $00
LD4BA:  lda     #$00
        sta     $78
        bit     $01
        sec
        dec     $78
        beq     LD4D1
        bpl     LD4D1
        bvc     LD4D1
        bcc     LD4D1
        lda     $78
        cmp     #$FF
        beq     LD4D5
LD4D1:  lda     #$AD
        sta     $00
LD4D5:  lda     #$80
        sta     $78
        clv
        clc
        dec     $78
        beq     LD4EB
        bmi     LD4EB
        bvs     LD4EB
        bcs     LD4EB
        lda     $78
        cmp     #$7F
        beq     LD4EF
LD4EB:  lda     #$AE
        sta     $00
LD4EF:  lda     #$01
        sta     $78
        dec     $78
        beq     LD4FB
        lda     #$AF
        sta     $00
LD4FB:  rts
        lda     #$55
        sta     $0678
        lda     #$FF
        sta     $01
        bit     $01
        ldy     #$11
        ldx     #$23
        lda     #$00
        lda     $0678
        beq     LD522
        bmi     LD522
        cmp     #$55
        bne     LD522
        cpy     #$11
        bne     LD522
        cpx     #$23
        bvc     LD522
        beq     LD526
LD522:  lda     #$B0
        sta     $00
LD526:  lda     #$46
        bit     $01
        sta     $0678
        beq     LD53A
        bpl     LD53A
        bvc     LD53A
        lda     $0678
        cmp     #$46
        beq     LD53E
LD53A:  lda     #$B1
        sta     $00
LD53E:  lda     #$55
        sta     $0678
        bit     $01
        lda     #$11
        ldx     #$23
        ldy     #$00
        ldy     $0678
        beq     LD560
        bmi     LD560
        cpy     #$55
        bne     LD560
        cmp     #$11
        bne     LD560
        cpx     #$23
        bvc     LD560
        beq     LD564
LD560:  lda     #$B2
        sta     $00
LD564:  ldy     #$46
        bit     $01
        sty     $0678
        beq     LD578
        bpl     LD578
        bvc     LD578
        ldy     $0678
        cpy     #$46
        beq     LD57C
LD578:  lda     #$B3
        sta     $00
LD57C:  bit     $01
        lda     #$55
        sta     $0678
        ldy     #$11
        lda     #$23
        ldx     #$00
        ldx     $0678
        beq     LD59E
        bmi     LD59E
        cpx     #$55
        bne     LD59E
        cpy     #$11
        bne     LD59E
        cmp     #$23
        bvc     LD59E
        beq     LD5A2
LD59E:  lda     #$B4
        sta     $00
LD5A2:  ldx     #$46
        bit     $01
        stx     $0678
        beq     LD5B6
        bpl     LD5B6
        bvc     LD5B6
        ldx     $0678
        cpx     #$46
        beq     LD5BA
LD5B6:  lda     #$B5
        sta     $00
LD5BA:  lda     #$C0
        sta     $0678
        ldx     #$33
        ldy     #$88
        lda     #$05
        bit     $0678
        bpl     LD5DA
        bvc     LD5DA
        bne     LD5DA
        cmp     #$05
        bne     LD5DA
        cpx     #$33
        bne     LD5DA
        cpy     #$88
        beq     LD5DE
LD5DA:  lda     #$B6
        sta     $00
LD5DE:  lda     #$03
        sta     $0678
        lda     #$01
        bit     $0678
        bmi     LD5F2
        bvs     LD5F2
        beq     LD5F2
        cmp     #$01
        beq     LD5F6
LD5F2:  lda     #$B7
        sta     $00
LD5F6:  ldy     #$B8
        lda     #$AA
        sta     $0678
        jsr     LF7B6
        ora     $0678
        jsr     LF7C0
        iny
        lda     #$00
        sta     $0678
        jsr     LF7CE
        ora     $0678
        jsr     LF7D3
        iny
        lda     #$AA
        sta     $0678
        jsr     LF7DF
        and     $0678
        jsr     LF7E5
        iny
        lda     #$EF
        sta     $0678
        jsr     LF7F1
        and     $0678
        jsr     LF7F6
        iny
        lda     #$AA
        sta     $0678
        jsr     LF804
        eor     $0678
        jsr     LF80A
        iny
        lda     #$70
        sta     $0678
        jsr     LF818
        eor     $0678
        jsr     LF81D
        iny
        lda     #$69
        sta     $0678
        jsr     LF829
        adc     $0678
        jsr     LF82F
        iny
        jsr     LF83D
        adc     $0678
        jsr     LF843
        iny
        lda     #$7F
        sta     $0678
        jsr     LF851
        adc     $0678
        jsr     LF856
        iny
        lda     #$80
        sta     $0678
        jsr     LF864
        adc     $0678
        jsr     LF86A
        iny
        jsr     LF878
        adc     $0678
        jsr     LF87D
        iny
        lda     #$40
        sta     $0678
        jsr     LF889
        cmp     $0678
        jsr     LF88E
        iny
        pha
        lda     #$3F
        sta     $0678
        pla
        jsr     LF89A
        cmp     $0678
        jsr     LF89C
        iny
        pha
        lda     #$41
        sta     $0678
        pla
        cmp     $0678
        jsr     LF8A8
        iny
        pha
        lda     #$00
        sta     $0678
        pla
        jsr     LF8B2
        cmp     $0678
        jsr     LF8B5
        iny
        pha
        lda     #$80
        sta     $0678
        pla
        cmp     $0678
        jsr     LF8BF
        iny
        pha
        lda     #$81
        sta     $0678
        pla
        cmp     $0678
        jsr     LF8C9
        iny
        pha
        lda     #$7F
        sta     $0678
        pla
        cmp     $0678
        jsr     LF8D3
        iny
        lda     #$40
        sta     $0678
        jsr     LF931
        sbc     $0678
        jsr     LF937
        iny
        lda     #$3F
        sta     $0678
        jsr     LF947
        sbc     $0678
        jsr     LF94C
        iny
        lda     #$41
        sta     $0678
        jsr     LF95C
        sbc     $0678
        jsr     LF962
        iny
        lda     #$00
        sta     $0678
        jsr     LF972
        sbc     $0678
        jsr     LF976
        iny
        lda     #$7F
        sta     $0678
        jsr     LF980
        sbc     $0678
        jsr     LF984
        iny
        lda     #$40
        sta     $0678
        jsr     LF889
        tax
        cpx     $0678
        jsr     LF88E
        iny
        lda     #$3F
        sta     $0678
        jsr     LF89A
        cpx     $0678
        jsr     LF89C
        iny
        lda     #$41
        sta     $0678
        cpx     $0678
        jsr     LF8A8
        iny
        lda     #$00
        sta     $0678
        jsr     LF8B2
        tax
        cpx     $0678
        jsr     LF8B5
        iny
        lda     #$80
        sta     $0678
        cpx     $0678
        jsr     LF8BF
        iny
        lda     #$81
        sta     $0678
        cpx     $0678
        jsr     LF8C9
        iny
        lda     #$7F
        sta     $0678
        cpx     $0678
        jsr     LF8D3
        iny
        tya
        tax
        lda     #$40
        sta     $0678
        jsr     LF8DD
        cpy     $0678
        jsr     LF8E2
        inx
        lda     #$3F
        sta     $0678
        jsr     LF8EE
        cpy     $0678
        jsr     LF8F0
        inx
        lda     #$41
        sta     $0678
        cpy     $0678
        jsr     LF8FC
        inx
        lda     #$00
        sta     $0678
        jsr     LF906
        cpy     $0678
        jsr     LF909
        inx
        lda     #$80
        sta     $0678
        cpy     $0678
        jsr     LF913
        inx
        lda     #$81
        sta     $0678
        cpy     $0678
        jsr     LF91D
        inx
        lda     #$7F
        sta     $0678
        cpy     $0678
        jsr     LF927
        inx
        txa
        tay
        jsr     LF990
        sta     $0678
        lsr     $0678
        lda     $0678
        jsr     LF99D
        iny
        sta     $0678
        lsr     $0678
        lda     $0678
        jsr     LF9AD
        iny
        jsr     LF9BD
        sta     $0678
        asl     $0678
        lda     $0678
        jsr     LF9C3
        iny
        sta     $0678
        asl     $0678
        lda     $0678
        jsr     LF9D4
        iny
        jsr     LF9E4
        sta     $0678
        ror     $0678
        lda     $0678
        jsr     LF9EA
        iny
        sta     $0678
        ror     $0678
        lda     $0678
        jsr     LF9FB
        iny
        jsr     LFA0A
        sta     $0678
        rol     $0678
        lda     $0678
        jsr     LFA10
        iny
        sta     $0678
        rol     $0678
        lda     $0678
        jsr     LFA21
        lda     #$FF
        sta     $0678
        sta     $01
        bit     $01
        sec
        inc     $0678
        bne     LD896
        bmi     LD896
        bvc     LD896
        bcc     LD896
        lda     $0678
        cmp     #$00
        beq     LD89A
LD896:  lda     #$E5
        sta     $00
LD89A:  lda     #$7F
        sta     $0678
        clv
        clc
        inc     $0678
        beq     LD8B3
        bpl     LD8B3
        bvs     LD8B3
        bcs     LD8B3
        lda     $0678
        cmp     #$80
        beq     LD8B7
LD8B3:  lda     #$E6
        sta     $00
LD8B7:  lda     #$00
        sta     $0678
        bit     $01
        sec
        dec     $0678
        beq     LD8D1
        bpl     LD8D1
        bvc     LD8D1
        bcc     LD8D1
        lda     $0678
        cmp     #$FF
        beq     LD8D5
LD8D1:  lda     #$E7
        sta     $00
LD8D5:  lda     #$80
        sta     $0678
        clv
        clc
        dec     $0678
        beq     LD8EE
        bmi     LD8EE
        bvs     LD8EE
        bcs     LD8EE
        lda     $0678
        cmp     #$7F
        beq     LD8F2
LD8EE:  lda     #$E8
        sta     $00
LD8F2:  lda     #$01
        sta     $0678
        dec     $0678
        beq     LD900
        lda     #$E9
        sta     $00
LD900:  rts
        lda     #$A3
        sta     $33
        lda     #$89
        sta     $0300
        lda     #$12
        sta     $0245
        lda     #$FF
        sta     $01
        ldx     #$65
        lda     #$00
        sta     $89
        lda     #$03
        sta     $8A
        ldy     #$00
        sec
        lda     #$00
        clv
        lda     ($89),y
        beq     LD933
        bcc     LD933
        bvs     LD933
        cmp     #$89
        bne     LD933
        cpx     #$65
        beq     LD937
LD933:  lda     #$EA
        sta     $00
LD937:  lda     #$FF
        sta     $97
        sta     $98
        bit     $98
        ldy     #$34
        lda     ($97),y
        cmp     #$A3
        bne     LD949
        bcs     LD94D
LD949:  lda     #$EB
        sta     $00
LD94D:  lda     $00
        pha
        lda     #$46
        sta     $FF
        lda     #$01
        sta     $00
        ldy     #$FF
        lda     ($FF),y
        cmp     #$12
        beq     LD964
        pla
        lda     #$EC
        pha
LD964:  pla
        sta     $00
        ldx     #$ED
        lda     #$00
        sta     $33
        lda     #$04
        sta     $34
        ldy     #$00
        clc
        lda     #$FF
        sta     $01
        bit     $01
        lda     #$AA
        sta     $0400
        lda     #$55
        ora     ($33),y
        bcs     LD98D
        bpl     LD98D
        cmp     #$FF
        bne     LD98D
        bvs     LD98F
LD98D:  stx     $00
LD98F:  inx
        sec
        clv
        lda     #$00
        ora     ($33),y
        beq     LD99E
        bvs     LD99E
        bcc     LD99E
        bmi     LD9A0
LD99E:  stx     $00
LD9A0:  inx
        clc
        bit     $01
        lda     #$55
        and     ($33),y
        bne     LD9B0
        bvc     LD9B0
        bcs     LD9B0
        bpl     LD9B2
LD9B0:  stx     $00
LD9B2:  inx
        sec
        clv
        lda     #$EF
        sta     $0400
        lda     #$F8
        and     ($33),y
        bcc     LD9C8
        bpl     LD9C8
        cmp     #$E8
        bne     LD9C8
        bvc     LD9CA
LD9C8:  stx     $00
LD9CA:  inx
        clc
        bit     $01
        lda     #$AA
        sta     $0400
        lda     #$5F
        eor     ($33),y
        bcs     LD9E1
        bpl     LD9E1
        cmp     #$F5
        bne     LD9E1
        bvs     LD9E3
LD9E1:  stx     $00
LD9E3:  inx
        sec
        clv
        lda     #$70
        sta     $0400
        eor     ($33),y
        bne     LD9F5
        bvs     LD9F5
        bcc     LD9F5
        bpl     LD9F7
LD9F5:  stx     $00
LD9F7:  inx
        clc
        bit     $01
        lda     #$69
        sta     $0400
        lda     #$00
        adc     ($33),y
        bmi     LDA0E
        bcs     LDA0E
        cmp     #$69
        bne     LDA0E
        bvc     LDA10
LDA0E:  stx     $00
LDA10:  inx
        sec
        bit     $01
        lda     #$00
        adc     ($33),y
        bmi     LDA22
        bcs     LDA22
        cmp     #$6A
        bne     LDA22
        bvc     LDA24
LDA22:  stx     $00
LDA24:  inx
        sec
        clv
        lda     #$7F
        sta     $0400
        adc     ($33),y
        bpl     LDA38
        bcs     LDA38
        cmp     #$FF
        bne     LDA38
        bvs     LDA3A
LDA38:  stx     $00
LDA3A:  inx
        clc
        bit     $01
        lda     #$80
        sta     $0400
        lda     #$7F
        adc     ($33),y
        bpl     LDA51
        bcs     LDA51
        cmp     #$FF
        bne     LDA51
        bvc     LDA53
LDA51:  stx     $00
LDA53:  inx
        sec
        clv
        lda     #$80
        sta     $0400
        lda     #$7F
        adc     ($33),y
        bne     LDA67
        bmi     LDA67
        bvs     LDA67
        bcs     LDA69
LDA67:  stx     $00
LDA69:  inx
        bit     $01
        lda     #$40
        sta     $0400
        cmp     ($33),y
        bmi     LDA7B
        bcc     LDA7B
        bne     LDA7B
        bvs     LDA7D
LDA7B:  stx     $00
LDA7D:  inx
        clv
        dec     $0400
        cmp     ($33),y
        beq     LDA8C
        bmi     LDA8C
        bcc     LDA8C
        bvc     LDA8E
LDA8C:  stx     $00
LDA8E:  inx
        inc     $0400
        inc     $0400
        cmp     ($33),y
        beq     LDA9B
        bmi     LDA9D
LDA9B:  stx     $00
LDA9D:  inx
        lda     #$00
        sta     $0400
        lda     #$80
        cmp     ($33),y
        beq     LDAAD
        bpl     LDAAD
        bcs     LDAAF
LDAAD:  stx     $00
LDAAF:  inx
        ldy     #$80
        sty     $0400
        ldy     #$00
        cmp     ($33),y
        bne     LDABF
        bmi     LDABF
        bcs     LDAC1
LDABF:  stx     $00
LDAC1:  inx
        inc     $0400
        cmp     ($33),y
        bcs     LDACD
        beq     LDACD
        bmi     LDACF
LDACD:  stx     $00
LDACF:  inx
        dec     $0400
        dec     $0400
        cmp     ($33),y
        bcc     LDADE
        beq     LDADE
        bpl     LDAE0
LDADE:  stx     $00
LDAE0:  rts
        lda     #$00
        sta     $33
        lda     #$04
        sta     $34
        ldy     #$00
        ldx     #$01
        bit     $01
        lda     #$40
        sta     $0400
        sec
        sbc     ($33),y
        bmi     LDB03
        bcc     LDB03
        bne     LDB03
        bvs     LDB03
        cmp     #$00
        beq     LDB05
LDB03:  stx     $00
LDB05:  inx
        clv
        sec
        lda     #$40
        dec     $0400
        sbc     ($33),y
        beq     LDB1B
        bmi     LDB1B
        bcc     LDB1B
        bvs     LDB1B
        cmp     #$01
        beq     LDB1D
LDB1B:  stx     $00
LDB1D:  inx
        lda     #$40
        sec
        bit     $01
        inc     $0400
        inc     $0400
        sbc     ($33),y
        bcs     LDB37
        beq     LDB37
        bpl     LDB37
        bvs     LDB37
        cmp     #$FF
        beq     LDB39
LDB37:  stx     $00
LDB39:  inx
        clc
        lda     #$00
        sta     $0400
        lda     #$80
        sbc     ($33),y
        bcc     LDB4A
        cmp     #$7F
        beq     LDB4C
LDB4A:  stx     $00
LDB4C:  inx
        sec
        lda     #$7F
        sta     $0400
        lda     #$81
        sbc     ($33),y
        bvc     LDB5F
        bcc     LDB5F
        cmp     #$02
        beq     LDB61
LDB5F:  stx     $00
LDB61:  inx
        lda     #$00
        lda     #$87
        sta     ($33),y
        lda     $0400
        cmp     #$87
        beq     LDB71
        stx     $00
LDB71:  inx
        lda     #$7E
        sta     L0200
        lda     #$DB
        sta     $0201
        jmp     (L0200)
        lda     #$00
        sta     $02FF
        lda     #$01
        sta     $0300
        lda     #$03
        sta     L0200
        lda     #$A9
        sta     $0100
        lda     #$55
        sta     $0101
        lda     #$60
        sta     $0102
        lda     #$A9
        sta     $0300
        lda     #$AA
        sta     $0301
        lda     #$60
        sta     $0302
        jsr     LDBB5
        cmp     #$AA
        beq     LDBB5
        stx     $00
LDBB5:  rts
        .byte   $6C
        .byte   $FF
LDBB8:  .byte   $02
        lda     #$FF
        sta     $01
        lda     #$AA
        sta     $33
        lda     #$BB
        sta     $89
        ldx     #$00
        lda     #$66
        bit     $01
        sec
        ldy     #$00
        ldy     $33,x
        bpl     LDBE4
        beq     LDBE4
        bvc     LDBE4
        bcc     LDBE4
        cmp     #$66
        bne     LDBE4
        cpx     #$00
        bne     LDBE4
        cpy     #$AA
        beq     LDBE8
LDBE4:  lda     #$08
        sta     $00
LDBE8:  ldx     #$8A
        lda     #$66
        clv
        clc
        ldy     #$00
        ldy     $FF,x
        bpl     LDC06
        beq     LDC06
        bvs     LDC06
        bcs     LDC06
        cpy     #$BB
        bne     LDC06
        cmp     #$66
        bne     LDC06
        cpx     #$8A
        beq     LDC0A
LDC06:  lda     #$09
        sta     $00
LDC0A:  bit     $01
        sec
        ldy     #$44
        ldx     #$00
        sty     $33,x
        lda     $33
        bcc     LDC2F
        cmp     #$44
        bne     LDC2F
        bvc     LDC2F
        clc
        clv
        ldy     #$99
        ldx     #$80
        sty     $85,x
        lda     $05
        bcs     LDC2F
        cmp     #$99
        bne     LDC2F
        bvc     LDC33
LDC2F:  lda     #$0A
        sta     $00
LDC33:  ldy     #$0B
        lda     #$AA
        ldx     #$78
        sta     $78
        jsr     LF7B6
        ora     $00,x
        jsr     LF7C0
        iny
        lda     #$00
        sta     $78
        jsr     LF7CE
        ora     $00,x
        jsr     LF7D3
        iny
        lda     #$AA
        sta     $78
        jsr     LF7DF
        and     $00,x
        jsr     LF7E5
        iny
        lda     #$EF
        sta     $78
        jsr     LF7F1
        and     $00,x
        jsr     LF7F6
        iny
        lda     #$AA
        sta     $78
        jsr     LF804
        eor     $00,x
        jsr     LF80A
        iny
        lda     #$70
        sta     $78
        jsr     LF818
        eor     $00,x
        jsr     LF81D
        iny
        lda     #$69
        sta     $78
        jsr     LF829
        adc     $00,x
        jsr     LF82F
        iny
        jsr     LF83D
        adc     $00,x
        jsr     LF843
        iny
        lda     #$7F
        sta     $78
        jsr     LF851
        adc     $00,x
        jsr     LF856
        iny
        lda     #$80
        sta     $78
        jsr     LF864
        adc     $00,x
        jsr     LF86A
        iny
        jsr     LF878
        adc     $00,x
        jsr     LF87D
        iny
        lda     #$40
        sta     $78
        jsr     LF889
        cmp     $00,x
        jsr     LF88E
        iny
        pha
        lda     #$3F
        sta     $78
        pla
        jsr     LF89A
        cmp     $00,x
        jsr     LF89C
        iny
        pha
        lda     #$41
        sta     $78
        pla
        cmp     $00,x
        jsr     LF8A8
        iny
        pha
        lda     #$00
        sta     $78
        pla
        jsr     LF8B2
        cmp     $00,x
        jsr     LF8B5
        iny
        pha
        lda     #$80
        sta     $78
        pla
        cmp     $00,x
        jsr     LF8BF
        iny
        pha
        lda     #$81
        sta     $78
        pla
        cmp     $00,x
        jsr     LF8C9
        iny
        pha
        lda     #$7F
        sta     $78
        pla
        cmp     $00,x
        jsr     LF8D3
        iny
        lda     #$40
        sta     $78
        jsr     LF931
        sbc     $00,x
        jsr     LF937
        iny
        lda     #$3F
        sta     $78
        jsr     LF947
        sbc     $00,x
        jsr     LF94C
        iny
        lda     #$41
        sta     $78
        jsr     LF95C
        sbc     $00,x
        jsr     LF962
        iny
        lda     #$00
        sta     $78
        jsr     LF972
        sbc     $00,x
        jsr     LF976
        iny
        lda     #$7F
        sta     $78
        jsr     LF980
        sbc     $00,x
        jsr     LF984
        lda     #$AA
        sta     $33
        lda     #$BB
        sta     $89
        ldx     #$00
        ldy     #$66
        bit     $01
        sec
        lda     #$00
        lda     $33,x
        bpl     LDD80
        beq     LDD80
        bvc     LDD80
        bcc     LDD80
        cpy     #$66
        bne     LDD80
        cpx     #$00
        bne     LDD80
        cmp     #$AA
        beq     LDD84
LDD80:  lda     #$22
        sta     $00
LDD84:  ldx     #$8A
        ldy     #$66
        clv
        clc
        lda     #$00
        lda     $FF,x
        bpl     LDDA2
        beq     LDDA2
        bvs     LDDA2
        bcs     LDDA2
        cmp     #$BB
        bne     LDDA2
        cpy     #$66
        bne     LDDA2
        cpx     #$8A
        beq     LDDA6
LDDA2:  lda     #$23
        sta     $00
LDDA6:  bit     $01
        sec
        lda     #$44
        ldx     #$00
        sta     $33,x
        lda     $33
        bcc     LDDCB
        cmp     #$44
        bne     LDDCB
        bvc     LDDCB
        clc
        clv
        lda     #$99
        ldx     #$80
        sta     $85,x
        lda     $05
        bcs     LDDCB
        cmp     #$99
        bne     LDDCB
        bvc     LDDCF
LDDCB:  lda     #$24
        sta     $00
LDDCF:  ldy     #$25
        ldx     #$78
        jsr     LF990
        sta     $00,x
        lsr     $00,x
        lda     $00,x
        jsr     LF99D
        iny
        sta     $00,x
        lsr     $00,x
        lda     $00,x
        jsr     LF9AD
        iny
        jsr     LF9BD
        sta     $00,x
        asl     $00,x
        lda     $00,x
        jsr     LF9C3
        iny
        sta     $00,x
        asl     $00,x
        lda     $00,x
        jsr     LF9D4
        iny
        jsr     LF9E4
        sta     $00,x
        ror     $00,x
        lda     $00,x
        jsr     LF9EA
        iny
        sta     $00,x
        ror     $00,x
        lda     $00,x
        jsr     LF9FB
        iny
        jsr     LFA0A
        sta     $00,x
        rol     $00,x
        lda     $00,x
        jsr     LFA10
        iny
        sta     $00,x
        rol     $00,x
        lda     $00,x
        jsr     LFA21
        lda     #$FF
        sta     $00,x
        sta     $01
        bit     $01
        sec
        inc     $00,x
        bne     LDE47
        bmi     LDE47
        bvc     LDE47
        bcc     LDE47
        lda     $00,x
        cmp     #$00
        beq     LDE4B
LDE47:  lda     #$2D
        sta     $00
LDE4B:  lda     #$7F
        sta     $00,x
        clv
        clc
        inc     $00,x
        beq     LDE61
        bpl     LDE61
        bvs     LDE61
        bcs     LDE61
        lda     $00,x
        cmp     #$80
        beq     LDE65
LDE61:  lda     #$2E
        sta     $00
LDE65:  lda     #$00
        sta     $00,x
        bit     $01
        sec
        dec     $00,x
        beq     LDE7C
        bpl     LDE7C
        bvc     LDE7C
        bcc     LDE7C
        lda     $00,x
        cmp     #$FF
        beq     LDE80
LDE7C:  lda     #$2F
        sta     $00
LDE80:  lda     #$80
        sta     $00,x
        clv
        clc
        dec     $00,x
        beq     LDE96
        bmi     LDE96
        bvs     LDE96
        bcs     LDE96
        lda     $00,x
        cmp     #$7F
        beq     LDE9A
LDE96:  lda     #$30
        sta     $00
LDE9A:  lda     #$01
        sta     $00,x
        dec     $00,x
        beq     LDEA6
        lda     #$31
        sta     $00
LDEA6:  lda     #$33
        sta     $78
        lda     #$44
        ldy     #$78
        ldx     #$00
        sec
        bit     $01
        ldx     $00,y
        bcc     LDEC9
        bvc     LDEC9
        bmi     LDEC9
        beq     LDEC9
        cpx     #$33
        bne     LDEC9
        cpy     #$78
        bne     LDEC9
        cmp     #$44
        beq     LDECD
LDEC9:  lda     #$32
        sta     $00
LDECD:  lda     #$97
        sta     $7F
        lda     #$47
        ldy     #$FF
        ldx     #$00
        clc
        clv
        ldx     $80,y
        bcs     LDEEF
        bvs     LDEEF
        bpl     LDEEF
        beq     LDEEF
        cpx     #$97
        bne     LDEEF
        cpy     #$FF
        bne     LDEEF
        cmp     #$47
        beq     LDEF3
LDEEF:  lda     #$33
        sta     $00
LDEF3:  lda     #$00
        sta     $7F
        lda     #$47
        ldy     #$FF
        ldx     #$69
        clc
        clv
        stx     $80,y
        bcs     LDF1B
        bvs     LDF1B
        bmi     LDF1B
        beq     LDF1B
        cpx     #$69
        bne     LDF1B
        cpy     #$FF
        bne     LDF1B
        cmp     #$47
        bne     LDF1B
        lda     $7F
        cmp     #$69
        beq     LDF1F
LDF1B:  lda     #$34
        sta     $00
LDF1F:  lda     #$F5
        sta     $4F
        lda     #$47
        ldy     #$4F
        bit     $01
        ldx     #$00
        sec
        stx     $00,y
        bcc     LDF46
        bvc     LDF46
        bmi     LDF46
        bne     LDF46
        cpx     #$00
        bne     LDF46
        cpy     #$4F
        bne     LDF46
        cmp     #$47
        bne     LDF46
        lda     $4F
        beq     LDF4A
LDF46:  lda     #$35
        sta     $00
LDF4A:  rts
        lda     #$89
        sta     $0300
        lda     #$A3
        sta     $33
        lda     #$12
        sta     $0245
        ldx     #$65
        ldy     #$00
        sec
        lda     #$00
        clv
        lda     $0300,y
        beq     LDF72
        bcc     LDF72
        bvs     LDF72
        cmp     #$89
        bne     LDF72
        cpx     #$65
        beq     LDF76
LDF72:  lda     #$36
        sta     $00
LDF76:  lda     #$FF
        sta     $01
        bit     $01
        ldy     #$34
        lda     LFFFF,y
        cmp     #$A3
        bne     LDF87
        bcs     LDF8B
LDF87:  lda     #$37
        sta     $00
LDF8B:  lda     #$46
        sta     $FF
        ldy     #$FF
        lda     $0146,y
        cmp     #$12
        beq     LDF9C
        lda     #$38
        sta     $00
LDF9C:  ldx     #$39
        clc
        lda     #$FF
        sta     $01
        bit     $01
        lda     #$AA
        sta     $0400
        lda     #$55
        ldy     #$00
        ora     $0400,y
        bcs     LDFBB
        bpl     LDFBB
        cmp     #$FF
        bne     LDFBB
        bvs     LDFBD
LDFBB:  stx     $00
LDFBD:  inx
        sec
        clv
        lda     #$00
        ora     $0400,y
        beq     LDFCD
        bvs     LDFCD
        bcc     LDFCD
        bmi     LDFCF
LDFCD:  stx     $00
LDFCF:  inx
        clc
        bit     $01
        lda     #$55
        and     $0400,y
        bne     LDFE0
        bvc     LDFE0
        bcs     LDFE0
        bpl     LDFE2
LDFE0:  stx     $00
LDFE2:  inx
        sec
        clv
        lda     #$EF
        sta     $0400
        lda     #$F8
        and     $0400,y
        bcc     LDFF9
        bpl     LDFF9
        cmp     #$E8
        bne     LDFF9
        bvc     LDFFB
LDFF9:  stx     $00
LDFFB:  inx
        clc
        bit     $01
        lda     #$AA
        sta     $0400
        lda     #$5F
        eor     $0400,y
        bcs     LE013
        bpl     LE013
        cmp     #$F5
        bne     LE013
        bvs     LE015
LE013:  stx     $00
LE015:  inx
        sec
        clv
        lda     #$70
        sta     $0400
        eor     $0400,y
        bne     LE028
        bvs     LE028
        bcc     LE028
        bpl     LE02A
LE028:  stx     $00
LE02A:  inx
        clc
        bit     $01
        lda     #$69
        sta     $0400
        lda     #$00
        adc     $0400,y
        bmi     LE042
        bcs     LE042
        cmp     #$69
        bne     LE042
        bvc     LE044
LE042:  stx     $00
LE044:  inx
        sec
        bit     $01
        lda     #$00
        adc     $0400,y
        bmi     LE057
        bcs     LE057
        cmp     #$6A
        bne     LE057
        bvc     LE059
LE057:  stx     $00
LE059:  inx
        sec
        clv
        lda     #$7F
        sta     $0400
        adc     $0400,y
        bpl     LE06E
        bcs     LE06E
        cmp     #$FF
        bne     LE06E
        bvs     LE070
LE06E:  stx     $00
LE070:  inx
        clc
        bit     $01
        lda     #$80
        sta     $0400
        lda     #$7F
        adc     $0400,y
        bpl     LE088
        bcs     LE088
        cmp     #$FF
        bne     LE088
        bvc     LE08A
LE088:  stx     $00
LE08A:  inx
        sec
        clv
        lda     #$80
        sta     $0400
        lda     #$7F
        adc     $0400,y
        bne     LE09F
        bmi     LE09F
        bvs     LE09F
        bcs     LE0A1
LE09F:  stx     $00
LE0A1:  inx
        bit     $01
        lda     #$40
        sta     $0400
        cmp     $0400,y
        bmi     LE0B4
        bcc     LE0B4
        bne     LE0B4
        bvs     LE0B6
LE0B4:  stx     $00
LE0B6:  inx
        clv
        .byte   $CE
        brk
LE0BA:  .byte   $04
        cmp     $0400,y
        beq     LE0C6
        bmi     LE0C6
        bcc     LE0C6
        bvc     LE0C8
LE0C6:  stx     $00
LE0C8:  inx
        inc     $0400
        inc     $0400
        cmp     $0400,y
        beq     LE0D6
        bmi     LE0D8
LE0D6:  stx     $00
LE0D8:  inx
        lda     #$00
        sta     $0400
        lda     #$80
        cmp     $0400,y
        beq     LE0E9
        bpl     LE0E9
        bcs     LE0EB
LE0E9:  stx     $00
LE0EB:  inx
        ldy     #$80
        sty     $0400
        ldy     #$00
        cmp     $0400,y
        bne     LE0FC
        bmi     LE0FC
        bcs     LE0FE
LE0FC:  stx     $00
LE0FE:  inx
        inc     $0400
        cmp     $0400,y
        bcs     LE10B
        beq     LE10B
        bmi     LE10D
LE10B:  stx     $00
LE10D:  inx
        dec     $0400
        dec     $0400
        cmp     $0400,y
        bcc     LE11D
        beq     LE11D
        bpl     LE11F
LE11D:  stx     $00
LE11F:  inx
        bit     $01
        lda     #$40
        sta     $0400
        sec
        sbc     $0400,y
        bmi     LE137
        bcc     LE137
        bne     LE137
        bvs     LE137
        cmp     #$00
        beq     LE139
LE137:  stx     $00
LE139:  inx
        clv
        sec
        lda     #$40
        dec     $0400
        sbc     $0400,y
        beq     LE150
        bmi     LE150
        bcc     LE150
        bvs     LE150
        cmp     #$01
        beq     LE152
LE150:  stx     $00
LE152:  inx
        lda     #$40
        sec
        bit     $01
        inc     $0400
        inc     $0400
        sbc     $0400,y
        bcs     LE16D
        beq     LE16D
        bpl     LE16D
        bvs     LE16D
        cmp     #$FF
        beq     LE16F
LE16D:  stx     $00
LE16F:  inx
        clc
        lda     #$00
        sta     $0400
        lda     #$80
        sbc     $0400,y
        bcc     LE181
        cmp     #$7F
        beq     LE183
LE181:  stx     $00
LE183:  inx
        sec
        lda     #$7F
        sta     $0400
        lda     #$81
        sbc     $0400,y
        bvc     LE197
        bcc     LE197
        cmp     #$02
        beq     LE199
LE197:  stx     $00
LE199:  inx
        lda     #$00
        lda     #$87
        sta     $0400,y
        lda     $0400
        cmp     #$87
        beq     LE1AA
        stx     $00
LE1AA:  rts
        lda     #$FF
        sta     $01
        lda     #$AA
        sta     $0633
        lda     #$BB
        sta     $0689
        ldx     #$00
        lda     #$66
        bit     $01
        sec
        ldy     #$00
        ldy     $0633,x
        bpl     LE1D9
        beq     LE1D9
        bvc     LE1D9
        bcc     LE1D9
        cmp     #$66
        bne     LE1D9
        cpx     #$00
        bne     LE1D9
        cpy     #$AA
        beq     LE1DD
LE1D9:  lda     #$51
        sta     $00
LE1DD:  ldx     #$8A
        lda     #$66
        clv
        clc
        ldy     #$00
        ldy     $05FF,x
        bpl     LE1FC
        beq     LE1FC
        bvs     LE1FC
        bcs     LE1FC
        cpy     #$BB
        bne     LE1FC
        cmp     #$66
        bne     LE1FC
        cpx     #$8A
        beq     LE200
LE1FC:  lda     #$52
        sta     $00
LE200:  ldy     #$53
        lda     #$AA
        ldx     #$78
        sta     $0678
        jsr     LF7B6
        ora     $0600,x
        jsr     LF7C0
        iny
        lda     #$00
        sta     $0678
        jsr     LF7CE
        ora     $0600,x
        jsr     LF7D3
        iny
        lda     #$AA
        sta     $0678
        jsr     LF7DF
        and     $0600,x
        jsr     LF7E5
        iny
        lda     #$EF
        sta     $0678
        jsr     LF7F1
        and     $0600,x
        jsr     LF7F6
        iny
        lda     #$AA
        sta     $0678
        jsr     LF804
        eor     $0600,x
        jsr     LF80A
        iny
        lda     #$70
        sta     $0678
        jsr     LF818
        eor     $0600,x
        jsr     LF81D
        iny
        lda     #$69
        sta     $0678
        jsr     LF829
        adc     $0600,x
        jsr     LF82F
        iny
        jsr     LF83D
        adc     $0600,x
        jsr     LF843
        iny
        lda     #$7F
        sta     $0678
        jsr     LF851
        adc     $0600,x
        jsr     LF856
        iny
        lda     #$80
        sta     $0678
        jsr     LF864
        adc     $0600,x
        jsr     LF86A
        iny
        jsr     LF878
        adc     $0600,x
        jsr     LF87D
        iny
        lda     #$40
        sta     $0678
        jsr     LF889
        cmp     $0600,x
        jsr     LF88E
        iny
        pha
        lda     #$3F
        sta     $0678
        pla
        jsr     LF89A
        cmp     $0600,x
        jsr     LF89C
        iny
        pha
        lda     #$41
        sta     $0678
        pla
        cmp     $0600,x
        jsr     LF8A8
        iny
        pha
        lda     #$00
        sta     $0678
        pla
        jsr     LF8B2
        cmp     $0600,x
        jsr     LF8B5
        iny
        pha
        lda     #$80
        sta     $0678
        pla
        cmp     $0600,x
        jsr     LF8BF
        iny
        pha
        lda     #$81
        sta     $0678
        pla
        cmp     $0600,x
        jsr     LF8C9
        iny
        pha
        lda     #$7F
        sta     $0678
        pla
        cmp     $0600,x
        jsr     LF8D3
        iny
        lda     #$40
        sta     $0678
        jsr     LF931
        sbc     $0600,x
        jsr     LF937
        iny
        lda     #$3F
        sta     $0678
        jsr     LF947
        sbc     $0600,x
        jsr     LF94C
        iny
        lda     #$41
        sta     $0678
        jsr     LF95C
        sbc     $0600,x
        jsr     LF962
        iny
        lda     #$00
        sta     $0678
        jsr     LF972
        sbc     $0600,x
        jsr     LF976
        iny
        lda     #$7F
        sta     $0678
        jsr     LF980
        sbc     $0600,x
        jsr     LF984
        lda     #$AA
        sta     $0633
        lda     #$BB
        sta     $0689
        ldx     #$00
        ldy     #$66
        bit     $01
        sec
        lda     #$00
        lda     $0633,x
        bpl     LE37C
        beq     LE37C
        bvc     LE37C
        bcc     LE37C
        cpy     #$66
        bne     LE37C
        cpx     #$00
        bne     LE37C
        cmp     #$AA
        beq     LE380
LE37C:  lda     #$6A
        sta     $00
LE380:  ldx     #$8A
        ldy     #$66
        clv
        clc
        lda     #$00
        lda     $05FF,x
        bpl     LE39F
        beq     LE39F
        bvs     LE39F
        bcs     LE39F
        cmp     #$BB
        bne     LE39F
        cpy     #$66
        bne     LE39F
        cpx     #$8A
        beq     LE3A3
LE39F:  lda     #$6B
        sta     $00
LE3A3:  bit     $01
        sec
        lda     #$44
        ldx     #$00
        sta     $0633,x
        lda     $0633
        bcc     LE3CC
        cmp     #$44
        bne     LE3CC
        bvc     LE3CC
        clc
        clv
        lda     #$99
        ldx     #$80
        sta     $0585,x
        lda     $0605
        bcs     LE3CC
        cmp     #$99
        bne     LE3CC
        bvc     LE3D0
LE3CC:  lda     #$6C
        sta     $00
LE3D0:  ldy     #$6D
        ldx     #$6D
        jsr     LF990
        sta     $0600,x
        lsr     $0600,x
        lda     $0600,x
        jsr     LF99D
        iny
        sta     $0600,x
        lsr     $0600,x
        lda     $0600,x
        jsr     LF9AD
        iny
        jsr     LF9BD
        sta     $0600,x
        asl     $0600,x
        lda     $0600,x
        jsr     LF9C3
        iny
        sta     $0600,x
        asl     $0600,x
        lda     $0600,x
        jsr     LF9D4
        iny
        jsr     LF9E4
        sta     $0600,x
        ror     $0600,x
        lda     $0600,x
        jsr     LF9EA
        iny
        sta     $0600,x
        ror     $0600,x
        lda     $0600,x
        jsr     LF9FB
        iny
        jsr     LFA0A
        sta     $0600,x
        rol     $0600,x
        lda     $0600,x
        jsr     LFA10
        iny
        sta     $0600,x
        rol     $0600,x
        lda     $0600,x
        jsr     LFA21
        lda     #$FF
        sta     $0600,x
        sta     $01
        bit     $01
        sec
        inc     $0600,x
        bne     LE463
        bmi     LE463
        bvc     LE463
        bcc     LE463
        lda     $0600,x
        cmp     #$00
        beq     LE467
LE463:  lda     #$75
        sta     $00
LE467:  lda     #$7F
        sta     $0600,x
        clv
        clc
        inc     $0600,x
        beq     LE480
        bpl     LE480
        bvs     LE480
        bcs     LE480
        lda     $0600,x
        cmp     #$80
        beq     LE484
LE480:  lda     #$76
        sta     $00
LE484:  lda     #$00
        sta     $0600,x
        bit     $01
        sec
        dec     $0600,x
        beq     LE49E
        bpl     LE49E
        bvc     LE49E
        bcc     LE49E
        lda     $0600,x
        cmp     #$FF
        beq     LE4A2
LE49E:  lda     #$77
        sta     $00
LE4A2:  lda     #$80
        sta     $0600,x
        clv
        clc
        dec     $0600,x
        beq     LE4BB
        bmi     LE4BB
        bvs     LE4BB
        bcs     LE4BB
        lda     $0600,x
        cmp     #$7F
        beq     LE4BF
LE4BB:  lda     #$78
        sta     $00
LE4BF:  lda     #$01
        sta     $0600,x
        dec     $0600,x
        beq     LE4CD
        lda     #$79
        sta     $00
LE4CD:  lda     #$33
        sta     $0678
        lda     #$44
        ldy     #$78
        ldx     #$00
        sec
        bit     $01
        ldx     $0600,y
        bcc     LE4F2
        bvc     LE4F2
        bmi     LE4F2
        beq     LE4F2
        cpx     #$33
        bne     LE4F2
        cpy     #$78
        bne     LE4F2
        cmp     #$44
        beq     LE4F6
LE4F2:  lda     #$7A
        sta     $00
LE4F6:  lda     #$97
        sta     $067F
        lda     #$47
        ldy     #$FF
        ldx     #$00
        clc
        clv
        ldx     $0580,y
        bcs     LE51A
        bvs     LE51A
        bpl     LE51A
        beq     LE51A
        cpx     #$97
        bne     LE51A
        cpy     #$FF
        bne     LE51A
        cmp     #$47
        beq     LE51E
LE51A:  lda     #$7B
        sta     $00
LE51E:  rts
        lda     #$55
        sta     $0580
        lda     #$AA
        sta     $0432
        lda     #$80
        sta     $43
        lda     #$05
        sta     $44
        lda     #$32
        sta     $45
        lda     #$04
        sta     $46
        ldx     #$03
        ldy     #$77
        lda     #$FF
        sta     $01
        bit     $01
        sec
        lda     #$00
        .byte   $A3
        rti
        nop
        nop
        nop
        nop
        beq     LE560
        bmi     LE560
        bvc     LE560
        bcc     LE560
        cmp     #$55
        bne     LE560
        cpx     #$55
        bne     LE560
        cpy     #$77
        beq     LE564
LE560:  lda     #$7C
        sta     $00
LE564:  ldx     #$05
        ldy     #$33
        clv
        clc
        lda     #$00
        .byte   $A3
        rti
        nop
        nop
        nop
        nop
        beq     LE586
        bpl     LE586
        bvs     LE586
        bcs     LE586
        cmp     #$AA
        bne     LE586
        cpx     #$AA
        bne     LE586
        cpy     #$33
        beq     LE58A
LE586:  lda     #$7D
        sta     $00
LE58A:  lda     #$87
        sta     $67
        lda     #$32
        sta     $68
        ldy     #$57
        bit     $01
        sec
        lda     #$00
        .byte   $A7
        .byte   $67
        nop
        nop
        nop
        nop
        beq     LE5B3
        bpl     LE5B3
        bvc     LE5B3
        bcc     LE5B3
        cmp     #$87
        bne     LE5B3
        cpx     #$87
        bne     LE5B3
        cpy     #$57
        beq     LE5B7
LE5B3:  lda     #$7E
        sta     $00
LE5B7:  ldy     #$53
        clv
        clc
        lda     #$00
        .byte   $A7
        pla
        nop
        nop
        nop
        nop
        beq     LE5D7
        bmi     LE5D7
        bvs     LE5D7
        bcs     LE5D7
        cmp     #$32
        bne     LE5D7
        cpx     #$32
        bne     LE5D7
        cpy     #$53
        beq     LE5DB
LE5D7:  lda     #$7F
        sta     $00
LE5DB:  lda     #$87
        sta     $0577
        lda     #$32
        sta     $0578
        ldy     #$57
        bit     $01
        sec
        lda     #$00
        .byte   $AF
        .byte   $77
        ora     $EA
        nop
        nop
        nop
        beq     LE607
        bpl     LE607
        bvc     LE607
        bcc     LE607
        cmp     #$87
        bne     LE607
        cpx     #$87
        bne     LE607
        cpy     #$57
        beq     LE60B
LE607:  lda     #$80
        sta     $00
LE60B:  ldy     #$53
        clv
        clc
        lda     #$00
        .byte   $AF
        sei
        ora     $EA
        nop
        nop
        nop
        beq     LE62C
        bmi     LE62C
        bvs     LE62C
        bcs     LE62C
        cmp     #$32
        bne     LE62C
        cpx     #$32
        bne     LE62C
        cpy     #$53
        beq     LE630
LE62C:  lda     #$81
        sta     $00
LE630:  lda     #$FF
        sta     $43
        lda     #$04
        sta     $44
        lda     #$32
        sta     $45
        lda     #$04
        sta     $46
        lda     #$55
        sta     $0580
        lda     #$AA
        sta     $0432
        ldx     #$03
        ldy     #$81
        bit     $01
        sec
        lda     #$00
        .byte   $B3
        .byte   $43
        nop
        nop
        nop
        nop
        beq     LE66D
        bmi     LE66D
        bvc     LE66D
        bcc     LE66D
        cmp     #$55
        bne     LE66D
        cpx     #$55
        bne     LE66D
        cpy     #$81
        beq     LE671
LE66D:  lda     #$82
        sta     $00
LE671:  ldx     #$05
        ldy     #$00
        clv
        clc
        lda     #$00
        .byte   $B3
        eor     $EA
        nop
        nop
        nop
        beq     LE693
        bpl     LE693
        bvs     LE693
        bcs     LE693
        cmp     #$AA
        bne     LE693
        cpx     #$AA
        bne     LE693
        cpy     #$00
        beq     LE697
LE693:  lda     #$83
        sta     $00
LE697:  lda     #$87
        sta     $67
        lda     #$32
        sta     $68
        ldy     #$57
        bit     $01
        sec
        lda     #$00
        .byte   $B7
        bpl     LE693
        nop
        nop
        nop
        beq     LE6C0
        bpl     LE6C0
        bvc     LE6C0
        bcc     LE6C0
        cmp     #$87
        bne     LE6C0
        cpx     #$87
        bne     LE6C0
        cpy     #$57
        beq     LE6C4
LE6C0:  lda     #$84
        sta     $00
LE6C4:  ldy     #$FF
        clv
        clc
        lda     #$00
        .byte   $B7
        adc     #$EA
        nop
        nop
        nop
        beq     LE6E4
        bmi     LE6E4
        bvs     LE6E4
        bcs     LE6E4
        cmp     #$32
        bne     LE6E4
        cpx     #$32
        bne     LE6E4
LE6E0:  cpy     #$FF
        beq     LE6E8
LE6E4:  lda     #$85
        sta     $00
LE6E8:  lda     #$87
        sta     $0587
        lda     #$32
        sta     $0588
        ldy     #$30
        bit     $01
        sec
        lda     #$00
        .byte   $BF
        .byte   $57
        ora     $EA
        nop
        nop
        nop
        beq     LE714
        bpl     LE714
        bvc     LE714
        bcc     LE714
        cmp     #$87
        bne     LE714
        cpx     #$87
        bne     LE714
        cpy     #$30
        beq     LE718
LE714:  lda     #$86
        sta     $00
LE718:  ldy     #$40
        clv
        clc
        lda     #$00
        .byte   $BF
        pha
        ora     $EA
        nop
        nop
        nop
        beq     LE739
        bmi     LE739
        bvs     LE739
        bcs     LE739
        cmp     #$32
        bne     LE739
        cpx     #$32
        bne     LE739
        cpy     #$40
        beq     LE73D
LE739:  lda     #$87
        sta     $00
LE73D:  rts
        lda     #$C0
        sta     $01
        lda     #$00
        sta     $0489
        lda     #$89
        sta     $60
        lda     #$04
        sta     $61
        ldy     #$44
        ldx     #$17
        lda     #$3E
        bit     $01
        clc
        .byte   $83
        eor     #$EA
        nop
        nop
        nop
        bne     LE779
        bcs     LE779
        bvc     LE779
        bpl     LE779
        cmp     #$3E
        bne     LE779
        cpy     #$44
        bne     LE779
        cpx     #$17
        bne     LE779
        lda     $0489
        cmp     #$16
        beq     LE77D
LE779:  lda     #$88
        sta     $00
LE77D:  ldy     #$44
        ldx     #$7A
        lda     #$66
        sec
        clv
        .byte   $83
        inc     $EA
        nop
        nop
        nop
        beq     LE7A6
        bcc     LE7A6
        bvs     LE7A6
        bmi     LE7A6
        cmp     #$66
        bne     LE7A6
        cpy     #$44
        bne     LE7A6
        cpx     #$7A
        bne     LE7A6
        lda     $0489
        cmp     #$62
        beq     LE7AA
LE7A6:  lda     #$89
        sta     $00
LE7AA:  lda     #$FF
        sta     $49
        ldy     #$44
        ldx     #$AA
        lda     #$55
        bit     $01
        clc
        .byte   $87
        eor     #$EA
        nop
        nop
        nop
        beq     LE7D7
        bcs     LE7D7
        bvc     LE7D7
        bpl     LE7D7
        cmp     #$55
        bne     LE7D7
        cpy     #$44
        bne     LE7D7
        cpx     #$AA
        bne     LE7D7
        lda     $49
        cmp     #$00
        beq     LE7DB
LE7D7:  lda     #$8A
        sta     $00
LE7DB:  lda     #$00
        sta     $56
        ldy     #$58
        ldx     #$EF
        lda     #$66
        sec
        clv
        .byte   $87
        lsr     $EA,x
        nop
        nop
        nop
        beq     LE807
        bcc     LE807
        bvs     LE807
        bmi     LE807
        cmp     #$66
        bne     LE807
        cpy     #$58
        bne     LE807
        cpx     #$EF
        bne     LE807
        lda     $56
        cmp     #$66
        beq     LE80B
LE807:  lda     #$8B
        sta     $00
LE80B:  lda     #$FF
        sta     $0549
        ldy     #$E5
        ldx     #$AF
        lda     #$F5
        bit     $01
        clc
        .byte   $8F
        eor     #$05
        nop
        nop
        nop
        nop
        beq     LE83B
        bcs     LE83B
        bvc     LE83B
        bpl     LE83B
        cmp     #$F5
        bne     LE83B
        cpy     #$E5
        bne     LE83B
        cpx     #$AF
        bne     LE83B
        lda     $0549
        cmp     #$A5
        beq     LE83F
LE83B:  lda     #$8C
        sta     $00
LE83F:  lda     #$00
        sta     $0556
        ldy     #$58
        ldx     #$B3
        lda     #$97
        sec
        clv
        .byte   $8F
        lsr     $05,x
        nop
        nop
        nop
        nop
        beq     LE86E
        bcc     LE86E
        bvs     LE86E
        bpl     LE86E
        cmp     #$97
        bne     LE86E
        cpy     #$58
        bne     LE86E
        cpx     #$B3
        bne     LE86E
        lda     $0556
        cmp     #$93
        beq     LE872
LE86E:  lda     #$8D
        sta     $00
LE872:  lda     #$FF
        sta     $49
        ldy     #$FF
        ldx     #$AA
        lda     #$55
        bit     $01
        clc
        .byte   $97
        lsr     a
        nop
        nop
        nop
        nop
        beq     LE89F
        bcs     LE89F
        bvc     LE89F
        bpl     LE89F
        cmp     #$55
        bne     LE89F
        cpy     #$FF
        bne     LE89F
        cpx     #$AA
        bne     LE89F
        lda     $49
        .byte   $C9
LE89C:  brk
        beq     LE8A3
LE89F:  lda     #$8E
        sta     $00
LE8A3:  lda     #$00
        sta     $56
        ldy     #$06
        ldx     #$EF
        lda     #$66
        sec
        clv
        .byte   $97
        bvc     LE89C
        nop
        nop
        nop
        beq     LE8CF
        bcc     LE8CF
        bvs     LE8CF
        bmi     LE8CF
        cmp     #$66
        bne     LE8CF
        cpy     #$06
        bne     LE8CF
        cpx     #$EF
        bne     LE8CF
        lda     $56
        cmp     #$66
        beq     LE8D3
LE8CF:  lda     #$8F
        sta     $00
LE8D3:  rts
        ldy     #$90
        jsr     LF931
        .byte   $EB
        rti
        nop
        nop
        nop
        nop
        jsr     LF937
        iny
        jsr     LF947
        .byte   $EB
        .byte   $3F
        nop
        nop
        nop
        nop
        jsr     LF94C
        iny
        jsr     LF95C
        .byte   $EB
        eor     ($EA,x)
        nop
        nop
        nop
        jsr     LF962
        iny
        jsr     LF972
        .byte   $EB
        brk
        nop
        nop
        nop
        nop
        jsr     LF976
        iny
        jsr     LF980
        .byte   $EB
        .byte   $7F
        nop
        nop
        nop
        nop
        jsr     LF984
LE916:  rts
        lda     #$FF
        sta     $01
        ldy     #$95
        ldx     #$02
        lda     #$47
        sta     $47
        lda     #$06
        sta     $48
        lda     #$EB
        sta     $0647
        jsr     LFA31
        .byte   $C3
        eor     $EA
        nop
        nop
        nop
        jsr     LFA37
        lda     $0647
        cmp     #$EA
        beq     LE941
        sty     $00
LE941:  iny
        lda     #$00
        sta     $0647
        jsr     LFA42
        .byte   $C3
        eor     $EA
        nop
        nop
        nop
        jsr     LFA47
        lda     $0647
        cmp     #$FF
        beq     LE95C
        sty     $00
LE95C:  iny
        lda     #$37
        sta     $0647
        jsr     LFA54
        .byte   $C3
        eor     $EA
        nop
        nop
        nop
        jsr     LFA59
        lda     $0647
        cmp     #$36
        beq     LE977
        sty     $00
LE977:  iny
        lda     #$EB
        sta     $47
        jsr     LFA31
        .byte   $C7
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFA37
        lda     $47
        cmp     #$EA
        beq     LE990
        sty     $00
LE990:  iny
        lda     #$00
        sta     $47
        jsr     LFA42
        .byte   $C7
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFA47
        lda     $47
        cmp     #$FF
        beq     LE9A9
        sty     $00
LE9A9:  iny
        lda     #$37
        sta     $47
        jsr     LFA54
        .byte   $C7
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFA59
        lda     $47
        cmp     #$36
        beq     LE9C2
        sty     $00
LE9C2:  iny
        lda     #$EB
        sta     $0647
        jsr     LFA31
        .byte   $CF
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFA37
        lda     $0647
        cmp     #$EA
        beq     LE9DE
        sty     $00
LE9DE:  iny
        lda     #$00
        sta     $0647
        jsr     LFA42
        .byte   $CF
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFA47
        lda     $0647
        cmp     #$FF
        beq     LE9FA
        sty     $00
LE9FA:  iny
        lda     #$37
        sta     $0647
        jsr     LFA54
        .byte   $CF
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFA59
        lda     $0647
        cmp     #$36
        beq     LEA16
        sty     $00
LEA16:  lda     #$EB
        sta     $0647
        lda     #$48
        sta     $45
        lda     #$05
        sta     $46
        ldy     #$FF
        jsr     LFA31
        .byte   $D3
        eor     $EA
        nop
        php
        pha
        ldy     #$9E
        pla
        plp
        jsr     LFA37
        lda     $0647
        cmp     #$EA
        beq     LEA3E
        sty     $00
LEA3E:  ldy     #$FF
        lda     #$00
        sta     $0647
        jsr     LFA42
        .byte   $D3
        eor     $EA
        nop
        php
        pha
        ldy     #$9F
        pla
        plp
        jsr     LFA47
        lda     $0647
        cmp     #$FF
        beq     LEA5E
        sty     $00
LEA5E:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFA54
        .byte   $D3
        eor     $EA
        nop
        php
        pha
        ldy     #$A0
        pla
        plp
        jsr     LFA59
        lda     $0647
        cmp     #$36
        beq     LEA7E
        sty     $00
LEA7E:  ldy     #$A1
        ldx     #$FF
        lda     #$EB
        sta     $47
        jsr     LFA31
        .byte   $D7
        pha
        nop
        nop
        nop
        nop
        jsr     LFA37
        lda     $47
        cmp     #$EA
        beq     LEA9A
        sty     $00
LEA9A:  iny
        lda     #$00
        sta     $47
        jsr     LFA42
        .byte   $D7
        pha
        nop
        nop
        nop
        nop
        jsr     LFA47
        lda     $47
        cmp     #$FF
        beq     LEAB3
        sty     $00
LEAB3:  iny
        lda     #$37
        sta     $47
        jsr     LFA54
        .byte   $D7
        pha
        nop
        nop
        nop
        nop
        jsr     LFA59
        lda     $47
        cmp     #$36
        beq     LEACC
        sty     $00
LEACC:  lda     #$EB
        sta     $0647
        ldy     #$FF
        jsr     LFA31
        .byte   $DB
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$A4
        pla
        plp
        jsr     LFA37
        lda     $0647
        cmp     #$EA
        beq     LEAED
        sty     $00
LEAED:  ldy     #$FF
        lda     #$00
        sta     $0647
        jsr     LFA42
        .byte   $DB
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$A5
        pla
        plp
        jsr     LFA47
        lda     $0647
        cmp     #$FF
        beq     LEB0E
        sty     $00
LEB0E:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFA54
        .byte   $DB
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$A6
        pla
        plp
        jsr     LFA59
        lda     $0647
        cmp     #$36
        beq     LEB2F
        sty     $00
LEB2F:  ldy     #$A7
        ldx     #$FF
        lda     #$EB
        sta     $0647
        jsr     LFA31
        .byte   $DF
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFA37
        lda     $0647
        cmp     #$EA
        beq     LEB4E
        sty     $00
LEB4E:  iny
        lda     #$00
        sta     $0647
        jsr     LFA42
        .byte   $DF
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFA47
        lda     $0647
        cmp     #$FF
        beq     LEB6A
        sty     $00
LEB6A:  iny
        lda     #$37
        sta     $0647
        jsr     LFA54
        .byte   $DF
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFA59
        lda     $0647
        cmp     #$36
        beq     LEB86
        sty     $00
LEB86:  rts
        lda     #$FF
        sta     $01
        ldy     #$AA
        ldx     #$02
        lda     #$47
        sta     $47
        lda     #$06
        sta     $48
        lda     #$EB
        sta     $0647
        jsr     LFAB1
        .byte   $E3
        eor     $EA
        nop
        nop
        nop
        jsr     LFAB7
        lda     $0647
        cmp     #$EC
        beq     LEBB1
        sty     $00
LEBB1:  iny
        lda     #$FF
        sta     $0647
        jsr     LFAC2
        .byte   $E3
        eor     $EA
        nop
        nop
        nop
        jsr     LFAC7
        lda     $0647
        cmp     #$00
        beq     LEBCC
        sty     $00
LEBCC:  iny
        lda     #$37
        sta     $0647
        jsr     LFAD4
        .byte   $E3
        eor     $EA
        nop
        nop
        nop
        jsr     LFADA
        lda     $0647
        cmp     #$38
        beq     LEBE7
        sty     $00
LEBE7:  iny
        lda     #$EB
        sta     $47
        jsr     LFAB1
        .byte   $E7
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFAB7
        lda     $47
        cmp     #$EC
        beq     LEC00
        sty     $00
LEC00:  iny
        lda     #$FF
        sta     $47
        jsr     LFAC2
        .byte   $E7
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFAC7
        lda     $47
        cmp     #$00
        beq     LEC19
        sty     $00
LEC19:  iny
        lda     #$37
        sta     $47
        jsr     LFAD4
        .byte   $E7
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFADA
        lda     $47
        cmp     #$38
        beq     LEC32
        sty     $00
LEC32:  iny
        lda     #$EB
        sta     $0647
        jsr     LFAB1
        .byte   $EF
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFAB7
        lda     $0647
        cmp     #$EC
        beq     LEC4E
        sty     $00
LEC4E:  iny
        lda     #$FF
        sta     $0647
        jsr     LFAC2
        .byte   $EF
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFAC7
        lda     $0647
        cmp     #$00
        beq     LEC6A
        sty     $00
LEC6A:  iny
        lda     #$37
        sta     $0647
        jsr     LFAD4
        .byte   $EF
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFADA
        lda     $0647
        cmp     #$38
        beq     LEC86
        sty     $00
LEC86:  lda     #$EB
        sta     $0647
        lda     #$48
        sta     $45
        lda     #$05
        sta     $46
        ldy     #$FF
        jsr     LFAB1
        .byte   $F3
        eor     $EA
        nop
        php
        pha
        ldy     #$B3
        pla
        plp
        jsr     LFAB7
        lda     $0647
        cmp     #$EC
        beq     LECAE
        sty     $00
LECAE:  ldy     #$FF
        lda     #$FF
        sta     $0647
        jsr     LFAC2
        .byte   $F3
        eor     $EA
        nop
        php
        pha
        ldy     #$B4
        pla
        plp
        jsr     LFAC7
        lda     $0647
        cmp     #$00
        beq     LECCE
        sty     $00
LECCE:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFAD4
        .byte   $F3
        eor     $EA
        nop
        php
        pha
        ldy     #$B5
        pla
        plp
        jsr     LFADA
        lda     $0647
        cmp     #$38
        beq     LECEE
        sty     $00
LECEE:  ldy     #$B6
        ldx     #$FF
        lda     #$EB
        sta     $47
        jsr     LFAB1
        .byte   $F7
        pha
        nop
        nop
        nop
        nop
        jsr     LFAB7
        lda     $47
        cmp     #$EC
        beq     LED0A
        sty     $00
LED0A:  iny
        lda     #$FF
        sta     $47
        jsr     LFAC2
        .byte   $F7
        pha
        nop
        nop
        nop
        nop
        jsr     LFAC7
        lda     $47
        cmp     #$00
        beq     LED23
        sty     $00
LED23:  iny
        lda     #$37
        sta     $47
        jsr     LFAD4
        .byte   $F7
        pha
        nop
        nop
        nop
        nop
        jsr     LFADA
        lda     $47
        cmp     #$38
        beq     LED3C
        sty     $00
LED3C:  lda     #$EB
        sta     $0647
        ldy     #$FF
        jsr     LFAB1
        .byte   $FB
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$B9
        pla
        plp
        jsr     LFAB7
        lda     $0647
        cmp     #$EC
        beq     LED5D
        sty     $00
LED5D:  ldy     #$FF
        lda     #$FF
        sta     $0647
        jsr     LFAC2
        .byte   $FB
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$BA
        pla
        plp
        jsr     LFAC7
        lda     $0647
        cmp     #$00
        beq     LED7E
        sty     $00
LED7E:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFAD4
        .byte   $FB
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$BB
        pla
        plp
        jsr     LFADA
        lda     $0647
        cmp     #$38
        beq     LED9F
        sty     $00
LED9F:  ldy     #$BC
        ldx     #$FF
        lda     #$EB
        sta     $0647
        jsr     LFAB1
        .byte   $FF
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFAB7
        lda     $0647
        cmp     #$EC
        beq     LEDBE
        sty     $00
LEDBE:  iny
        lda     #$FF
        sta     $0647
        jsr     LFAC2
        .byte   $FF
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFAC7
        lda     $0647
        cmp     #$00
        beq     LEDDA
        sty     $00
LEDDA:  iny
        lda     #$37
        sta     $0647
        jsr     LFAD4
        .byte   $FF
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFADA
        lda     $0647
        cmp     #$38
        beq     LEDF6
        sty     $00
LEDF6:  rts
        lda     #$FF
        sta     $01
        ldy     #$BF
        ldx     #$02
        lda     #$47
        sta     $47
        lda     #$06
        sta     $48
        lda     #$A5
        sta     $0647
        jsr     LFA7B
        .byte   $03
        eor     $EA
        nop
        nop
        nop
        jsr     LFA81
        lda     $0647
        cmp     #$4A
        beq     LEE21
        sty     $00
LEE21:  iny
        lda     #$29
        sta     $0647
        jsr     LFA8C
        .byte   $03
        eor     $EA
        nop
        nop
        nop
        jsr     LFA91
        lda     $0647
        cmp     #$52
        beq     LEE3C
        sty     $00
LEE3C:  iny
        lda     #$37
        sta     $0647
        jsr     LFA9E
        .byte   $03
        eor     $EA
        nop
        nop
        nop
        jsr     LFAA4
        lda     $0647
        cmp     #$6E
        beq     LEE57
        sty     $00
LEE57:  iny
        lda     #$A5
        sta     $47
        jsr     LFA7B
        .byte   $07
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFA81
        lda     $47
        cmp     #$4A
        beq     LEE70
        sty     $00
LEE70:  iny
        lda     #$29
        sta     $47
        jsr     LFA8C
        .byte   $07
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFA91
        lda     $47
        cmp     #$52
        beq     LEE89
        sty     $00
LEE89:  iny
        lda     #$37
        sta     $47
        jsr     LFA9E
        .byte   $07
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFAA4
        lda     $47
        cmp     #$6E
        beq     LEEA2
        sty     $00
LEEA2:  iny
        lda     #$A5
        sta     $0647
        jsr     LFA7B
        .byte   $0F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFA81
        lda     $0647
        cmp     #$4A
        beq     LEEBE
        sty     $00
LEEBE:  iny
        lda     #$29
        sta     $0647
        jsr     LFA8C
        .byte   $0F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFA91
        lda     $0647
        cmp     #$52
        beq     LEEDA
        sty     $00
LEEDA:  iny
        lda     #$37
        sta     $0647
        jsr     LFA9E
        .byte   $0F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFAA4
        lda     $0647
        cmp     #$6E
        beq     LEEF6
        sty     $00
LEEF6:  lda     #$A5
        sta     $0647
        lda     #$48
        sta     $45
        lda     #$05
        sta     $46
        ldy     #$FF
        jsr     LFA7B
        .byte   $13
        eor     $EA
        nop
        php
        pha
        ldy     #$C8
        pla
        plp
        jsr     LFA81
        lda     $0647
        cmp     #$4A
        beq     LEF1E
        sty     $00
LEF1E:  ldy     #$FF
        lda     #$29
        sta     $0647
        jsr     LFA8C
        .byte   $13
        eor     $EA
        nop
        php
        pha
        ldy     #$C9
        pla
        plp
        jsr     LFA91
        lda     $0647
        cmp     #$52
        beq     LEF3E
        sty     $00
LEF3E:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFA9E
        .byte   $13
        eor     $EA
        nop
        php
        pha
        ldy     #$CA
        pla
        plp
        jsr     LFAA4
        lda     $0647
        cmp     #$6E
        beq     LEF5E
        sty     $00
LEF5E:  ldy     #$CB
        ldx     #$FF
        lda     #$A5
        sta     $47
        jsr     LFA7B
        .byte   $17
        pha
        nop
        nop
        nop
        nop
        jsr     LFA81
        lda     $47
        cmp     #$4A
        beq     LEF7A
        sty     $00
LEF7A:  iny
        lda     #$29
        sta     $47
        jsr     LFA8C
        .byte   $17
        pha
        nop
        nop
        nop
        nop
        jsr     LFA91
        lda     $47
        cmp     #$52
        beq     LEF93
        sty     $00
LEF93:  iny
        lda     #$37
        sta     $47
        jsr     LFA9E
        .byte   $17
        pha
        nop
        nop
        nop
        nop
        jsr     LFAA4
        lda     $47
        cmp     #$6E
        beq     LEFAC
        sty     $00
LEFAC:  lda     #$A5
        sta     $0647
        ldy     #$FF
        jsr     LFA7B
        .byte   $1B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$CE
        pla
        plp
        jsr     LFA81
        lda     $0647
        cmp     #$4A
        beq     LEFCD
        sty     $00
LEFCD:  ldy     #$FF
        lda     #$29
        sta     $0647
        jsr     LFA8C
        .byte   $1B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$CF
        pla
        plp
        jsr     LFA91
        lda     $0647
        cmp     #$52
        beq     LEFEE
        sty     $00
LEFEE:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFA9E
        .byte   $1B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$D0
        pla
        plp
        jsr     LFAA4
        lda     $0647
        cmp     #$6E
        beq     LF00F
        sty     $00
LF00F:  ldy     #$D1
        ldx     #$FF
        lda     #$A5
        sta     $0647
        jsr     LFA7B
        .byte   $1F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFA81
        lda     $0647
        cmp     #$4A
        beq     LF02E
        sty     $00
LF02E:  iny
        lda     #$29
        sta     $0647
        jsr     LFA8C
        .byte   $1F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFA91
        lda     $0647
        cmp     #$52
        beq     LF04A
        sty     $00
LF04A:  iny
        lda     #$37
        sta     $0647
        jsr     LFA9E
        .byte   $1F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFAA4
        lda     $0647
        cmp     #$6E
        beq     LF066
        sty     $00
LF066:  rts
        lda     #$FF
        sta     $01
        ldy     #$D4
        ldx     #$02
        lda     #$47
        sta     $47
        lda     #$06
        sta     $48
        lda     #$A5
        sta     $0647
        jsr     LFB53
        .byte   $23
        eor     $EA
        nop
        nop
        nop
        jsr     LFB59
        lda     $0647
        cmp     #$4A
        beq     LF091
        sty     $00
LF091:  iny
        lda     #$29
        sta     $0647
        jsr     LFB64
        .byte   $23
        eor     $EA
        nop
        nop
        nop
        jsr     LFB69
        lda     $0647
        cmp     #$52
        beq     LF0AC
        sty     $00
LF0AC:  iny
        lda     #$37
        sta     $0647
        jsr     LFA68
        .byte   $23
        eor     $EA
        nop
        nop
        nop
        jsr     LFA6E
        lda     $0647
        cmp     #$6F
        beq     LF0C7
        sty     $00
LF0C7:  iny
        lda     #$A5
        sta     $47
        jsr     LFB53
        .byte   $27
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFB59
        lda     $47
        cmp     #$4A
        beq     LF0E0
        sty     $00
LF0E0:  iny
        lda     #$29
        sta     $47
        jsr     LFB64
        .byte   $27
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFB69
        lda     $47
        cmp     #$52
        beq     LF0F9
        sty     $00
LF0F9:  iny
        lda     #$37
        sta     $47
        jsr     LFA68
        .byte   $27
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFA6E
        lda     $47
        cmp     #$6F
        beq     LF112
        sty     $00
LF112:  iny
        lda     #$A5
        sta     $0647
        jsr     LFB53
        .byte   $2F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFB59
        lda     $0647
        cmp     #$4A
        beq     LF12E
        sty     $00
LF12E:  iny
        lda     #$29
        sta     $0647
        jsr     LFB64
        .byte   $2F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFB69
        lda     $0647
        cmp     #$52
        beq     LF14A
        sty     $00
LF14A:  iny
        lda     #$37
        sta     $0647
        jsr     LFA68
        .byte   $2F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFA6E
        lda     $0647
        cmp     #$6F
        beq     LF166
        sty     $00
LF166:  lda     #$A5
        sta     $0647
        lda     #$48
        sta     $45
        lda     #$05
        sta     $46
        ldy     #$FF
        jsr     LFB53
        .byte   $33
        eor     $EA
        nop
        php
        pha
        ldy     #$DD
        pla
        plp
        jsr     LFB59
        lda     $0647
        cmp     #$4A
        beq     LF18E
        sty     $00
LF18E:  ldy     #$FF
        lda     #$29
        sta     $0647
        jsr     LFB64
        .byte   $33
        eor     $EA
        nop
        php
        pha
        ldy     #$DE
        pla
        plp
        jsr     LFB69
        lda     $0647
        cmp     #$52
        beq     LF1AE
        sty     $00
LF1AE:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFA68
        .byte   $33
        eor     $EA
        nop
        php
        pha
        ldy     #$DF
        pla
        plp
        jsr     LFA6E
        lda     $0647
        cmp     #$6F
        beq     LF1CE
        sty     $00
LF1CE:  ldy     #$E0
        ldx     #$FF
        lda     #$A5
        sta     $47
        jsr     LFB53
        .byte   $37
        pha
        nop
        nop
        nop
        nop
        jsr     LFB59
        lda     $47
        cmp     #$4A
        beq     LF1EA
        sty     $00
LF1EA:  iny
        lda     #$29
        sta     $47
        jsr     LFB64
        .byte   $37
        pha
        nop
        nop
        nop
        nop
        jsr     LFB69
        lda     $47
        cmp     #$52
        beq     LF203
        sty     $00
LF203:  iny
        lda     #$37
        sta     $47
        jsr     LFA68
        .byte   $37
        pha
        nop
        nop
        nop
        nop
        jsr     LFA6E
        lda     $47
        cmp     #$6F
        beq     LF21C
        sty     $00
LF21C:  lda     #$A5
        sta     $0647
        ldy     #$FF
        jsr     LFB53
        .byte   $3B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$E3
        pla
        plp
        jsr     LFB59
        lda     $0647
        cmp     #$4A
        beq     LF23D
        sty     $00
LF23D:  ldy     #$FF
        lda     #$29
        sta     $0647
        jsr     LFB64
        .byte   $3B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$E4
        pla
        plp
        jsr     LFB69
        lda     $0647
        cmp     #$52
        beq     LF25E
        sty     $00
LF25E:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFA68
        .byte   $3B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$E5
        pla
        plp
        jsr     LFA6E
        lda     $0647
        cmp     #$6F
        beq     LF27F
        sty     $00
LF27F:  ldy     #$E6
        ldx     #$FF
        lda     #$A5
        sta     $0647
        jsr     LFB53
        .byte   $3F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFB59
        lda     $0647
        cmp     #$4A
        beq     LF29E
        sty     $00
LF29E:  iny
        lda     #$29
        sta     $0647
        jsr     LFB64
        .byte   $3F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFB69
        lda     $0647
        cmp     #$52
        beq     LF2BA
        sty     $00
LF2BA:  iny
        lda     #$37
        sta     $0647
        jsr     LFA68
        .byte   $3F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFA6E
        lda     $0647
        cmp     #$6F
        beq     LF2D6
        sty     $00
LF2D6:  rts
        lda     #$FF
        sta     $01
        ldy     #$E9
        ldx     #$02
        lda     #$47
        sta     $47
        lda     #$06
        sta     $48
        lda     #$A5
        sta     $0647
        jsr     LFB1D
        .byte   $43
        eor     $EA
        nop
        nop
        nop
        jsr     LFB23
        lda     $0647
        cmp     #$52
        beq     LF301
        sty     $00
LF301:  iny
        lda     #$29
        sta     $0647
        jsr     LFB2E
        .byte   $43
        eor     $EA
        nop
        nop
        nop
        jsr     LFB33
        lda     $0647
        cmp     #$14
        beq     LF31C
        sty     $00
LF31C:  iny
        lda     #$37
        sta     $0647
        jsr     LFB40
        .byte   $43
        eor     $EA
        nop
        nop
        nop
        jsr     LFB46
        lda     $0647
        cmp     #$1B
        beq     LF337
        sty     $00
LF337:  iny
        lda     #$A5
        sta     $47
        jsr     LFB1D
        .byte   $47
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFB23
        lda     $47
        cmp     #$52
        beq     LF350
        sty     $00
LF350:  iny
        lda     #$29
        sta     $47
        jsr     LFB2E
        .byte   $47
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFB33
        lda     $47
        cmp     #$14
        beq     LF369
        sty     $00
LF369:  iny
        lda     #$37
        sta     $47
        jsr     LFB40
        .byte   $47
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFB46
        lda     $47
        cmp     #$1B
        beq     LF382
        sty     $00
LF382:  iny
        lda     #$A5
        sta     $0647
        jsr     LFB1D
        .byte   $4F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFB23
        lda     $0647
        cmp     #$52
        beq     LF39E
        sty     $00
LF39E:  iny
        lda     #$29
        sta     $0647
        jsr     LFB2E
        .byte   $4F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFB33
        lda     $0647
        cmp     #$14
        beq     LF3BA
        sty     $00
LF3BA:  iny
        lda     #$37
        sta     $0647
        jsr     LFB40
        .byte   $4F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFB46
        lda     $0647
        cmp     #$1B
        beq     LF3D6
        sty     $00
LF3D6:  lda     #$A5
        sta     $0647
        lda     #$48
        sta     $45
        lda     #$05
        sta     $46
        ldy     #$FF
        jsr     LFB1D
        .byte   $53
        eor     $EA
        nop
        php
        pha
        ldy     #$F2
        pla
        plp
        jsr     LFB23
        lda     $0647
        cmp     #$52
        beq     LF3FE
        sty     $00
LF3FE:  ldy     #$FF
        lda     #$29
        sta     $0647
        jsr     LFB2E
        .byte   $53
        eor     $EA
        nop
        php
        pha
        ldy     #$F3
        pla
        plp
        jsr     LFB33
        lda     $0647
        cmp     #$14
        beq     LF41E
        sty     $00
LF41E:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFB40
        .byte   $53
        eor     $EA
        nop
        php
        pha
        ldy     #$F4
        pla
        plp
        jsr     LFB46
        lda     $0647
        cmp     #$1B
        beq     LF43E
        sty     $00
LF43E:  ldy     #$F5
        ldx     #$FF
        lda     #$A5
        sta     $47
        jsr     LFB1D
        .byte   $57
        pha
        nop
        nop
        nop
        nop
        jsr     LFB23
        lda     $47
        cmp     #$52
        beq     LF45A
        sty     $00
LF45A:  iny
        lda     #$29
        sta     $47
        jsr     LFB2E
        .byte   $57
        pha
        nop
        nop
        nop
        nop
        jsr     LFB33
        lda     $47
        cmp     #$14
        beq     LF473
        sty     $00
LF473:  iny
        lda     #$37
        sta     $47
        jsr     LFB40
        .byte   $57
        pha
        nop
        nop
        nop
        nop
        jsr     LFB46
        lda     $47
        cmp     #$1B
        beq     LF48C
        sty     $00
LF48C:  lda     #$A5
        sta     $0647
        ldy     #$FF
        jsr     LFB1D
        .byte   $5B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$F8
        pla
        plp
        jsr     LFB23
        lda     $0647
        cmp     #$52
        beq     LF4AD
        sty     $00
LF4AD:  ldy     #$FF
        lda     #$29
        sta     $0647
        jsr     LFB2E
        .byte   $5B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$F9
        pla
        plp
        jsr     LFB33
        lda     $0647
        cmp     #$14
        beq     LF4CE
        sty     $00
LF4CE:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFB40
        .byte   $5B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$FA
        pla
        plp
        jsr     LFB46
        lda     $0647
        cmp     #$1B
        beq     LF4EF
        sty     $00
LF4EF:  ldy     #$FB
        ldx     #$FF
        lda     #$A5
        sta     $0647
        jsr     LFB1D
        .byte   $5F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFB23
        lda     $0647
        cmp     #$52
        beq     LF50E
        sty     $00
LF50E:  iny
        lda     #$29
        sta     $0647
        jsr     LFB2E
        .byte   $5F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFB33
        lda     $0647
        cmp     #$14
        beq     LF52A
        sty     $00
LF52A:  iny
        lda     #$37
        sta     $0647
        jsr     LFB40
        .byte   $5F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFB46
        lda     $0647
        cmp     #$1B
        beq     LF546
        sty     $00
LF546:  rts
        lda     #$FF
        sta     $01
        ldy     #$01
        ldx     #$02
        lda     #$47
        sta     $47
        lda     #$06
        sta     $48
        lda     #$A5
        sta     $0647
        jsr     LFAE9
        .byte   $63
        eor     $EA
        nop
        nop
        nop
        jsr     LFAEF
        lda     $0647
        cmp     #$52
        beq     LF571
        sty     $00
LF571:  iny
        lda     #$29
        sta     $0647
        jsr     LFAFA
        .byte   $63
        eor     $EA
        nop
        nop
        nop
        jsr     LFAFF
        lda     $0647
        cmp     #$14
        beq     LF58C
        sty     $00
LF58C:  iny
        lda     #$37
        sta     $0647
        jsr     LFB0A
        .byte   $63
        eor     $EA
        nop
        nop
        nop
        jsr     LFB10
        lda     $0647
        cmp     #$9B
        beq     LF5A7
        sty     $00
LF5A7:  iny
        lda     #$A5
        sta     $47
        jsr     LFAE9
        .byte   $67
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFAEF
        lda     $47
        cmp     #$52
        beq     LF5C0
        sty     $00
LF5C0:  iny
        lda     #$29
        sta     $47
        jsr     LFAFA
        .byte   $67
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFAFF
        lda     $47
        cmp     #$14
        beq     LF5D9
        sty     $00
LF5D9:  iny
        lda     #$37
        sta     $47
        jsr     LFB0A
        .byte   $67
        .byte   $47
        nop
        nop
        nop
        nop
        jsr     LFB10
        lda     $47
        cmp     #$9B
        beq     LF5F2
        sty     $00
LF5F2:  iny
        lda     #$A5
        sta     $0647
        jsr     LFAE9
        .byte   $6F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFAEF
        lda     $0647
        cmp     #$52
        beq     LF60E
        sty     $00
LF60E:  iny
        lda     #$29
        sta     $0647
        jsr     LFAFA
        .byte   $6F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFAFF
        lda     $0647
        cmp     #$14
        beq     LF62A
        sty     $00
LF62A:  iny
        lda     #$37
        sta     $0647
        jsr     LFB0A
        .byte   $6F
        .byte   $47
        asl     $EA
        nop
        nop
        nop
        jsr     LFB10
        lda     $0647
        cmp     #$9B
        beq     LF646
        sty     $00
LF646:  lda     #$A5
        sta     $0647
        lda     #$48
        sta     $45
        lda     #$05
        sta     $46
        ldy     #$FF
        jsr     LFAE9
        .byte   $73
        eor     $EA
        nop
        php
        pha
        ldy     #$0A
        pla
        plp
        jsr     LFAEF
        lda     $0647
        cmp     #$52
        beq     LF66E
        sty     $00
LF66E:  ldy     #$FF
        lda     #$29
        sta     $0647
        jsr     LFAFA
        .byte   $73
        eor     $EA
        nop
        php
        pha
        ldy     #$0B
        pla
        plp
        jsr     LFAFF
        lda     $0647
        cmp     #$14
        beq     LF68E
        sty     $00
LF68E:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFB0A
        .byte   $73
        eor     $EA
        nop
        php
        pha
        ldy     #$0C
        pla
        plp
        jsr     LFB10
        lda     $0647
        cmp     #$9B
        beq     LF6AE
        sty     $00
LF6AE:  ldy     #$0D
        ldx     #$FF
        lda     #$A5
        sta     $47
        jsr     LFAE9
        .byte   $77
        pha
        nop
        nop
        nop
        nop
        jsr     LFAEF
        lda     $47
        cmp     #$52
        beq     LF6CA
        sty     $00
LF6CA:  iny
        lda     #$29
        sta     $47
        jsr     LFAFA
        .byte   $77
        pha
        nop
        nop
        nop
        nop
        jsr     LFAFF
        lda     $47
        cmp     #$14
        beq     LF6E3
        sty     $00
LF6E3:  iny
        lda     #$37
        sta     $47
        jsr     LFB0A
        .byte   $77
        pha
        nop
        nop
        nop
        nop
        jsr     LFB10
        lda     $47
        cmp     #$9B
        beq     LF6FC
        sty     $00
LF6FC:  lda     #$A5
        sta     $0647
        ldy     #$FF
        jsr     LFAE9
        .byte   $7B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$10
        pla
        plp
        jsr     LFAEF
        lda     $0647
        cmp     #$52
        beq     LF71D
        sty     $00
LF71D:  ldy     #$FF
        lda     #$29
        sta     $0647
        jsr     LFAFA
        .byte   $7B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$11
        pla
        plp
        jsr     LFAFF
        lda     $0647
        cmp     #$14
        beq     LF73E
        sty     $00
LF73E:  ldy     #$FF
        lda     #$37
        sta     $0647
        jsr     LFB0A
        .byte   $7B
        pha
        ora     $EA
        nop
        php
        pha
        ldy     #$12
        pla
        plp
        jsr     LFB10
        lda     $0647
        cmp     #$9B
        beq     LF75F
        sty     $00
LF75F:  ldy     #$13
        ldx     #$FF
        lda     #$A5
        sta     $0647
        jsr     LFAE9
        .byte   $7F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFAEF
        lda     $0647
        cmp     #$52
        beq     LF77E
        sty     $00
LF77E:  iny
        lda     #$29
        sta     $0647
        jsr     LFAFA
        .byte   $7F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFAFF
        lda     $0647
        cmp     #$14
        beq     LF79A
        sty     $00
LF79A:  iny
        lda     #$37
        sta     $0647
        jsr     LFB0A
        .byte   $7F
        pha
        ora     $EA
        nop
        nop
        nop
        jsr     LFB10
        lda     $0647
        cmp     #$9B
        beq     LF7B6
        sty     $00
LF7B6:  rts
        clc
        lda     #$FF
        sta     $01
        bit     $01
        lda     #$55
LF7C0:  rts
        bcs     LF7CC
        bpl     LF7CC
        cmp     #$FF
        bne     LF7CC
        bvc     LF7CC
        rts
LF7CC:  sty     $00
LF7CE:  rts
        sec
        clv
        lda     #$00
LF7D3:  rts
        bne     LF7DD
        bvs     LF7DD
        bcc     LF7DD
        bmi     LF7DD
        rts
LF7DD:  sty     $00
LF7DF:  rts
        clc
        bit     $01
        lda     #$55
LF7E5:  rts
        bne     LF7EF
        bvc     LF7EF
        bcs     LF7EF
        bmi     LF7EF
        rts
LF7EF:  sty     $00
LF7F1:  rts
        sec
        clv
        lda     #$F8
LF7F6:  rts
        bcc     LF802
        bpl     LF802
        cmp     #$E8
        bne     LF802
        bvs     LF802
        rts
LF802:  sty     $00
LF804:  rts
        clc
        bit     $01
        lda     #$5F
LF80A:  rts
        bcs     LF816
        bpl     LF816
        cmp     #$F5
        bne     LF816
        bvc     LF816
        rts
LF816:  sty     $00
LF818:  rts
        sec
        clv
        lda     #$70
LF81D:  rts
        bne     LF827
        bvs     LF827
        bcc     LF827
        bmi     LF827
        rts
LF827:  sty     $00
LF829:  rts
        clc
        bit     $01
        lda     #$00
LF82F:  rts
        bmi     LF83B
        bcs     LF83B
        cmp     #$69
        bne     LF83B
        bvs     LF83B
        rts
LF83B:  sty     $00
LF83D:  rts
        sec
        bit     $01
        lda     #$00
LF843:  rts
        bmi     LF84F
        bcs     LF84F
        cmp     #$6A
        bne     LF84F
        bvs     LF84F
        rts
LF84F:  sty     $00
LF851:  rts
        sec
        clv
        lda     #$7F
LF856:  rts
        bpl     LF862
        bcs     LF862
        cmp     #$FF
        bne     LF862
        bvc     LF862
        rts
LF862:  sty     $00
LF864:  rts
        clc
        bit     $01
        lda     #$7F
LF86A:  rts
        bpl     LF876
        bcs     LF876
        cmp     #$FF
        bne     LF876
        bvs     LF876
        rts
LF876:  sty     $00
LF878:  rts
        sec
        clv
        lda     #$7F
LF87D:  rts
        bne     LF887
        bmi     LF887
        bvs     LF887
        bcc     LF887
        rts
LF887:  sty     $00
LF889:  rts
        bit     $01
        lda     #$40
LF88E:  rts
        bmi     LF898
        bcc     LF898
        bne     LF898
        bvc     LF898
        rts
LF898:  sty     $00
LF89A:  rts
        clv
LF89C:  rts
        beq     LF8A6
        bmi     LF8A6
        bcc     LF8A6
        bvs     LF8A6
        rts
LF8A6:  sty     $00
LF8A8:  rts
        beq     LF8B0
        bpl     LF8B0
        bpl     LF8B0
        rts
LF8B0:  sty     $00
LF8B2:  rts
        lda     #$80
LF8B5:  rts
        beq     LF8BD
        bpl     LF8BD
        bcc     LF8BD
        rts
LF8BD:  sty     $00
LF8BF:  rts
        bne     LF8C7
        bmi     LF8C7
        bcc     LF8C7
        rts
LF8C7:  sty     $00
LF8C9:  rts
        .byte   $B0
LF8CB:  ora     $F0
        .byte   $03
        bpl     LF8D1
        rts
LF8D1:  sty     $00
LF8D3:  rts
        bcc     LF8DB
        beq     LF8DB
        bmi     LF8DB
        rts
LF8DB:  sty     $00
LF8DD:  rts
        bit     $01
        ldy     #$40
LF8E2:  rts
        bmi     LF8EC
        bcc     LF8EC
        bne     LF8EC
        bvc     LF8EC
        rts
LF8EC:  stx     $00
LF8EE:  rts
        clv
LF8F0:  rts
        beq     LF8FA
        bmi     LF8FA
        bcc     LF8FA
        bvs     LF8FA
        rts
LF8FA:  stx     $00
LF8FC:  rts
        beq     LF904
        bpl     LF904
        bpl     LF904
        rts
LF904:  stx     $00
LF906:  rts
        ldy     #$80
LF909:  rts
        beq     LF911
        bpl     LF911
        bcc     LF911
        rts
LF911:  stx     $00
LF913:  rts
        bne     LF91B
        bmi     LF91B
        bcc     LF91B
        rts
LF91B:  stx     $00
LF91D:  rts
        bcs     LF925
        beq     LF925
        bpl     LF925
        rts
LF925:  stx     $00
LF927:  rts
        bcc     LF92F
        beq     LF92F
        bmi     LF92F
        rts
LF92F:  stx     $00
LF931:  rts
        bit     $01
        lda     #$40
        sec
LF937:  rts
        bmi     LF945
        bcc     LF945
        bne     LF945
        bvs     LF945
        cmp     #$00
        bne     LF945
        rts
LF945:  sty     $00
LF947:  rts
        clv
        sec
        lda     #$40
LF94C:  rts
        beq     LF95A
        bmi     LF95A
        bcc     LF95A
        bvs     LF95A
        cmp     #$01
        bne     LF95A
        rts
LF95A:  sty     $00
LF95C:  rts
        lda     #$40
        sec
        bit     $01
LF962:  rts
        bcs     LF970
        beq     LF970
        bpl     LF970
        bvs     LF970
        cmp     #$FF
        bne     LF970
        rts
LF970:  sty     $00
LF972:  rts
        clc
        lda     #$80
LF976:  rts
        bcc     LF97E
        cmp     #$7F
        bne     LF97E
        rts
LF97E:  sty     $00
LF980:  rts
        sec
        lda     #$81
LF984:  rts
        bvc     LF98E
        bcc     LF98E
        cmp     #$02
        bne     LF98E
        rts
LF98E:  sty     $00
LF990:  rts
        ldx     #$55
        lda     #$FF
        sta     $01
        nop
        bit     $01
        sec
        lda     #$01
LF99D:  rts
        bcc     LF9BB
        bne     LF9BB
        bmi     LF9BB
        bvc     LF9BB
        cmp     #$00
        bne     LF9BB
        clv
        lda     #$AA
LF9AD:  rts
        bcs     LF9BB
        beq     LF9BB
        bmi     LF9BB
        bvs     LF9BB
        cmp     #$55
        bne     LF9BB
        rts
LF9BB:  sty     $00
LF9BD:  rts
        bit     $01
        sec
        lda     #$80
LF9C3:  rts
        bcc     LF9E2
        bne     LF9E2
        bmi     LF9E2
        bvc     LF9E2
        cmp     #$00
        bne     LF9E2
        clv
        lda     #$55
        sec
LF9D4:  rts
        bcs     LF9E2
        beq     LF9E2
        bpl     LF9E2
        bvs     LF9E2
        cmp     #$AA
        bne     LF9E2
        rts
LF9E2:  sty     $00
LF9E4:  rts
        bit     $01
        sec
        lda     #$01
LF9EA:  rts
        bcc     LFA09
        beq     LFA09
        bpl     LFA09
        bvc     LFA09
        cmp     #$80
        bne     LFA09
        clv
        clc
        lda     #$55
LF9FB:  rts
        bcc     LFA09
        beq     LFA09
        bmi     LFA09
        bvs     LFA09
        cmp     #$2A
        bne     LFA09
        rts
LFA09:  .byte   $84
LFA0A:  brk
        bit     $01
        sec
        lda     #$80
LFA10:  rts
        bcc     LFA2F
        beq     LFA2F
        bmi     LFA2F
        bvc     LFA2F
        cmp     #$01
        bne     LFA2F
        clv
        clc
        lda     #$55
LFA21:  rts
        bcs     LFA2F
        beq     LFA2F
        bpl     LFA2F
        bvs     LFA2F
        cmp     #$AA
        bne     LFA2F
        rts
LFA2F:  sty     $00
LFA31:  rts
        bit     $01
        clc
        lda     #$40
LFA37:  rts
        bvc     LFA66
        bcs     LFA66
        bmi     LFA66
        cmp     #$40
        bne     LFA66
LFA42:  rts
        clv
        sec
        lda     #$FF
LFA47:  rts
        bvs     LFA66
        bne     LFA66
        bmi     LFA66
        bcc     LFA66
        cmp     #$FF
        bne     LFA66
LFA54:  rts
        bit     $01
        lda     #$F0
LFA59:  rts
        bvc     LFA66
        beq     LFA66
        bpl     LFA66
        bcc     LFA66
        cmp     #$F0
        beq     LFA68
LFA66:  sty     $00
LFA68:  rts
        bit     $01
        sec
        lda     #$75
LFA6E:  rts
        bvc     LFAE7
        beq     LFAE7
        bmi     LFAE7
        bcs     LFAE7
        cmp     #$65
        bne     LFAE7
LFA7B:  rts
        bit     $01
        clc
        lda     #$B3
LFA81:  rts
        bvc     LFAE7
        bcc     LFAE7
        bpl     LFAE7
        cmp     #$FB
        bne     LFAE7
LFA8C:  rts
        clv
        clc
        lda     #$C3
LFA91:  rts
        bvs     LFAE7
        beq     LFAE7
        bpl     LFAE7
        bcs     LFAE7
        cmp     #$D3
        bne     LFAE7
LFA9E:  rts
        bit     $01
        sec
        lda     #$10
LFAA4:  rts
        bvc     LFAE7
        beq     LFAE7
        bmi     LFAE7
        bcs     LFAE7
        cmp     #$7E
        bne     LFAE7
LFAB1:  rts
        bit     $01
        clc
        lda     #$40
LFAB7:  rts
        bvs     LFAE7
        bcs     LFAE7
        bmi     LFAE7
        cmp     #$53
        bne     LFAE7
LFAC2:  rts
        clv
        sec
        lda     #$FF
LFAC7:  rts
        bvs     LFAE7
        beq     LFAE7
        bpl     LFAE7
        bcc     LFAE7
        cmp     #$FF
        bne     LFAE7
LFAD4:  rts
        bit     $01
        sec
        lda     #$F0
LFADA:  rts
        bvs     LFAE7
        beq     LFAE7
        bpl     LFAE7
        bcc     LFAE7
        cmp     #$B8
        beq     LFAE9
LFAE7:  sty     $00
LFAE9:  rts
        bit     $01
        clc
        lda     #$B2
LFAEF:  rts
        bvs     LFB1C
        bcc     LFB1C
        bmi     LFB1C
        cmp     #$05
        bne     LFB1C
LFAFA:  rts
        clv
        clc
        lda     #$42
LFAFF:  rts
        bvs     LFB1C
        bmi     LFB1C
        bcs     LFB1C
        cmp     #$57
        bne     LFB1C
LFB0A:  rts
        bit     $01
        sec
        lda     #$75
LFB10:  rts
        bvs     LFB1C
        bmi     LFB1C
        bcc     LFB1C
        cmp     #$11
        bne     LFB1C
        rts
LFB1C:  .byte   $85
LFB1D:  brk
        bit     $01
        clc
        lda     #$B3
LFB23:  rts
        bvc     LFB76
        bcc     LFB76
        bpl     LFB76
        cmp     #$E1
        bne     LFB76
LFB2E:  rts
        clv
        clc
        lda     #$42
LFB33:  rts
        bvs     LFB76
        beq     LFB76
        bmi     LFB76
        bcc     LFB76
        cmp     #$56
        bne     LFB76
LFB40:  rts
        bit     $01
        sec
        lda     #$75
LFB46:  rts
        bvc     LFB76
        beq     LFB76
        bmi     LFB76
        bcc     LFB76
        cmp     #$6E
        bne     LFB76
LFB53:  rts
        bit     $01
        clc
        lda     #$B3
LFB59:  rts
        bvc     LFB76
        bcc     LFB76
        bmi     LFB76
        cmp     #$02
        bne     LFB76
LFB64:  rts
        clv
        clc
        lda     #$42
LFB69:  rts
        bvs     LFB76
        beq     LFB76
        bmi     LFB76
        bcs     LFB76
        cmp     #$42
        beq     LFB78
LFB76:  sty     $00
LFB78:  rts
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $80
        .byte   $80
        .byte   $FF
        .byte   $80
        .byte   $80
        brk
        brk
        brk
        brk
        brk
        .byte   $FF
        brk
        brk
        brk
        brk
        brk
        ora     ($01,x)
        .byte   $FF
        ora     ($01,x)
LFB9E:  brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $7C
        inc     LC000,x
        cpy     #$FE
        .byte   $7C
        brk
        inc     a:$FE,x
        beq     LFB76
        inc     a:$FE,x
        dec     $C6
        .byte   $02
        inc     LC6C6,x
        dec     $00
        cpy     a:$D8
        beq     LFB9E
        cpy     a:$C6
        dec     $EE
        .byte   $02
        dec     $C6,x
        dec     $C6
        brk
        dec     $C6
        .byte   $02
        dec     $CE,x
        dec     $C6
        brk
        .byte   $7C
        inc     LC602,x
        dec     $FE
        .byte   $7C
        brk
        .byte   $FC
        inc     LFC02,x
        cpy     #$C0
        cpy     #$00
        cpy     a:$CC
        sei
        bmi     LFC1F
        bmi     LFBF1
LFBF1:  clc
        clc
        clc
        clc
        clc
        clc
        clc
        brk
        .byte   $FC
        inc     $0602,x
        .byte   $1C
LFBFE:  bvs     LFBFE
        brk
        .byte   $FC
LFC02:  inc     $3C02,x
        .byte   $3C
        .byte   $02
        inc     $1800,x
        clc
        cld
        cld
        inc     $1818,x
        brk
        inc     a:$FE,x
        .byte   $80
        .byte   $FC
        asl     $FE
        brk
        .byte   $7C
        inc     LC000,x
        .byte   $FC
        .byte   $C6
LFC1F:  inc     LFE00,x
        inc     $0C06,x
        clc
        bpl     LFC58
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
LFC58:  brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        clc
        clc
        clc
        .byte   $FF
        .byte   $FF
        clc
        clc
        clc
        clc
        clc
        clc
        .byte   $FF
        .byte   $FF
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        clc
        clc
        clc
        clc
        brk
        clc
        clc
        brk
        .byte   $33
        .byte   $33
        ror     $00
        brk
        brk
        brk
        brk
        ror     $66
        .byte   $FF
        ror     $FF
        ror     $66
        brk
        clc
        rol     $3C60,x
        asl     $7C
        clc
        brk
        .byte   $62
        ror     $0C
        clc
        bmi     LFD0D
        lsr     $00
        .byte   $3C
        ror     $3C
        sec
        .byte   $67
        ror     $3F
        brk
        .byte   $0C
        .byte   $0C
        clc
        brk
        brk
        brk
        brk
        brk
        .byte   $0C
        clc
        bmi     LFCED
        bmi     LFCD7
        .byte   $0C
        brk
        bmi     LFCDB
        .byte   $0C
        .byte   $0C
        .byte   $0C
        clc
        bmi     LFCC9
LFCC9:  brk
        ror     $3C
        .byte   $FF
        .byte   $3C
        ror     $00
        brk
        brk
        clc
        clc
        ror     $1818,x
LFCD7:  brk
        brk
        brk
        brk
LFCDB:  brk
        brk
        brk
        clc
        clc
        bmi     LFCE2
LFCE2:  brk
        brk
        ror     a:$3B
        brk
        brk
        brk
        brk
        brk
        brk
LFCED:  brk
        clc
        clc
        brk
        brk
        .byte   $03
        asl     $0C
        clc
        bmi     LFD58
        brk
        rol     $6763,x
        .byte   $6B
        .byte   $73
        .byte   $63
        rol     $0C00,x
        .byte   $1C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $3F
        brk
        rol     $6363,x
        .byte   $0E
LFD0D:  sec
        .byte   $63
        .byte   $7F
        brk
        rol     $6363,x
        asl     $6363
        rol     $0600,x
        asl     $261E
        .byte   $7F
        asl     $06
        brk
        .byte   $7F
        .byte   $63
        rts
        ror     $6303,x
        rol     $3E00,x
        .byte   $63
        rts
        ror     $6363,x
        rol     $7F00,x
        .byte   $63
        asl     $0C
        clc
        clc
        .byte   $3C
        brk
        rol     $6363,x
        rol     $6363,x
        rol     $3E00,x
        .byte   $63
        .byte   $63
        .byte   $3F
        .byte   $03
        .byte   $63
        rol     a:$00,x
        brk
        clc
        clc
        brk
        clc
        clc
        brk
        brk
        brk
        clc
        clc
        brk
        clc
        clc
LFD58:  bmi     LFD68
        clc
        bmi     LFDBD
        bmi     LFD77
        asl     a:$00
        brk
        ror     $7E00,x
        brk
        brk
LFD68:  brk
        bvs     LFD83
        .byte   $0C
        asl     $0C
        clc
        bvs     LFD71
LFD71:  ror     $0363,x
        asl     $1C
        brk
LFD77:  clc
        clc
        .byte   $7C
        dec     $CE
        inc     LE6E0
        .byte   $7C
        brk
        .byte   $1C
        .byte   $36
LFD83:  .byte   $63
        .byte   $7F
        .byte   $63
        .byte   $63
        .byte   $63
        brk
        ror     $6373
        ror     $6363,x
        ror     $1E00,x
        .byte   $33
        rts
        rts
        rts
        .byte   $33
        asl     $6C00,x
        ror     $63,x
        .byte   $63
        .byte   $63
        ror     $7C
        brk
        .byte   $7F
        and     ($30),y
        .byte   $3C
        bmi     LFDD8
        .byte   $7F
        brk
        .byte   $7F
        and     ($30),y
        .byte   $3C
        bmi     LFDDF
        sei
        brk
        asl     $6033,x
        .byte   $67
        .byte   $63
        .byte   $37
        ora     $6300,x
        .byte   $63
        .byte   $63
        .byte   $7F
LFDBD:  .byte   $63
        .byte   $63
        .byte   $63
        brk
        .byte   $3C
        clc
        clc
        clc
        clc
        clc
        .byte   $3C
        brk
        .byte   $1F
        asl     $06
        asl     $06
        ror     $3C
        brk
        ror     $66
        jmp     (L6C78)
        .byte   $67
        .byte   $63
LFDD8:  brk
        sei
        bmi     LFE3C
        rts
        .byte   $63
        .byte   $63
LFDDF:  ror     $6300,x
        .byte   $77
        .byte   $7F
        .byte   $6B
        .byte   $63
        .byte   $63
        .byte   $63
        brk
        .byte   $63
        .byte   $73
        .byte   $7B
        .byte   $6F
        .byte   $67
        .byte   $63
        .byte   $63
        brk
        .byte   $1C
        rol     $63,x
        .byte   $63
        .byte   $63
        rol     $1C,x
        brk
        ror     $6373
        ror     $6060,x
        rts
LFE00:  brk
        .byte   $1C
        rol     $63,x
        .byte   $6B
        .byte   $67
        rol     $1D,x
        brk
        ror     $6373
        ror     $676C,x
        .byte   $63
        brk
        rol     $6063,x
        rol     $6303,x
        rol     $7E00,x
        .byte   $5A
        clc
        clc
        clc
        clc
        .byte   $3C
        brk
        .byte   $73
        .byte   $33
        .byte   $63
        .byte   $63
        .byte   $63
        ror     $3C,x
        brk
        .byte   $73
        .byte   $33
        .byte   $63
        .byte   $63
        ror     $3C
        clc
        brk
        .byte   $73
        .byte   $33
        .byte   $63
        .byte   $6B
        .byte   $7F
        .byte   $77
        .byte   $63
        brk
        .byte   $63
        .byte   $63
        .byte   $36
LFE3C:  .byte   $1C
        rol     $63,x
        .byte   $63
        brk
        .byte   $33
        .byte   $63
        .byte   $63
        rol     $1C,x
        sei
        bvs     LFE49
LFE49:  .byte   $7F
        .byte   $63
        asl     $1C
        .byte   $33
        .byte   $63
        ror     $3C00,x
        bmi     LFE84
        bmi     LFE86
        bmi     LFE94
        brk
        rti
        rts
        bmi     LFE75
        .byte   $0C
        asl     $02
        brk
        .byte   $3C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $3C
        brk
        brk
        clc
        .byte   $3C
        ror     $1818,x
        clc
        clc
        brk
        brk
        brk
        brk
LFE75:  brk
        brk
        .byte   $FF
        .byte   $FF
        bmi     LFEAB
        clc
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $3F
LFE84:  .byte   $63
        .byte   $63
LFE86:  .byte   $67
        .byte   $3B
        brk
        rts
        rts
        ror     $6373
        .byte   $63
        rol     a:$00,x
        brk
        .byte   $3E
LFE94:  .byte   $63
        rts
        .byte   $63
        rol     $0300,x
        .byte   $03
        .byte   $3B
        .byte   $67
        .byte   $63
        .byte   $63
        rol     a:$00,x
        brk
        rol     $7F61,x
        rts
        rol     $0E00,x
        clc
LFEAB:  clc
        .byte   $3C
        clc
        clc
        .byte   $3C
        brk
        brk
        brk
        rol     $6360,x
        .byte   $63
        and     $6000,x
        rts
        ror     $6373
        ror     $67
        brk
        brk
        brk
        asl     $0C0C,x
        .byte   $0C
        asl     a:$00,x
        brk
        .byte   $3F
        asl     $06
        asl     $66
        .byte   $3C
        rts
        rts
        ror     $6E
        .byte   $7C
        .byte   $67
        .byte   $63
        brk
        .byte   $1C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        .byte   $0C
        asl     a:$00,x
        brk
        ror     $6B7F
        .byte   $62
        .byte   $67
        brk
        brk
        brk
        ror     $6373
        ror     $67
        brk
        brk
        brk
        rol     $6363,x
        .byte   $63
        rol     a:$00,x
        brk
        rol     $7363,x
        ror     $6060
        brk
        brk
        rol     $6763,x
        .byte   $3B
        .byte   $03
        .byte   $03
        brk
        brk
        ror     $6373
        ror     a:$63,x
        brk
        brk
        rol     $1C71,x
        .byte   $47
        rol     $0600,x
        .byte   $0C
        .byte   $3F
        clc
        clc
        .byte   $1B
        asl     a:$00
        brk
        .byte   $73
        .byte   $33
        .byte   $63
        .byte   $67
        .byte   $3B
        brk
        brk
        brk
        .byte   $73
        .byte   $33
        .byte   $63
        ror     $3C
        brk
        brk
        brk
        .byte   $63
        .byte   $6B
        .byte   $7F
        .byte   $77
        .byte   $63
        brk
        brk
        brk
        .byte   $63
        rol     $1C,x
        rol     $63,x
        brk
        brk
        brk
        .byte   $33
        .byte   $63
        .byte   $63
        .byte   $3F
        .byte   $03
        rol     a:$00,x
        .byte   $7F
        asl     $381C
        .byte   $7F
        brk
        .byte   $3C
        .byte   $42
        sta     $A1A1,y
        sta     $3C42,y
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
LFF78:  brk
        .byte   $0F
        asl     $12
        .byte   $33
        .byte   $33
        asl     $12
        .byte   $33
        sec
        asl     $12
        .byte   $33
        .byte   $3A
        asl     $12
        .byte   $33
        .byte   $0F
        asl     $12
        .byte   $33
        .byte   $33
        asl     $12
        .byte   $33
        sec
        asl     $12
        .byte   $33
        .byte   $3A
        asl     $12
        .byte   $33
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        .byte   $AF
        cmp     $04
        .byte   $C0
LFFFF:  .byte   $F4

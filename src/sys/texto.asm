include "../include/hardware.inc"
include "../include/constantes.inc"
include "../include/entity_defines.asm"
SECTION "TEXTO", ROM0

TEXT_TIMER: DS 1 

temporizador_texto:

    ;; Las iteraciones dependen de bc. Son el resultado de dividir 393216 entre 256. Este resultado son aprox 3 segundos.
    ;; Si queremos reducirlo a la mitad tenemos que dividir 393216 entre dos y dividirlo de la misma manera entre 256
    ;; para meterlo en bc. Si queremos hacerlo el doble de largo tenemos que multiplicar 393216 por 2 y dividirlo entre 
    ;; 256 para meterlo en bc.

    ld a, 255           ; Carga un valor inicial en a
    ld de, $C000        ;ESTA DIRECCION DE MEMORIA HABRIA QUE REVISARLA
    ld [de], a          ; Almacena en la dirección apuntada por de
    ld bc, 768         ; bc = (393216 / 2) / 256 

    .loop_texto:    
        ld a, [de]          ; a = [de]
        dec a               ; a--
        ld [de], a          ; Actualiza [de] con el valor de a
        jr nz, .loop_texto  ; Repite mientras a != 0
        dec bc              ; Reduce el contador en bc
        ld a, b             ; Verifica si bc es 0
        or c
    jr nz, .loop_texto  ; Repite mientras bc != 0

    ;call limpia_texto
ret


dibuja_texto_start:
    ;LETRA S
    ld a, $92
    ld hl, $98E7
    ldi [hl], a

    ;LETRA T
    ld a, $93
    ldi [hl], a

    ;LETRA A
    ld a, $80
    ldi [hl], a

    ;LETRA R
    ld a, $91
    ldi [hl], a

    ;LETRA T
    ld a, $93
    ldi [hl], a

    ;call temporizador_texto
ret

dibuja_texto_inicio:
    ;LETRA I
    ld a, $88
    ld hl, $98E7
    ldi [hl], a

    ;LETRA N
    ld a, $8D
    ldi [hl], a

    ;LETRA I
    ld a, $88
    ldi [hl], a

    ;LETRA C
    ld a, $82
    ldi [hl], a

    ;LETRA I
    ld a, $88
    ldi [hl], a

    ;LETRA O
    ld a, $8E
    ldi [hl], a

    ;call temporizador_texto
ret

dibuja_texto_final:
    ;LETRA G
    ld a, $66
    ld hl, $9806
    ldi [hl], a

    ;LETRA A
    ld a, $60
    ldi [hl], a

    ;LETRA M
    ld a, $6C
    ldi [hl], a

    ;LETRA E
    ld a, $64
    ldi [hl], a
    inc hl

    ;LETRA O
    ld a, $6E
    ldi [hl], a

    ;LETRA V
    ld a, $75
    ldi [hl], a

    ;LETRA E
    ld a, $64
    ldi [hl], a

    ;LETRA R
    ld a, $71
    ldi [hl], a

    call temporizador_texto
ret

dibuja_puntuacion:

    call wait_vblank_start
    ld a, [rLCDC]
    res 7, a
    ld [rLCDC], a

    call limpia_texto
    call sys_render_cleanOAM
    
    ld de, Background_map_over
    call pintarFondo
    call pintarVallas
    
    ld a, [rLCDC]
    set 7, a
    ld [rLCDC], a

    call wait_vblank_start
    call dibuja_your_score

    call temporizador_texto

    call wait_vblank_start
    ld hl, $98C5
    call draw_score
    inc hl
    inc hl

    call temporizador_texto

    call wait_vblank_start
    ld a, $77
    ld [hl], a
    inc hl
    inc hl

    call temporizador_texto

    call wait_vblank_start
    call dibuja_num_flores

    call temporizador_texto

    call wait_vblank_start
    call dibuja_total

    call temporizador_texto

    call wait_vblank_start
    call dibuja_multi_total

    call temporizador_texto

    call wait_vblank_start
    call dibuja_high_score
    
    call calcula_high_score
   

    ld hl, $99C8
    call draw_High_score
ret

dibuja_high_score:
    ;LETRA H
    ld a, $67
    ld hl, $99A5
    ldi [hl], a

    ;LETRA I
    ld a, $68
    ldi [hl], a

    ;LETRA G
    ld a, $66
    ldi [hl], a

    ;LETRA H
    ld a, $67
    ldi [hl], a
    inc hl

    ;LETRA S
    ld hl, $99AB
    ld a, $72
    ldi [hl], a

    ;LETRA C
    ld a, $62
    ldi [hl], a

    ;LETRA O
    ld a, $6E
    ldi [hl], a

    ;LETRA R
    ld a, $71
    ldi [hl], a

    ;LETRA E
    ld a, $64
    ldi [hl], a
ret


calcula_high_score:

    ld a, [num_flowers]
    cp 0
    jr z, .fin

    ld a, [score]
    ld b, a
    ld a, [max_score]

    cp b
    jr c, .mas ;Tu puntuacion es mayor a la que hay
    jr z, .comprobarAbajo
    jr .fin

    .comprobarAbajo

    ld a, [score+1]
    ld b, a
    ld a, [max_score+1]

    cp b
    jr c, .mas ;Tu puntuacion es menor a la que hay
    jr z, .mas
    jr .fin

    .mas
    ld a, [score+1]
    ld [max_score+1], a

    ld a, [score]
    ld [max_score], a

    .fin

ret

dibuja_multi_total:

    ld a, [num_flowers]
    ld b, a
    cp 0
    jr z, .zero

    ld a, [score]
    ld l, a
    ld a, [score+1]
    ld h, a

    dec b
    jr z, .uno

    ld d, h
    ld e, l

    .buclemulti
    ld a, l
    add e
    daa
    ld l, a
    ld a, h
    adc d
    daa
    ld h, a
    dec b
    jr nz, .buclemulti

    .uno

    ld d, h
    ld e, l

    ld hl, $9968
    ld a, d
    ld [score], a

    call obtain_up_number

    inc hl
    ld a, d

    call obtain_down_number

    inc hl
    ld a, e
    ld [score+1], a

    call obtain_up_number

    inc hl
    ld a, e

    call obtain_down_number

    ret

    .zero
    ld hl, $9968
    ld a, $7A

    ldi [hl], a
    ldi [hl], a
    ldi [hl], a
    ldi [hl], a
ret

dibuja_num_flores:
    ld a, [num_flowers]
    ld c, a

    ld a, $7A

    add c

    ld b, a
    ld a, $7A
    
    ldi [hl], a
    ld a, b
    ldi [hl], a
    ld a, $52
    ld [hl], a

ret

dibuja_your_score:
    ;LETRA Y
    ld a, $78
    ld hl, $9884
    ldi [hl], a

    ;LETRA O
    ld a, $6E
    ldi [hl], a

    ;LETRA U
    ld a, $74
    ldi [hl], a

    ;LETRA R
    ld a, $71
    ldi [hl], a
    inc hl

    ;LETRA S
    ld hl, $988A
    ld a, $72
    ldi [hl], a

    ;LETRA C
    ld a, $62
    ldi [hl], a

    ;LETRA O
    ld a, $6E
    ldi [hl], a

    ;LETRA R
    ld a, $71
    ldi [hl], a

    ;LETRA E
    ld a, $64
    ldi [hl], a

    ;LETRA :
    ld a, $88
    ldi [hl], a

ret

dibuja_total:

    ;LETRA T
    ld a, $73
    ld hl, $9947
    ldi [hl], a

    ;LETRA O
    ld a, $6E
    ldi [hl], a

    ;LETRA T
    ld a, $73
    ldi [hl], a

    ;LETRA A
    ld a, $60
    ldi [hl], a

    ;LETRA L
    ld a, $6B
    ldi [hl], a

    ;LETRA :
    ld a, $88
    ldi [hl], a

ret

limpia_texto:
    ld hl, $9800
    ld a, $90
    ld b, 32
    ld c, 32

    .total
        .pintar
            ld [hl], a
            inc hl
            dec b
        jr nz, .pintar
        dec c
    jr nz, .total
ret
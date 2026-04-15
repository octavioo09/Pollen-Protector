include "../include/hardware.inc"
include "../include/constantes.inc"

SECTION "OAM DMA routine", ROM0
CopyDMARoutine:
  ld  hl, DMARoutine
  ld  b, DMARoutineEnd - DMARoutine ; Number of bytes to copy
  ld  c, LOW(hOAMDMA) ; Low byte of the destination address
.copy
  ld  a, [hli]
  ldh [c], a
  inc c
  dec b
  jr  nz, .copy
  ret

DMARoutine:
  ldh [rDMA], a
  ld  a, 40
.wait
  dec a
  jr  nz, .wait
  ret
DMARoutineEnd:


SECTION "OAM DMA", HRAM

hOAMDMA::
  ds DMARoutineEnd - DMARoutine ; Reserve space to copy the routine to



SECTION "DMA", WRAM0, ALIGN[8]
    wShadowOAM: DS 160


    
SECTION "Render", ROM0
sys_render_setUp:
    call wait_vblank_start
    ld a, [rLCDC]
    res 7, a
    ld [rLCDC], a


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

    call ActivarSpritesYPaleta

    call sys_render_cleanOAM

    ld de, Background_map
    call pintarFondo
    call pintarLetreroHitShot
    ;call pintarCentro
    call pintarVallas
    call pintarVidas

    
    ld a, [rLCDC]
    set 7, a
    ld [rLCDC], a

    call CopyDMARoutine

ret

pintarLetreroHitShot:

  ld hl, $9C00
  ld a, $54
  ld b, 20

  .linea
    ld [hl+], a
    dec b
  jr nz, .linea 


  ld hl, $9C26

  ld a, $6D     ;Letra R
  ld [hl+], a

  ld a, $64     ;Letra E
  ld [hl+], a

  ld a, $76     ;Letra A
  ld [hl+], a

  ld a, $5F     ;Letra D
  ld [hl+], a

  ld a, $65     ;Letra Y
  ld [hl+], a

  ld a, $6B     ;Letra Y
  ld [hl+], a

  ld a, $6E     ;Letra Y
  ld [hl+], a

  ld a, $76     ;Letra Y
  ld [hl+], a

  ld a, $64     ;Letra Y
  ld [hl+], a

  ld a, $71     ;Letra Y
  ld [hl+], a

  ld a, $8A     ;Letra Y
  ld [hl+], a

  inc hl        ;Dejar Hueco



ret

set_up_window:


    ; Activar el segundo TileMap
    ld a, [rLCDC]
    or %01000000
    ld [rLCDC], a

    ; Activar la ventana
    ld a, [rLCDC]
    or %00100000
    ld [rLCDC], a

    ; Configurar la ventana
    ld a, 120
    ld [rWY], a
    ld a, 7
    ld [rWX], a


ret

ActivarSpritesYPaleta:
    ld a, [rLCDC]
    or %00000010 
    ld [rLCDC], a

    ld a, %11100100
    ld [$FF48], a

    ld a, %11100100
    ld [$FF47], a
ret


sys_render_cleanOAM:
    ld hl, $FE00 ; Dirección de la OAM
    ld b, 160 ; En la OAM caben 40 sprites
    ld a, 0

    .limpiar
        
        ld [hl], a
        inc hl
        dec b
    jr nz, .limpiar
ret

pintarFondo:
    ld hl, $9800       ; Apuntamos a la región de BG Map

    ld b, 9            ; Número de filas
    ld c, 10            ; Número de columnas por fila

  .paint_map_loop

      ld a, [de] 
      cp 0
      jr z, .saltarPintar

      push bc
      push hl
      call draw4sprites
      pop hl
      pop bc

      .saltarPintar

      inc hl
      inc hl
      inc de

      dec c
      jr nz, .paint_map_loop
      ld c, 10             ; Reiniciar columnas
      dec b
      
      push bc
      ld bc, $0C
      add hl, bc
      ld bc, $20
      add hl, bc
      pop bc

      jr nz, .paint_map_loop
ret

bucleHorizontal:
  ld [hl], $55
  inc hl
  .bucleA
      ld [hl], c
      inc hl
      dec b
    jr nz, .bucleA
  
  ld [hl], $57
ret

bucleVertical: 
  .bucleA
      ld [hl], c
      ld de, $20
      add hl, de
      dec b
    jr nz, .bucleA
ret
pintarVallas:
    ld hl, $9820       ; Apuntamos a la región de BG Map
    ld b, 18            ; Número de filas
    ld c, $54
    call bucleHorizontal

    ld hl, $9A00       ; Apuntamos a la región de BG Map
    ld b, 18            ; Número de filas
    ld c, $54
    call bucleHorizontal

    ld hl, $9840       ; Apuntamos a la región de BG Map
    ld b, 14            ; Número de filas
    ld c, $56
    call bucleVertical

    ld hl, $9853       ; Apuntamos a la región de BG Map
    ld b, 14            ; Número de filas
    ld c, $56
    call bucleVertical

ret
pintar_exit:

    ;LETRA E
    ld a, $64
    ldi [hl], a

    ;LETRA X
    ld a, $77
    ldi [hl], a

    ;LETRA I
    ld a, $68
    ldi [hl], a

    ;LETRA T
    ld a, $73
    ldi [hl], a
ret
pintar_continue:

    ;LETRA C
    ld a, $62
    ldi [hl], a

    ;LETRA O
    ld a, $6E
    ldi [hl], a

    ;LETRA N
    ld a, $6D
    ldi [hl], a

    ;LETRA T
    ld a, $73
    ldi [hl], a

    ;LETRA I
    ld a, $68
    ldi [hl], a

    ;LETRA N
    ld a, $6D
    ldi [hl], a

    ;LETRA U
    ld a, $74
    ldi [hl], a

    ;LETRA E
    ld a, $64
    ldi [hl], a

ret

pintar_pause:
;TITULO
; Sexta fila
    ld a, $D0
    ld hl, $9844
    ldi [hl], a

    ld a, $D2
    ldi [hl], a

    ld a, $D4
    ldi [hl], a

    ld a, $D6
    ldi [hl], a

    ld a, $D8
    ldi [hl], a

    ld a, $DA
    ldi [hl], a

    ld a, $D8
    ldi [hl], a

    ld a, $DA
    ldi [hl], a

    ld a, $DC
    ldi [hl], a

    ld a, $DE
    ldi [hl], a

    ld a, $E0
    ldi [hl], a

    ld a, $E2
    ldi [hl], a

    ; Septima fila
    ld a, $D1
    ld hl, $9864
    ldi [hl], a

    ld a, $D3
    ldi [hl], a

    ld a, $D5
    ldi [hl], a

    ld a, $D7
    ldi [hl], a

    ld a, $D9
    ldi [hl], a

    ld a, $DB
    ldi [hl], a

    ld a, $D9
    ldi [hl], a

    ld a, $DB
    ldi [hl], a

    ld a, $DD
    ldi [hl], a

    ld a, $DF
    ldi [hl], a

    ld a, $E1
    ldi [hl], a

    ld a, $E3
    ldi [hl], a

    ; Octava fila
    ld a, $D0
    ld hl, $9881
    ldi [hl], a

    ld a, $D2
    ldi [hl], a

    ld a, $E4
    ldi [hl], a

    ld a, $E6
    ldi [hl], a

    ld a, $D4
    ldi [hl], a

    ld a, $D6
    ldi [hl], a

    ld a, $E8
    ldi [hl], a

    ld a, $EA
    ldi [hl], a

    ld a, $DC
    ldi [hl], a

    ld a, $DE
    ldi [hl], a

    ld a, $EC
    ldi [hl], a

    ld a, $EE
    ldi [hl], a

    ld a, $E8
    ldi [hl], a

    ld a, $EA
    ldi [hl], a

    ld a, $D4
    ldi [hl], a

    ld a, $D6
    ldi [hl], a

    ld a, $E4
    ldi [hl], a

    ld a, $E6
    ldi [hl], a

    ; Novena fila
    ld a, $D1
    ld hl, $98A1
    ldi [hl], a

    ld a, $D3
    ldi [hl], a

    ld a, $E5
    ldi [hl], a

    ld a, $E7
    ldi [hl], a

    ld a, $D5
    ldi [hl], a

    ld a, $D7
    ldi [hl], a

    ld a, $E9
    ldi [hl], a

    ld a, $EB
    ldi [hl], a

    ld a, $DD
    ldi [hl], a

    ld a, $DF
    ldi [hl], a

    ld a, $ED
    ldi [hl], a

    ld a, $EF
    ldi [hl], a

    ld a, $E9
    ldi [hl], a

    ld a, $EB
    ldi [hl], a

    ld a, $D5
    ldi [hl], a

    ld a, $D7
    ldi [hl], a

    ld a, $E5
    ldi [hl], a

    ld a, $E7
    ldi [hl], a

    call pintarVallas

ret

/*
PINTA EL LOGO DEL INICIO CON EL "PRESS A TO CONTINUE"
*/
pintar_inicio:
  ; Primera fila
    ld a, $98
    ld hl, $9848
    ld [hl], a

    ld a, $A0
    ld hl, $984A
    ld [hl], a

    ld a, $A2
    ld hl, $984B
    ld [hl], a

    ; Segunda fila
    ld a, $AD
    ld hl, $9864
    ld [hl], a

    ld a, $AF
    ld hl, $9865
    ld [hl], a

    ld a, $99
    ld hl, $9868
    ld [hl], a

    ld a, $9B
    ld hl, $9869
    ld [hl], a

    ld a, $A1
    ld hl, $986A
    ld [hl], a

    ld a, $A3
    ld hl, $986B
    ld [hl], a

    ld a, $C5
    ld hl, $986E
    ld [hl], a

    ld a, $C7
    ld hl, $986F
    ld [hl], a

    ;Tercera fila
    ld a, $A8
    ld hl, $9883
    ldi [hl], a

    ld a, $B0
    ldi [hl], a

    ld a, $B2
    ldi [hl], a

    ld a, $B8
    ldi [hl], a

    ld a, $BA
    ldi [hl], a

    ld a, $9C
    ldi [hl], a

    ld a, $9E
    ldi [hl], a

    ld a, $A4
    ldi [hl], a

    ld a, $A6
    ldi [hl], a

    ld a, $C0
    ldi [hl], a

    ld a, $C2
    ldi [hl], a

    ld a, $C8
    ldi [hl], a

    ld a, $CA
    ldi [hl], a

    ld a, $AA
    ldi [hl], a

    ; Cuarta fila
    ld a, $A9
    ld hl, $98A3
    ldi [hl], a

    ld a, $B1
    ldi [hl], a

    ld a, $91
    ldi [hl], a
    ldi [hl], a

    ld a, $BB
    ldi [hl], a

    ld a, $9D
    ldi [hl], a

    ld a, $9F
    ldi [hl], a

    ld a, $A5
    ldi [hl], a

    ld a, $A7
    ldi [hl], a

    ld a, $C1
    ldi [hl], a

    ld a, $91
    ldi [hl], a
    ldi [hl], a

    ld a, $CB
    ldi [hl], a

    ld a, $AB
    ldi [hl], a

    ; Quinta fila
    ld a, $F1
    ld hl, $98C4
    ldi [hl], a

    ld a, $94
    ldi [hl], a

    ld a, $95
    ldi [hl], a

    ld a, $96
    ldi [hl], a

    ld a, $97
    ldi [hl], a

    ld a, $9A
    ldi [hl], a

    ld a, $AC
    ldi [hl], a

    ld a, $AE
    ldi [hl], a

    ld a, $B4
    ldi [hl], a

    ld a, $B5
    ldi [hl], a

    ld a, $B6
    ldi [hl], a

    ld a, $B7
    ldi [hl], a

    ; Sexta fila
    ld a, $D0
    ld hl, $98E4
    ldi [hl], a

    ld a, $D2
    ldi [hl], a

    ld a, $D4
    ldi [hl], a

    ld a, $D6
    ldi [hl], a

    ld a, $D8
    ldi [hl], a

    ld a, $DA
    ldi [hl], a

    ld a, $D8
    ldi [hl], a

    ld a, $DA
    ldi [hl], a

    ld a, $DC
    ldi [hl], a

    ld a, $DE
    ldi [hl], a

    ld a, $E0
    ldi [hl], a

    ld a, $E2
    ldi [hl], a

    ; Septima fila
    ld a, $D1
    ld hl, $9904
    ldi [hl], a

    ld a, $D3
    ldi [hl], a

    ld a, $D5
    ldi [hl], a

    ld a, $D7
    ldi [hl], a

    ld a, $D9
    ldi [hl], a

    ld a, $DB
    ldi [hl], a

    ld a, $D9
    ldi [hl], a

    ld a, $DB
    ldi [hl], a

    ld a, $DD
    ldi [hl], a

    ld a, $DF
    ldi [hl], a

    ld a, $E1
    ldi [hl], a

    ld a, $E3
    ldi [hl], a

    ; Octava fila
    ld a, $D0
    ld hl, $9921
    ldi [hl], a

    ld a, $D2
    ldi [hl], a

    ld a, $E4
    ldi [hl], a

    ld a, $E6
    ldi [hl], a

    ld a, $D4
    ldi [hl], a

    ld a, $D6
    ldi [hl], a

    ld a, $E8
    ldi [hl], a

    ld a, $EA
    ldi [hl], a

    ld a, $DC
    ldi [hl], a

    ld a, $DE
    ldi [hl], a

    ld a, $EC
    ldi [hl], a

    ld a, $EE
    ldi [hl], a

    ld a, $E8
    ldi [hl], a

    ld a, $EA
    ldi [hl], a

    ld a, $D4
    ldi [hl], a

    ld a, $D6
    ldi [hl], a

    ld a, $E4
    ldi [hl], a

    ld a, $E6
    ldi [hl], a

    ; Novena fila
    ld a, $D1
    ld hl, $9941
    ldi [hl], a

    ld a, $D3
    ldi [hl], a

    ld a, $E5
    ldi [hl], a

    ld a, $E7
    ldi [hl], a

    ld a, $D5
    ldi [hl], a

    ld a, $D7
    ldi [hl], a

    ld a, $E9
    ldi [hl], a

    ld a, $EB
    ldi [hl], a

    ld a, $DD
    ldi [hl], a

    ld a, $DF
    ldi [hl], a

    ld a, $ED
    ldi [hl], a

    ld a, $EF
    ldi [hl], a

    ld a, $E9
    ldi [hl], a

    ld a, $EB
    ldi [hl], a

    ld a, $D5
    ldi [hl], a

    ld a, $D7
    ldi [hl], a

    ld a, $E5
    ldi [hl], a

    ld a, $E7
    ldi [hl], a

    ; Decima fila
    ld a, $BC
    ld hl, $9968
    ldi [hl], a

    ld a, $BD
    ldi [hl], a

    ld a, $BE
    ldi [hl], a

    ld a, $BF
    ldi [hl], a


    ; Decimoprimera fila
    ld a, $CC
    ld hl, $9988
    ldi [hl], a

    ld a, $91
    ldi [hl], a

    ld a, $91
    ldi [hl], a

    ld a, $C4
    ldi [hl], a

    ; Decimosegunda fila
    ld a, $CF
    ld hl, $99A9
    ldi [hl], a

    ld a, $CE
    ldi [hl], a

    ;PRESS A TO CONTINUE
    ;PRESS A TO
    ld a, $6F
    ld hl, $99E2
    ldi [hl], a

    ld a, $71
    ldi [hl], a

    ld a, $64
    ldi [hl], a

    ld a, $72
    ldi [hl], a

    ld a, $72
    ldi [hl], a

    inc hl

    ld a, $60
    ldi [hl], a

    inc hl

    ld a, $73
    ldi [hl], a

    ld a, $6E
    ldi [hl], a

    inc hl

    ld a, $72
    ldi [hl], a

    ld a, $73
    ldi [hl], a

    ld a, $60
    ldi [hl], a

    ld a, $71
    ldi [hl], a

    ld a, $73
    ldi [hl], a


    ;START
    ;ld a, $62
    ;ld hl, $9A07
    ;ldi [hl], a

    ;ld a, $72
    ;ldi [hl], a

    ;ld a, $73
    ;ldi [hl], a

    ;ld a, $60
    ;ldi [hl], a

    ;ld a, $71
    ;ldi [hl], a

    ;ld a, $73
    ;ldi [hl], a

    ;ld a, $74
    ;ldi [hl], a

    ;ld a, $64
    ;ldi [hl], a
    
 ret

;pintarCentro:
;    ld de, Center ; Apuntamos a la matriz
;    ld hl, $98C7       ; Apuntamos a la región de BG Map
;
;    ld b, 6            ; Número de filas
;    ld c, 6            ; Número de columnas por fila
;
;    .pintarLoop
;      ld a, [de] 
;      cp 0
;      jr z, .saltarPintar
;
;      ld a, [de]
;      ld [hl], a
;
;      .saltarPintar
;
;      inc hl
;      inc de
;
;      dec c
;
;    jr nz, .pintarLoop
;      ld c, 6
;
;      dec b
;      
;      push bc
;      ld bc, $1A
;      add hl, bc
;      pop bc
;
;    jr nz, .pintarLoop
;
;ret

pintarVidas:
  ld hl, $9811

  ld a, [player_lifes]
  add $7A
  ldi [hl], a

  ld a, $77
  ldi [hl], a

  ld a, $0
  ldi [hl], a

ret

;DE (Arriba a la izquierda del que quiero pintar), HL(El sprite que voy a pintar)
draw4sprites:
    ld a, [de]
    ld [hl], a

    inc hl
    inc a

    ld [hl], a

    inc a
    dec hl
    ld bc, $20
    add hl, bc

    ld [hl], a

    inc hl
    inc a

    ld [hl], a
ret



;//////// FUNCION ACTUALIZAR RENDER ////////////
;Función: 
;--------------------------------------
;Inputs: Ninguno
;Modifica: DE
sys_render_update:
    ;ld de, sys_render_one_entity

    call copiarEntities2DMA
    call wait_vblank_start
    ld  a, HIGH(wShadowOAM)
    call hOAMDMA

    ;call man_entity_for_all
ret

sys_render_setUp_escenas:
    call wait_vblank_start
    ld a, [rLCDC]
    res 7, a
    ld [rLCDC], a


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

    call ActivarSpritesYPaleta

    call sys_render_cleanOAM
    
    ld a, [rLCDC]
    set 7, a
    ld [rLCDC], a

    call CopyDMARoutine

ret
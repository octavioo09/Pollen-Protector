;; ESCENA PAUSA
include "../include/hardware.inc"
include "../include/constantes.inc"
;include "../include/entity_defines.asm"

SECTION "Variable Pause", WRAM0
selection:                     DS 1


SECTION "PAUSE", ROM0

man_escena_pause_init:
    ld a, 0
    ld [selection], a

    call pintar_pause

    ld hl, $9926
    call pintar_continue

    ld hl, $9968
    call pintar_exit
ret

draw_seleccionado:

    ld a, [selection]
    cp 0
    jr nz, .exit

    ld a, $52
    ld [$9925], a
    ld [$992E], a

    jr .fin
    .exit

    ld a, $52
    ld [$9967], a
    ld [$996C], a

    .fin

ret

delete_selected:

    ld a, $90
    ld [$9925], a
    ld [$992E], a

    ld [$9967], a
    ld [$996C], a

ret

man_escene_pause:

    call wait_vblank_start
    call man_escena_pause_init

    .buclePause

    call wait_vblank_start
    call delete_selected
    call draw_seleccionado

    call read_buttons
    ld a, [flancoAscendente]
    bit 0, a
    jr nz, .cambio_game

    ld a, [flancoAscendente]
    bit 6, a ;UP
    jr z, .comprobarDown

    ld a, 0
    ld [selection], a

    .comprobarDown
    ld a, [flancoAscendente]
    bit 7, a ;DOWN
    jr z, .sigue_pause

    ld a, 1
    ld [selection], a

    jr .sigue_pause

    .cambio_game
        ld a, [selection]
        cp 0
        jr nz, .exit

        ld a, SCENE_GAME
        ld [SCENE_STATE], a             ; Si pulsa el boton cambia a game

        ld a, 0
        ld [paused], a

        jr .sigue_pause

        .exit
        ld a, SCENE_INICIO
        ld [SCENE_STATE], a             ; Si pulsa el boton cambia a game

        ld a, 0
        ld [paused], a
        ld a, 0
        ld [NotDo], a
    
    .sigue_pause

    ld a, [SCENE_STATE]
    cp SCENE_PAUSED
    jr nz, .fin

    jr .buclePause

    .fin
ret

;; Comprueba que aun estas en la escena INICIO
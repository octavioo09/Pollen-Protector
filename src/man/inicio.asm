;; ESCENA INICO
include "../include/hardware.inc"
include "../include/constantes.inc"
include "../include/gbt_player.inc"
;include "../include/entity_defines.asm"

    export musica_data

SECTION "INICIO", ROM0

man_escena_inicio:
    call play_music
    call wait_vblank_start
    call pintar_inicio

    .bucle_inicio
    call wait_vblank_start
    call gbt_update

    call read_buttons
    ld a, [flancoAscendente]
    bit 1, a
    jr z, .sigue_inicio

    .cambio_game
        ld a, SCENE_GAME
        ld [SCENE_STATE], a             ; Si pulsa el boton cambia a game
    
    .sigue_inicio

    ld a, [SCENE_STATE]
    cp SCENE_INICIO
    jr nz, .fin

    jr .bucle_inicio

    .fin
ret

vaciaPantalla:
    call wait_vblank_start
    ld a, [rLCDC]
    res 7, a
    ld [rLCDC], a

    call limpia_texto
    call sys_render_cleanOAM
 
    ld a, [rLCDC]
    set 7, a
    ld [rLCDC], a
ret

;; Comprueba que aun estas en la escena INICIO

play_music:

    ld      de, musica_data
    ld      bc, BANK(musica_data)
    ld      a, $05

    call    gbt_play    ; Reproducir canción
ret
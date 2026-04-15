;; ESCENA GAMEOVER
include "../include/hardware.inc"
include "../include/constantes.inc"

SECTION "GAME OVER", ROM0

Background_map_over:
    ;DB $40, $00, $00, $44, $00, $00, $48, $00, $40, $40
    ;DB $44, $44, $40, $40, $40, $40, $40, $40, $40, $44
    ;DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $40
    ;DB $40, $00, $40, $00, $00, $00, $00, $4C, $00, $40
    ;DB $40, $00, $00, $00, $00, $00, $00, $00, $00, $40
    ;DB $48, $00, $00, $00, $00, $00, $44, $00, $00, $40
    ;DB $40, $00, $00, $40, $00, $00, $00, $00, $00, $40
    ;DB $4C, $00, $00, $00, $48, $00, $00, $00, $40, $44
    ;DB $40, $40, $40, $40, $40, $40, $40, $44, $40, $00
    ;DB $40, $00, $00, $00, $00, $00, $00, $00, $00, $40

    DB $44, $44, $40, $40, $40, $40, $40, $40, $40, $44
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $44
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $44
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $44
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $44
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $44
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $44
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $44
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $44
    DB $44, $44, $40, $40, $40, $40, $40, $40, $40, $44

man_escena_gameOver:

    call dibuja_texto_final

    call dibuja_puntuacion

    .bulceOver

    call read_buttons
    ld a, [flancoAscendente]
    bit 1, a
    jr z, .sigue_inicio

    .cambio_inicio
        ld a, SCENE_INICIO
        ld [SCENE_STATE], a             ; Si pulsa el boton cambia a game
    
    .sigue_inicio

    ld a, [SCENE_STATE]
    cp SCENE_GAMEOVER
    jr nz, .fin

    jr .bulceOver

    .fin
ret
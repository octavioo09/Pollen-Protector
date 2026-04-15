include "../include/hardware.inc"
include "../include/constantes.inc"
;include "../include/entity_defines.asm"
include "../include/gbt_player.inc"

SECTION "Variable Scenes", WRAM0
SCENE_STATE2:       DS 1  ; 1 byte para almacenar el estado de la escena
SCENE_STATE:       DS 1  ; 1 byte para almacenar el estado de la escena

max_score:                  DS 2
paused:                     DS 1
NotDo:                     DS 1

SECTION "ESCENAS", ROM0

;; Inicializa los valores de las escenas. La primera escena SIEMPRE es INICIO
;; ESCENA INICIO        -> 0
;; ESCENA JUEGO         -> 1
;; ESCENA GAME-OVER     -> 2

man_escenas_init:
    call sys_render_setUp_escenas
    call load_all_sprites_VRAM8x8
    call limpiarSpriteBuffer

    ;call initialize_seed

    ld a, 0
    ld [max_score], a
    ld [max_score+1], a

    ld [NotDo], a
    ld [paused], a

    ld a, SCENE_INICIO
    ld [SCENE_STATE], a      ; Se inicaliza como inicio
ret

;; Actualiza las escenas. Se le pasa a y comprueba en que 
man_escenas_update:

    .bucleEscenas

        ld a, [SCENE_STATE]

        ;call dibuja_texto_inicio

        cp SCENE_INICIO
        call z, escena_inicio         ; Si es la escena principal, salta a Inicio

        cp SCENE_GAME
        call z, escena_juego         ; Si es la escena de juego, salta a Game

        cp SCENE_GAMEOVER
        call z, escena_gameOver    ; Si es la escena de gameover, salta a GameOver

        cp SCENE_PAUSED
        call z, escena_paused    ; Si es la escena de gameover, salta a GameOver

    jr .bucleEscenas

ret


escena_gameOver:
call gbt_stop
    ;call dibuja_texto_inicio
    ld a, 0 
    ld [NotDo], a
    call man_escena_gameOver
ret

escena_inicio:
call gbt_stop
    call vaciaPantalla
    call man_escena_inicio
ret

escena_juego:
    call gbt_stop
    ld a, [NotDo]
    cp 0
    jr nz, .pausado
    call man_game_init
    ld a, 1 
    ld [NotDo], a

    .pausado

        ; Activar el sistema de sonido
    ld a, %10000000      ; Encender el sistema de sonido y activar todos los canales
    ld [$FF26], a

    ; Configurar altavoces
    ld a, %01110111      ; Volumen máximo en ambos altavoces
    ld [$FF24], a
    ld a, %00100010      ; Activar canal 2 solo en el altavoz derecho
    ld [$FF25], a


    call man_game_play
ret

escena_paused:
call gbt_stop
    call vaciaPantalla
    call man_escene_pause
    call sys_render_setUp  
ret

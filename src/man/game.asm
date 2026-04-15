
include "../include/constantes.inc"
include "../include/entity_defines.asm"

SECTION "Background Map", ROM0
Background_map:
    DB $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    DB $40, $00, $00, $44, $00, $00, $48, $00, $40, $00
    DB $44, $00, $00, $00, $00, $00, $00, $00, $00, $00
    DB $00, $00, $40, $00, $00, $00, $00, $4C, $00, $00
    DB $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    DB $48, $00, $00, $00, $00, $00, $44, $00, $00, $00
    DB $00, $00, $00, $40, $00, $00, $00, $00, $00, $00
    DB $4C, $00, $00, $00, $48, $00, $00, $00, $40, $44
    DB $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    DB $00, $00, $00, $00, $40, $00, $00, $44, $40, $00

;Center:
;    DB $55, $54, $54, $54, $54, $57
;    DB $56, $00, $00, $00, $00, $56
;    DB $56, $00, $00, $00, $00, $56
;    DB $56, $00, $00, $00, $00, $56
;    DB $56, $00, $00, $00, $00, $56
;    DB $55, $54, $54, $54, $54, $57
    


SECTION "Ship Values Default", ROM0
enemy_default:
   DB SHIP_TYPE_ENEMY1
   DB SHIP_STATE_IA | SHIP_STATE_COLLIDER
   DB 20                                        ;Posición Y
   DB 0
   DB 16                                        ;Posición X
   DB -1
   DB $0D
   DB %00000000
   DB 0
   DB 0
   DB 100                                       ;Posición X Objetivo
   DB 90                                        ;Posición Y Objetivo
   DB HIGH(sys_ai_move_to)
   DB LOW(sys_ai_move_to)
   DB 10
   DB 0



enemy1_default:
   DB SHIP_TYPE_ENEMY2 
   DB SHIP_STATE_IA | SHIP_STATE_COLLIDER
   DB 135
   DB 0
   DB 82
   DB -1
   DB 7
   DB %00000000
   DB 0
   DB 0
   DB 0
   DB 0
   DB HIGH(straightMovement)
   DB LOW(straightMovement)
   DB 10
   DB 0

enemy2_default:
   DB SHIP_TYPE_ENEMY2 
   DB SHIP_STATE_IA | SHIP_STATE_COLLIDER
   DB 35
   DB -1    
   DB 150
   DB 0
   DB 7
   DB %00000000
   DB 0
   DB 0
   DB 0
   DB 0
   DB HIGH(upDownMovement)
   DB LOW(upDownMovement)
   DB 10
   DB 0

enemy3_default:
   DB SHIP_TYPE_ENEMY3
   DB SHIP_STATE_IA | SHIP_STATE_COLLIDER
   DB 20                                        ;Posición Y
   DB 0
   DB 16                                        ;Posición X
   DB -1
   DB $09
   DB %00000000
   DB 0
   DB 0
   DB 100                                       ;Posición X Objetivo
   DB 90                                        ;Posición Y Objetivo
   DB HIGH(sys_ai_move_to_kamikace)
   DB LOW(sys_ai_move_to_kamikace)
   DB 10
   DB SHIP_TYPE_PLAYER


player_default:
   DB SHIP_TYPE_PLAYER 
   DB SHIP_STATE_INPUT | SHIP_STATE_COLLIDER        ;ESTADO DE LA NAVE, PARA SABER SI ESTA VIVO O MUERTO
   DB 136                     ;POSY
   DB 0                       ;POSX
   DB 92                      ;VELY
   DB 0                       ;VELX
   DB 0                       ;SPRITE1
   DB %00000000               ;ATRIBUTOS
   DB 0                       ;FRAME_ANIMATION
   DB 0                       ;DISPARO
   DB 0                       
   DB 0                       ;TIPO
   DB 0                       ;PATRON
   DB 0                       ;PATRON
   DB 10                     ;TIMER DE ANIMACION
   DB 0                       ;CONTRA QUE COLISIONA


shot_default:
   DB SHIP_TYPE_SHOT       ;ESTADO DE LA NAVE, PARA SABER SI ESTA VIVO O MUERTO
   DB SHIP_STATE_IA | SHIP_STATE_COLLIDER
   DB 140                                   ;POSY
   DB -4                                    ;VELY
   DB 90                                    ;POSX
   DB 0                                     ;VELX
   DB 4                                     ;SPRITE1
   DB %00000000                             ;ATRIBUTOS
   DB 0                                     ;FRAME_ANIMATION
   DB 0                                     ;DISPARO
   DB 0                                     ;TIPO
   DB 0  
   DB HIGH(sys_ai_autodestroy_shot_global)     ;PATRON
   DB LOW(sys_ai_autodestroy_shot_global)      ;PATRON
   DB $99
   DB SHIP_TYPE_ENEMY1 | SHIP_TYPE_ENEMY2


shot_default_enemy:
   DB SHIP_TYPE_SHOT_ENEMY       ;ESTADO DE LA NAVE, PARA SABER SI ESTA VIVO O MUERTO
   DB SHIP_STATE_IA | SHIP_STATE_COLLIDER
   DB 20                                   ;POSY
   DB 2                                    ;VELY
   DB 90                                    ;POSX
   DB 0                                     ;VELX
   DB 4                                      ;SPRITE1
   DB %00000000                             ;ATRIBUTOS
   DB 0                                     ;FRAME_ANIMATION
   DB 0                                     ;DISPARO
   DB 0                                     ;TIPO
   DB 0  
   DB HIGH(sys_ai_autodestroy_shot_global)     ;PATRON
   DB LOW(sys_ai_autodestroy_shot_global)      ;PATRON
   DB $99
   DB SHIP_TYPE_PLAYER


shot_default_enemy2:
   DB SHIP_TYPE_SHOT_ENEMY       ;ESTADO DE LA NAVE, PARA SABER SI ESTA VIVO O MUERTO
   DB SHIP_STATE_IA | SHIP_STATE_COLLIDER
   DB 20                                   ;POSY
   DB 0                                    ;VELY
   DB 90                                    ;POSX
   DB -2                                     ;VELX
   DB 4                                      ;SPRITE1
   DB %00000000                             ;ATRIBUTOS
   DB 0                                     ;FRAME_ANIMATION
   DB 0                                     ;DISPARO
   DB 0                                     ;TIPO
   DB 0  
   DB HIGH(sys_ai_autodestroy_shot_global)     ;PATRON
   DB LOW(sys_ai_autodestroy_shot_global)      ;PATRON
   DB $99
   DB SHIP_TYPE_PLAYER


flower_default:
   DB TYPE_FLOWER
   DB 0
   DB 9*8                                        ;Posición Y
   DB 0
   DB 9*8                                        ;Posición X
   DB 0
   DB $52
   DB %00000000
   DB 0
   DB 0
   DB 8*8                                       ;Posición X Objetivo
   DB 9*8                                       ;Posición Y Objetivo
   DB 0
   DB 0
   DB 0                                         ;Tiempo de animación
   DB 0                                         ;Contra que colisiona

SECTION "Game Variables", WRAM0
    num_ships:                  DS 1        ;Número de naves activas
    num_shots:                  DS 1        ;Número de disparos activos
    num_entities:               DS 1        ;Número de entidades totales activas
    num_flowers:                DS 1
    player_shot:                DS 1        ;Número de disparos del jugador
    
    orientacion:                DS 1
    counter_create_enmies:      DS 1

    arrayFlores:                DS 5        ;Array de indices de flores que indica cual esta libre y cual no (unicamente un byte por flor a 1 o 0)
    arrayTimers:                DS 5        ;Array de los contadores cuando un enemigo llega a una flor

    arrayFloresLibres:          DS 5
    num_flowers_free:           DS 2

    current_entity_count:       DS 1        ;Contador de cuantas entidades se han procesado
    current_hl_byte1:           DS 1        ;Dirección almacenada de la entidad actual
    current_hl_byte2:           DS 1        ;Dirección almacenada de la entidad actual
    current_b:                  DS 1        ;Contador almacenado de entidades restantes (b)
    collision_in_progress:      DS 1        ;Indicador de si la comprobación esta en progreso
    player_lifes:               DS 1
    vblank_counter:             DS 1
    actual_max_counter_enemies: DS 1
    num_destroyed_enemies_to_create_air:      DS 1
    score:                      DS 2


SECTION "Disparos", WRAM0
    couldown_shot:                                  DS 1        ;Tiempo desde que dispara hasta que vuelva a disparar
    array_assign_enemy2:                            DS 2        ;Solo hay dos enemigos que disparan 
    array_help_flowers:                             DS 5

    is_pause:                                       DS 1        ;Si es 0 no esta en pausa si es 1 si
    explosion_timer:                                DS 1

    num_air_enemies:                                DS 1        ;Enemigos voladores creados, para controlar que sean 4 como máximo
    rotacion_creacion:                              DS 1        ;Enemigos voladores creados, para controlar que sean 4 como máximo
    counter_enemy_died_aument_vel_creation:         DS 1        ;Enemigos voladores creados, para controlar que sean 4 como máximo
    counter_creation_kamikace_enemy:                DS 1        ;Enemigos voladores creados, para controlar que sean 4 como máximo
    num_kamikaze_created:                           DS 1        ;Enemigos voladores creados, para controlar que sean 4 como máximo

    timer_create_flower:                            DS 1        ;Enemigos que tienes que matar para que se cree una flor

    warning_timer:                                  DS 1

    previous_component:                             DS 1

    player_dead:                                    DS 1

SECTION "Game Engine Functions", ROM0
man_game_init:

    call initialize_seed

    ld a, 3
    ld [player_lifes], a

    ld a, 0
    ld [player_dead], a


    ld [num_flowers], a
    ld [num_flowers_free], a
    ld [couldown_shot], a           ;Se inicia a 0 para que la primera vez que se dispare se pueda crear el disparo

    ld [player_shot], a

    ld [orientacion], a

    ld [collision_in_progress], a
    ld [current_entity_count], a
    ld [current_b], a
    ld [vblank_counter], a
    ld [score], a
    ld [score+1], a
    ld [num_destroyed_enemies_to_create_air], a
    ld [counter_enemy_died_aument_vel_creation], a
    ld [num_kamikaze_created], a

    ld [is_pause], a
    ld [explosion_timer], a

    ld [num_air_enemies], a
    ld [rotacion_creacion], a

    ld a, TIMER_CREATE_FLOWER_DEFAULT
    ld [timer_create_flower], a

    call man_game_init_array_flowers

    ;ld a, HIGH(entityArray)
    ;ld [current_hl_byte1], a
    ;ld a, LOW(entityArray)
    ;ld [current_hl_byte2], a

    ld a, COUNTER_WARNING_TIMER
    ld [warning_timer], a

    ld a, COUNTER_CREATE_ENEMY
    ld [counter_create_enmies], a
    ld [actual_max_counter_enemies], a
    ld [counter_creation_kamikace_enemy], a

    call man_entity_init
    call load_all_sprites_VRAM8x8
    call sys_render_setUp

    call limpiarSpriteBuffer

    ld a, ENTITY_SIZE
    ld de, player_default
    call man_game_create_templates_entity          ;Create player



    ld de, enemy1_default
    call man_game_create_templates_entity

    ld a, [num_air_enemies]
    inc a
    ld [num_air_enemies], a

    ld de, enemy2_default
    call man_game_create_templates_entity

    ld a, [num_air_enemies]
    inc a
    ld [num_air_enemies], a

    call man_create_flower_random
    call man_create_flower_random
    call man_create_flower_random
    call man_create_flower_random
    call man_create_flower_random
    call man_create_flower_random

    
ret

;Función: Inicializar el array de flores y el array de contadores de las flores a 0
man_game_init_array_flowers:
    ld a, 0

    ;Inicializar los indices de las flores que se asignan a los enemigos que disparan
    ld hl, array_assign_enemy2
    ld [hl+], a
    ld [hl], a

    ;Inicializar el array princpial de las flores que indica si esta muerta, asignada, llegada o libre
    ld b, 5
    ld hl, arrayFlores
    .initArrayFlores
    ld [hl], a
    inc hl
    dec b
    jr nz, .initArrayFlores

    ;Inicailiar el array de cuentas atras de las flores antes de ser destruidas
    ld a, TIMER_ENEMY_IN_FLOWER
    ld b, 5
    ld hl, arrayTimers
    .initArrayTimers
    ld [hl], a
    inc hl
    dec b
    jr nz, .initArrayTimers

    ;Inicializar el array temporal de flores libres para asignar flores aleatorias a los enemigos que van a por las flores
    ld a, $55
    ld b, 5
    ld hl, arrayFloresLibres
    .initArrayFree
    ld [hl], a
    inc hl
    dec b
    jr nz, .initArrayFree

ret

man_game_play:

    ;call dibuja_texto

    .gameLoop
        call man_game_update
        call sys_ai_update
        call man_animation_update
        call sys_physics_update
        call sys_collision_update
        call sys_render_update
        call man_entity_update

        ld hl, $9800
        call draw_score
        call estado_escena_game
        jr nz, .fin

        ld a, 5
        ld b, a
        ld a, [num_entities]
        sub b
        cp 8                    ; Si el número de entidades es menor a 10...
        jr nc, .skip_wait         ; ...salta la espera si hay más entidades
        jr z, .skip_wait

        .vBlank
        call wait_2_vblanks

        .skip_wait

    jr .gameLoop

.fin
ret

man_game_update:
    ;Comprobar si el player esta en modo explosión y si se tiene que poner en pausa el juego
    call man_game_trigger_explosion_and_pause
    call man_game_update_flower_timers
    call man_game_create_flowers_automatic
    call man_create_enemies_automatic

    call wait_for_warning_timer                 ;Decrementa el contador de la ventana

    call man_create_kamikace_enemy

    call man_actualize_objetive_kamikaze

    ;Decremenatar el couldown del disparo player si no es 0
    ld a, [couldown_shot]
    cp 0
    jr z, .no_decrease
    dec a
    ld [couldown_shot], a

    .no_decrease
ret

man_game_init_explosion_player:
    ld a, $20
    ld [explosion_timer], a

    ld a, 1
    ld [player_dead], a

    push hl
    ld hl, entityArray
    inc hl
    ld a, [hl]
    ld [previous_component], a
    ld a, 0
    ld [hl], a
    pop hl

    push hl
    ld hl, entityArray
    ld a, 0
    ld de, 0
    call man_entity_change_velocity

    pop hl
    
ret

man_game_trigger_explosion_and_pause:
    ld hl, entityArray          ;Siempre la primera posición es el jugador
    
    ld a, [explosion_timer]
    cp 0
    jr z, .no_explosion

    ld b, 3                     ;Sprite de la explosion


    push af                     ;Guardar a 
    call man_entity_change_sprite
    pop af

    ;Decrementar el contador de la explosion
    dec a
    ld [explosion_timer], a
    jr .fin


    .no_explosion
    ld hl, entityArray          ;Siempre la primera posición es el jugador
    call man_entity_get_sprite
    ld a, b
    cp 3
    jr nz, .no_cambiar

    push hl
        inc hl
        ld a, [previous_component]
        ld [hl], a
    pop hl

    ld b, 0
    call man_entity_change_sprite
    ld a, 0
    ld [orientacion], a

    ld a, 0
    ld [player_dead], a
    

    .no_cambiar
    .fin
ret



estado_escena_game:
;    ld a, [player_lifes]
;    cp 0
;    jr z, .Normal

;    ld a, [num_flowers]
;    cp 0
;    jr z, .Normal

;    ld a, 1
;    ld [SCENE_STATE], a

;    .Normal
;    ld a, [SCENE_STATE]
;    cp SCENE_GAME
    
    ld a, [paused]
    cp 1
    jr z, .pausado

    ld a, [player_lifes]
    cp 0
    jr z, .acabar

    ld a, [num_flowers]
    cp 0
    jr z, .acabar

    ld a, SCENE_GAME
    ld [SCENE_STATE], a
    cp SCENE_GAME

    jr .saltar

    .acabar
    ld a, SCENE_GAMEOVER
    ld [SCENE_STATE], a
    cp SCENE_GAME

    jr .saltar

    .pausado
    ld a, SCENE_PAUSED
    ld [SCENE_STATE], a
    cp SCENE_GAME

    .saltar
ret

wait_2_vblanks:
    ld a, [vblank_counter]
    cp 2                         ; Comprobar si ya han pasado 2 VBLANKs
    jr z, .done                  ; Si sí, salir de la espera

    push af
    call wait_vblank_start       ; Espera un VBLANK
    pop af
    inc a                        ; Incrementa el contador de VBLANK
    ld [vblank_counter], a       ; Guarda el nuevo contador de VBLANK
    jr wait_2_vblanks            ; Repetir hasta que se completen los 2 VBLANKs

    .done:
    ld a, 0
    ld [vblank_counter], a
ret

add_dead_to_score:
    ld a, [score]
    ld c, $01

    add c
    daa

    ld [score], a

    ld b, $00
    ld a, [score+1]
    adc b
    daa

    ld [score+1], a

    call create_air_enemy
    call decrease_counter_to_enemies_flowers

ret

decrease_counter_to_enemies_flowers:
    ld a, [counter_enemy_died_aument_vel_creation]
    inc a
    ld [counter_enemy_died_aument_vel_creation], a
    cp $07
    jr nz, .fin
    ld a, 0
    ld [counter_enemy_died_aument_vel_creation], a

    
    ld a, [actual_max_counter_enemies]
    cp 10
    jr c, .fin
    sub 7
    ld [actual_max_counter_enemies], a
    
    .fin

ret


create_air_enemy:

    ld a, [num_destroyed_enemies_to_create_air]
    inc a
    ld [num_destroyed_enemies_to_create_air], a
    cp $05
    jr nz, .fin
    ld a, 0
    ld [num_destroyed_enemies_to_create_air], a

    ld a, [num_air_enemies]
    cp 4
    jr z, .noCrea

    ld a, [rotacion_creacion]
    inc a
    cp 4
    jr nz, .sigueRotacion

    ld a, 0

    .sigueRotacion
    ld [rotacion_creacion], a

    ld a, [rotacion_creacion]
    cp 0
    jr z, .horizontal
    cp 1
    jr z, .vertical
    cp 2
    jr z, .horizontal
    cp 3
    jr z, .vertical


    .horizontal
    ld de, enemy1_default
    cp 0
    jr z, .desde0
    ld c, 135
    ld b, 135

    jr .final

    .vertical
    ld de, enemy2_default
    cp 1
    jr z, .desde3
    ld c, 150
    ld b, 150


    jr .final

    .desde0
    ld c, 35
    ld b, 35

    jr .final

    .desde3
    ld c, 15  ;Posicion x o y a poner, me es igual
    ld b, 50

    jr .final


    .final

    ld a, [num_air_enemies]
    inc a
    ld [num_air_enemies], a

    push hl
    push bc
    call man_game_create_templates_entity
    pop bc

    ld a, c
    call man_entity_change_posx

    ld c, b
    call man_entity_change_posy
    pop hl

    .noCrea
   
    .fin

ret


obtain_up_number:
    ;Comprobamos las milesimas
       rra
       rra
       rra
       rra
       and $0F

       ld b, a
       ld a, $7A

       add b
       ld [hl], a
ret

obtain_down_number:

       and $0F

       ld b, a
       ld a, $7A

       add b
       ld [hl], a
ret

draw_score:
    ld a, [score+1]

    call obtain_up_number

    inc hl
    ld a, [score+1]

    call obtain_down_number

    inc hl
    ld a, [score]

    call obtain_up_number

    inc hl
    ld a, [score]

    call obtain_down_number

ret

draw_High_score:
    ld a, [max_score]

    call obtain_up_number

    inc hl
    ld a, [max_score]

    call obtain_down_number

    inc hl
    ld a, [max_score+1]

    call obtain_up_number

    inc hl
    ld a, [max_score+1]

    call obtain_down_number

ret



; ///////// FUNCION INICIALIZACION VALORES ////////////
;Función: Crea los valores de las entidades tanto enemigas como las del jugador con valores predeterminados
;--------------------------------------
;Input: DE (Dirección de la entidad por defecto)
;Modifica: B, HL, A
man_game_create_templates_entity:  
    push de
    call man_entity_find_first_free_slot
    pop de 
    push hl
    call man_setEntityValues            ;Modifica los valores del array de naves con los valores de la nave por defecto
    pop hl                            ;Guarda la dirección de la entidad nueva

    ld a, [num_entities]
    inc a
    ld [num_entities], a
ret

;Función: Sustituye los datos de una entidad en HL por los datos default pasados en HL
;Input: HL(Dirección donde escribir los datos), DE (Dirección de los datos default)
man_game_create_flower_in_dead:

    ld b, ENTITY_SIZE
    push hl
    .darValores
        ld a, [de]
        ld [hl], a
        inc de
        inc hl
        dec b
    jr nz, .darValores
    pop hl

    ;ld [hl], $99                ;Dejarlo de momento como muerto para la comprobación siguiente

    push hl
    .generar_x
    call generate_random
    cp 24
    jr c, .generar_x         ;Si es más pequeño que 24 que vueva a generar
    cp 144
    jr nc, .generar_x        ;Si es mayor que 144 que vuelva a generar

    ;Comprobar si hay otra en esa pos
    call man_entity_find_first_flower
    ld b, 5
    ld c, a                             ;C = Posición X de la flor creada

    .loop
        ld a, [hl]
        cp TYPE_FLOWER_DEAD
        jr z, .no_check

        call man_entity_get_pos_x       ;A = Posición X de la flor en HL
        cp c
        jr z, .generar_x

        call man_entity_get_pos_x       ;A = Posición X de la flor en HL   
        cp c                            ;Carry = C es mayor que A (flor creada por delante)
        jr nc, .HL_por_delante
    
        ;La posición de la flor creada es mayor que la de la flor que estamos comprobando
        push bc
        ld d, a                         ;D = Posición de la flor que estamos comprobando
        ld a, c                         ;A = Posició de la flor creada
        ld c, d                         ;C = Posición de la flor que estamos comrpobando

        sub c                            ;A = PosX flor creada - PosX flor HL
        pop bc
        cp 10
        jr c, .generar_x

        jr .no_check


        .HL_por_delante
        ;La posición de la flor que estamos comprobando es mayor que la de la flor que hemos creado
        sub c                            ;A = PosX flor HL - PosX flor creada
        cp 10
        jr c, .generar_x

        
        .no_check
            call incPos
            dec b
    jr nz, .loop

    pop hl

    ld a, c
    call man_entity_change_posx

    
    ;Comprobar si hay otra con esa pos
    ;push hl
    ;ld c, a                 ;C = Pos X
    ;ld b, MAX_FLOWERS
    ;call man_entity_find_first_flower
    ;.check_pos_X_with_others
;
    ;    ld a, [hl]
    ;    cp TYPE_FLOWER_DEAD
    ;    jr z, .no_check
;
    ;    ;Obtener la posición X de la flor en HL
    ;    call man_entity_get_pos_x
;
    ;    cp c
    ;    jr nc, .HL_por_delante
;
    ;    ld d, c
    ;    ld c, a
    ;    ld a, d
    ;    cp c                ;PosX de C - PosX actual HL
    ;    jr c, .generar_x
;
    ;    jr .no_check
;
;
    ;    .HL_por_delante
    ;    ;Comprobar la distancia en el eje X con la posición C
    ;    sub c               ; A = PosX actual HL - PosX de C
    ;    cp 20
    ;    jr c, .generar_x
;
;
;
    ;    .no_check
    ;    call incPos
    ;    dec b
    ;jr nz, .check_pos_X_with_others
;
    ;pop hl


    ;ld [hl], $40                ;Marcarlo como flor otra vez
    
    

    push hl
    .generate_y
    call generate_random
    cp 32
    jr c, .generate_y       ;Si es menor que 16 que vuelva a genarar
    cp 136
    jr nc, .generate_y      ;Si es mayor que 136 que vuelva a generar

    ;Comprobar si hay otra en esa pos
    call man_entity_find_first_flower
    ld b, 5
    ld c, a                             ;C = Posición X de la flor creada

    .loop_y
        ld a, [hl]
        cp TYPE_FLOWER_DEAD
        jr z, .no_check_y

        call man_entity_get_pos_y       ;A = Posición X de la flor en HL
        cp c
        jr z, .generate_y

        call man_entity_get_pos_y       ;A = Posición X de la flor en HL   
        cp c                            ;Carry = C es mayor que A (flor creada por delante)
        jr nc, .HL_por_delante_y
    
        ;La posición de la flor creada es mayor que la de la flor que estamos comprobando
        push bc
        ld d, a                         ;D = Posición de la flor que estamos comprobando
        ld a, c                         ;A = Posició de la flor creada
        ld c, d                         ;C = Posición de la flor que estamos comrpobando

        sub c                            ;A = PosX flor creada - PosX flor HL
        pop bc
        cp 5
        jr c, .generate_y

        jr .no_check_y


        .HL_por_delante_y
        ;La posición de la flor que estamos comprobando es mayor que la de la flor que hemos creado
        sub c                            ;A = PosX flor HL - PosX flor creada
        cp 5
        jr c, .generate_y

        
        .no_check_y
            call incPos
            dec b
    jr nz, .loop_y

    pop hl


    call man_entity_change_posy

    ld a, [num_flowers]
    inc a
    ld [num_flowers], a
ret

man_game_create_flowers_automatic:
    ld a, [num_flowers]
    cp MAX_FLOWERS
    jr z, .no_create

    ld a, [timer_create_flower]
    cp 0
    jr nz, .no_timer

    ;Avisar al jugador
    call set_up_window
    ld a, COUNTER_WARNING_TIMER
    ld [warning_timer], a

    ;Crear la flor nueva
    call man_entity_find_first_flower_dead
    ld de, flower_default
    call man_game_create_flower_in_dead

        ; NR21 - Duración y onda cuadrada
    ld a, %10000000      ; Duración más larga, onda cuadrada al 50%
    ld [$FF16], a        ; Registrar en NR21 para canal 2

    ; NR22 - Envolvente de volumen
    ld a, %00001011      ; Volumen inicial bajo (0), envolvente creciente y rápida
    ld [$FF17], a        ; Registrar en NR22 para canal 2

    ; NR23 - Parte baja de la frecuencia
    ld a, $60            ; Frecuencia media para un tono de pitch moderado
    ld [$FF18], a        ; Registrar en NR23

    ; NR24 - Parte alta de la frecuencia y reinicio del canal
    ld a, %10000000      ; Activar el sonido con frecuencia media y reiniciar
    ld [$FF19], a        ; Registrar en NR24
    
    ;Reinciar el número de enemigso que tiene que matar
    ld a, TIMER_CREATE_FLOWER_DEFAULT
    ld [timer_create_flower], a

    .no_timer
    .no_create
ret

man_create_kamikace_enemy:
    ld a, [counter_creation_kamikace_enemy]
    cp 0
    jr nz, .noCrea

    .crea
    ld a, 110
    ld [counter_creation_kamikace_enemy], a

    ld a, [num_kamikaze_created]
    cp 1
    jr z, .fin
    call man_game_create_enemy_kamikace
    ld a, [num_kamikaze_created]
    inc a
    ld [num_kamikaze_created], a
    jr .fin

    .noCrea
    dec a
    ld [counter_creation_kamikace_enemy], a
    .fin

ret

man_game_create_enemy_kamikace:

    ld hl, entityArray                  ;HL (Entidad del jugador)
    ld a, [num_entities]
    ld b, a                             ;B: Número de naves activas
                                        
    


    ld de, ENTITY_POSY                              ;Posicion del jugador en ese momento
    call man_entity_obtein_by_index

    ld a, [hl]
    ld b, a

    inc hl
    inc hl

    ld a, [hl]
    ld c, a

    ;B(posicion Y del jugador) C(posicion X del jugador)

    push de
    push bc
        ld de, enemy3_default
        call man_game_create_templates_entity       ;HL: Dirección de la entidad creada
    pop bc
    pop de

    push hl
    ld de, ENTITY_POS_OBJ_X
    call man_entity_obtein_by_index

    ld a, c
    ld [hl], a

    inc hl

    ld a, b
    ld [hl], a
    pop hl

    ;A = Numero aletorio entre 0 y 3 con el timer no con el generate_random
    push hl
    ld a, [$FF04]
    and 3
    pop hl

    cp 0
    jr nz, .check1
    push af
    ld a, 0
    call man_entity_change_posx
    ld c, 0
    call man_entity_change_posy
    pop af

    jr .fin

    .check1
    cp 1
    jr nz, .check2
    push af
    ld a, 160
    call man_entity_change_posx
    ld c, 0
    call man_entity_change_posy
    pop af
    jr .fin

    .check2
    cp 2
    jr nz, .check3
    push af
    ld a, 0
    call man_entity_change_posx
    ld c, 144
    call man_entity_change_posy
    pop af
    jr .fin

    .check3
    push af
    ld a, 160
    call man_entity_change_posx
    ld c, 144
    call man_entity_change_posy
    pop af
    jr .fin
    

    .fin
    ;He guardado la posicion actual de tu nave en la posicion objetivo del enemigo que creo
ret

man_actualize_objetive_kamikaze:
    ld hl, entityArray
    ld a, [num_entities]
    ld b, a                             ;B: Número de naves activas

    .bucle
        ld a, [hl]                      ;A: Estado de la nave
        cp SHIP_TYPE_INVALID
        jr z, .noCallFunc
        cp SHIP_TYPE_EXPLOSION
        jr z, .noCallFunc

        cp SHIP_TYPE_ENEMY3
        jr nz, .notDoPopBC

        ld d, h
        ld e, l

;        ld a, [player_in_array_position]
;        ld h, a
;
;        ld a, [player_in_array_position+1]
;        ld l, a

        ld hl, entityArray

        ;HL(posicion en el array de la nave principal)
        ;DE(Posicion de la nave kamikaze que ha encontrado en el array)
        push bc

        push de
        ld de, ENTITY_POSY
        call man_entity_obtein_by_index
        ld a, [hl]
        ld b, a

        inc hl
        inc hl

        ld a, [hl]
        ld c, a

        ;B(posicion Y de la nave principal), C(Posicion x de la nave principal)
        pop de

        ld h, d
        ld l, e     ;HL(direccion de la nave kamikaze)

        ld de, ENTITY_POS_OBJ_X
        call man_entity_obtein_by_index
        
        ld a, c
        ld [hl], a

        inc hl

        ld a, b
        ld [hl], a

        pop bc
        jr .notDoPopBC

        .noCallFunc

        call incPos
        jr .bucle

        
        .notDoPopBC
        call incPos

        dec b

    jr nz, .bucle

ret

man_create_enemies_automatic:
    ld a, [counter_create_enmies]
    cp 0
    jr nz, .noCrea

    .crea
    ld a, [actual_max_counter_enemies]
    ld [counter_create_enmies], a
    call man_game_create_enemy_flower2
    jr .fin

    .noCrea
    dec a
    ld [counter_create_enmies], a
    .fin
ret

man_game_create_enemy_flower2:

    ld hl, arrayFlores
    ld b, 5                         ;Longitud del array de flores
    ld c, 0                         ;Indice de la flor a añadir
    ld de, arrayFloresLibres

    ld a, 0
    ld [num_flowers_free], a

    .crear_array_flores_libres
        ld a, [hl]
        cp 0
        jr nz, .no_add

        ld a, c
        ld [de], a
        inc de
        ld a, [num_flowers_free]
        inc a
        ld [num_flowers_free], a    ;Incrementar el numero de flores libres

        .no_add
        inc hl
        inc c                       ;Incrementar el indice de la flor que se va a revisar
        dec b                       ;Decrementar el numero de flores por revisar
    jr nz, .crear_array_flores_libres

    ld a, [num_flowers_free]
    cp 0
    jp z, .not_found

    ;Generar un número aleatorio del 0 al [num_flowers_free] que es el tamaño usable del array de arrayFloresLibres (numero de posiciones libres)
    .generar_indice_aleatorio
    ld a, [num_flowers_free]
    ld b, a                         ;Cargar el valor del tamaño del array temporal en B
    dec b                           ; 0 a 5-1
    push bc
    push hl
    call generate_random
    pop hl
    pop bc
    and b                           ;A = valor aleatorio entre 0 y B


    ld hl, arrayFloresLibres        ;HL = Inicio de array con indices libres
    add a, l                        ;Suma el indice aleatorio a HL
    ld l, a                         ;Guarda la posición del índice a asignar (HL)

    ;HL = Posición con el indice de una flor libre aleatoria
    ld a, [hl]                      ;A = Indice de una flor libre aleatoria
    ld d, a                         ;D = Indice de una flor libre aleatoria

    push de
        ld de, enemy_default
        call man_game_create_templates_entity       ;HL: Dirección de la entidad creada
    pop de

    push hl
        push de
            ; Asignar indice de flor (D)
            ld de, ENTITY_TIMER_EXPLOSION
            call man_entity_obtein_by_index
        pop de

        ld [hl], d                                  ;D: Indice de la flor libre
    pop hl

    push hl                                         ;HL: Dirección del enemigo creado

    ;Marcar la flor como asignada
    push hl
        ld hl, arrayFlores
        ld a, d                                     ;D = Incide de la flor libre
        cp 0
        jr z, .marcar

        push de
        .avanzarParaMarcar
            inc hl
            dec d
        jr nz, .avanzarParaMarcar
        pop de

        .marcar
        ld [hl], 1
    pop hl

    ;Operaciones con la flor en el entityArray
    ld hl, entityArray
    push bc
    push de
    call man_entity_find_first_flower               ;HL: Dirección de la primera flor
    pop de
    pop bc

    ;Avanzar en el array de entidades a partir de la primera flor
    ld a, d
    cp 0
    jr z, .noAvanzar
    .avanzarHastaFlorSinAsignar
        call man_entity_next_entity
        dec d
    jr nz, .avanzarHastaFlorSinAsignar
    .noAvanzar

    ;HL: Dirección de la primera flor sin asignar a ningun enemigo
    ;Coger la posicion de la flor seleccionada y ponerla como objetivo al enemigo creado
    push hl
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index


    ld a, [hl]
    ld b, a                                     ;B: PosY de la primera flor libre
    pop hl

    push hl
    ld de, ENTITY_POSX
    call man_entity_obtein_by_index

    ld a, [hl]
    ld c, a                                     ;C: PosX de la primera flor libre
    pop hl

    ;Guardar estos valores bc en los campos de la entidad creada, que lo devuelve man_game_create_templates_entity
    pop hl

    .generar_random
    push bc
    push hl
    .generar_x
        call generate_random
        cp 168
    jr nc, .generar_x               ;Si el numero generado es mayo que el limite que le he puesto vuelve a generar uno
    pop hl
    pop bc
    call man_entity_change_posx

    push bc
    push hl
    .generar_y
        call generate_random
        cp 152
    jr nc, .generar_y
    pop hl
    ld c, a
    call man_entity_change_posy
    pop bc




    ld de, ENTITY_POS_OBJ_X
    call man_entity_obtein_by_index

    ld [hl], c                                  ;Se guarda en la posición X de la flor en el campo del enemigo de pos x objetivo
    inc hl
    ld [hl], b                                  ;Se guarda en la posición Y de la flor en el campo del enemigo de pos y objetivo


.not_found
ret

man_game_create_enemy_flower:
    
    ;Elegir flor
    ld hl, arrayFlores
    ld c, 5                                     ;Tamaño del array de flores
    ld d, 0                                     ;Indice de la primera flor libre
    ld b, 0                                     ;Indica que la flor esta sin asignar

    .buscarFlorLibre
    ld a, [hl]
    cp b
    jr z, .encontrado
    inc hl
    inc d                                       ;D: Indice de la primera flor libre
    dec c                                      
    jr nz, .buscarFlorLibre

    jr .noEncontrado

    .encontrado
                                                ;B: Indice de la primera flor libre
    push de 
        ld de, enemy_default
        call man_game_create_templates_entity       ;HL: Dirección de la entidad creada
    pop de

    push hl
        push de
            ; Asignar indice de flor (D)
            ld de, ENTITY_TIMER_EXPLOSION
            call man_entity_obtein_by_index
        pop de
        
        ld [hl], d                                  ;D: Indice de la primera flor libre
    pop hl
                                          

    push hl                                     ;HL: Dirección del enemigo creado

    push hl
        ld hl, arrayFlores
        ld a, d
        cp 0
        jr z, .marcar

        push de
        .avanzarParaMarcar
            inc hl
            dec d
        jr nz, .avanzarParaMarcar
        pop de

        .marcar
        ld [hl], 1
    pop hl                                      ;HL: Dirección de la primera flor


    ld hl, entityArray
    push bc
    push de
    call man_entity_find_first_flower           ;HL: Dirección de la primera flor
    pop de
    pop bc

    ;Avanzar en el array de entidades a partir de la primera flor
    ld a, d
    cp 0
    jr z, .noAvanzar
    .avanzarHastaFlorSinAsignar
        call man_entity_next_entity
        dec d
    jr nz, .avanzarHastaFlorSinAsignar
    .noAvanzar
                                                ;HL: Dirección de la primera flor sin asignar a ningun enemigo


    ;Coger la posicion de la flor seleccionada y ponerla como objetivo al enemigo creado 
    push hl
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index
    
    
    ld a, [hl]
    ld b, a                                     ;B: PosY de la primera flor libre
    pop hl

    push hl
    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    
    ld a, [hl]
    ld c, a                                     ;C: PosX de la primera flor libre
    pop hl

    ;Guardar estos valores bc en los campos de la entidad creada, que lo devuelve man_game_create_templates_entity
    pop hl

    .generar_random
    push bc
    push hl
    .generar_x
        call generate_random
        cp 168
    jr nc, .generar_x               ;Si el numero generado es mayo que el limite que le he puesto vuelve a generar uno
    pop hl
    pop bc
    call man_entity_change_posx
    
    push bc
    push hl
    .generar_y
        call generate_random
        cp 152
    jr nc, .generar_y
    pop hl
    ld c, a
    call man_entity_change_posy
    pop bc
    
    


    ld de, ENTITY_POS_OBJ_X
    call man_entity_obtein_by_index

    ld [hl], c                                  ;Se guarda en la posición X de la flor en el campo del enemigo de pos x objetivo
    inc hl
    ld [hl], b                                  ;Se guarda en la posición Y de la flor en el campo del enemigo de pos y objetivo
    
    .noEncontrado
ret


man_create_flower_random:
    

    ld a, [num_flowers]
    ld b, a
    cp MAX_FLOWERS
    jp z, .end

    ld de, flower_default
    call man_game_create_templates_entity

    ld a, [num_flowers]
    ld b, a

    push hl
    .generar_x
    call generate_random
    cp 24
    jr c, .generar_x         ;Si es más pequeño que 24 que vueva a generar
    cp 144
    jr nc, .generar_x        ;Si es mayor que 144 que vuelva a generar

    ;Comprobar si hay otra en esa pos
    call man_entity_find_first_flower
    ld b, 5
    ld c, a                             ;C = Posición X de la flor creada
    ld a, b
    cp 0
    jr z, .no_comprobar_x

    .loop
        ld a, [hl]
        cp TYPE_FLOWER_DEAD
        jr z, .no_check

        call man_entity_get_pos_x       ;A = Posición X de la flor en HL
        cp c
        jr z, .generar_x

        call man_entity_get_pos_x       ;A = Posición X de la flor en HL   
        cp c                            ;Carry = C es mayor que A (flor creada por delante)
        jr nc, .HL_por_delante
    
        ;La posición de la flor creada es mayor que la de la flor que estamos comprobando
        push bc
        ld d, a                         ;D = Posición de la flor que estamos comprobando
        ld a, c                         ;A = Posició de la flor creada
        ld c, d                         ;C = Posición de la flor que estamos comrpobando

        sub c                            ;A = PosX flor creada - PosX flor HL
        pop bc
        cp 10
        jr c, .generar_x

        jr .no_check


        .HL_por_delante
        ;La posición de la flor que estamos comprobando es mayor que la de la flor que hemos creado
        sub c                            ;A = PosX flor HL - PosX flor creada
        cp 10
        jr c, .generar_x

        
        .no_check
            call incPos
            dec b
    jr nz, .loop

    .no_comprobar_x
    pop hl


    ld a, c
    call man_entity_change_posx

    ld a, [num_flowers]
    ld b, a

    push hl
    .generate_y
    push bc
    call generate_random
    pop bc

    cp 32
    jr c, .generate_y       ;Si es menor que 32 que vuelva a genarar
    cp 136
    jr nc, .generate_y      ;Si es mayor que 136 que vuelva a generar


    ;Comprobar si hay otra en esa pos
    call man_entity_find_first_flower
    ld c, a                             ;C = Posición X de la flor creada
    ld a, b
    cp 0
    jr z, .no_comprobar

    .loop_y
        ld a, [hl]
        cp TYPE_FLOWER_DEAD
        jr z, .no_check_y

        call man_entity_get_pos_y       ;A = Posición X de la flor en HL
        cp c
        jr z, .generate_y

        call man_entity_get_pos_y       ;A = Posición X de la flor en HL   
        cp c                            ;Carry = C es mayor que A (flor creada por delante)
        jr nc, .HL_por_delante_y
    
        ;La posición de la flor creada es mayor que la de la flor que estamos comprobando
        push bc
        ld d, a                         ;D = Posición de la flor que estamos comprobando
        ld a, c                         ;A = Posició de la flor creada
        ld c, d                         ;C = Posición de la flor que estamos comrpobando

        sub c                            ;A = PosX flor creada - PosX flor HL
        pop bc
        cp 5
        jr c, .generate_y

        jr .no_check_y


        .HL_por_delante_y
        ;La posición de la flor que estamos comprobando es mayor que la de la flor que hemos creado
        sub c                            ;A = PosX flor HL - PosX flor creada
        cp 5
        jr c, .generate_y

        
        .no_check_y
            call incPos
            dec b
    jr nz, .loop_y

    .no_comprobar

    pop hl

    ;ld c, a
    call man_entity_change_posy

    ld a, [num_flowers]
    inc a
    ld [num_flowers], a

    .end
ret


man_entity_create_flower:
    ld de, flower_default
    call man_game_create_templates_entity

    ld a, [num_flowers]
    ld b, a
    cp MAX_FLOWERS
    jr z, .end

    ;FLOR 1, 2
    cp 1
    jr nz, .noFlor1
    ld c, 9*8
    call man_entity_change_posy
    ld a, 11*8
    call man_entity_change_posx

    ;FLOR 2, 1
    .noFlor1
    ld a, b
    cp 2
    jr nz, .noFlor2
    ld c, 10*8
    call man_entity_change_posy
    ld a, 12*8
    call man_entity_change_posx

    ;FLOR 3, 1
    .noFlor2
    ld a, b
    cp 3
    jr nz, .noFlor3
    ld c, 11*8
    call man_entity_change_posy
    ld a, 10*8
    call man_entity_change_posx

    ;FLOR 4, 1
    .noFlor3
    ld a, b
    cp 4
    jr nz, .noFlor4
    ld c, 12*8
    call man_entity_change_posy
    ld a, 9*8
    call man_entity_change_posx

    ;FLOR 4, 2
    .noFlor4
    ld a, b
    cp 5
    jr nz, .noFlor5
    ld c, 12*8
    call man_entity_change_posy
    ld a, 11*8
    call man_entity_change_posx

    .noFlor5
    ld a, [num_flowers]
    inc a
    ld [num_flowers], a
    
    .end
ret

; ///////// FUNCION CREACIÓN DE DISPARO DEL JUGADOR ////////////
;Función: Crea un disparo del jugador
;--------------------------------------
;Input: HL (Dirección de la entidad que dispara)
man_create_shot_player:
    
    ld a, [couldown_shot]
    cp 0
    jr nz, .no_create_shot

    ;Inicializar el couldown del disparo
    ld a, COULDOWN_SHOT_PLAYER
    ld [couldown_shot], a

    ld a, [player_shot]
    cp 0
    jr nz, .noDispara

    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    ld a, [hl]                      ;POSX
    ;add 3                           ;Añadir 3 para que salga del centro de la nave

    dec hl
    dec hl
    ld c, [hl]                      ;POSY

    ld de, shot_default
    push af
    call man_game_create_templates_entity       ;HL: Dirección del disparo
    call change_direction_shot
    pop af
    
    call man_entity_change_posx
    call man_entity_change_posy

    ld a, 1
    ld [player_shot], a

    ; NR21 - Duración y onda cuadrada
    ld a, %10000000      ; Duración más larga, onda cuadrada al 50%
    ld [$FF16], a        ; Registrar en NR21 para canal 2

    ; NR22 - Envolvente de volumen
    ld a, %11100011      ; Volumen inicial alto (15), rápida envolvente decreciente
    ld [$FF17], a        ; Registrar en NR22 para canal 2

    ; NR23 - Parte baja de la frecuencia
    ld a, $10            ; Frecuencia baja para tono grave
    ld [$FF18], a        ; Registrar en NR23

    ; NR24 - Parte alta de la frecuencia y reinicio del canal
    ld a, %10000000      ; Activar el sonido con frecuencia baja y reiniciar
    ld [$FF19], a        ; Registrar en NR24 

.no_create_shot
.noDispara    
ret


;HL: Direccion de la nave
man_rotate_player:
    ld e, ENTITY_SPRITE1
    call man_entity_obtein_by_index

    push af

    ld a, [orientacion]
    inc a
    ld d, a

    cp 4
    jr z, .cero
    cp 2
    jr z, .dos
    cp 3
    jr z, .tres
    cp 1
    jr z, .uno

    .cero
    call man_return_atribute_rotate_toHL
    ld a, 0
    ld d, 0
    jr .fin
    
    .dos
    call man_atribute_rotate_toHL
    ld a, 0
    jr .fin

    .tres
    call man_atribute_rotate_toHL
    ld a, $10
    jr .fin

    .uno
    call man_return_atribute_rotate_toHL
    ld a, $10
    jr .fin

    .fin
    dec hl
    ld [hl], a
    ld a, d
    ld [orientacion], a

    pop af

ret

man_atribute_rotate_toHL:
    inc hl
    ld a, [hl]
    or %01100000
    ld [hl], a
ret

man_return_atribute_rotate_toHL:
    inc hl
    ld a, [hl]
    and %00000000
    ld [hl], a
ret


change_direction_shot:

    ld a, [orientacion]

    push hl
    ld de, ENTITY_SPRITE1
    call man_entity_obtein_by_index

    ld d, 0             ;Velocidad Y que no cambia pero hay que pasarla a la función de cambio de velocidad
    ld e, 0

    cp 0
    jr nz, .comp2
    ld d, -4

    ld [hl], $04
    call man_return_atribute_rotate_toHL

    jr .fin

    .comp2
    cp 1
    jr nz, .comp3
    ld e, 4

    ld [hl], $14
    call man_atribute_rotate_toHL

    jr .fin

    .comp3
    cp 2
    jr nz, .comp4
    ld d, 4

    ld [hl], $04
    call man_atribute_rotate_toHL

    jr .fin

    .comp4
    ld e, -4
    ld [hl], $14
    call man_return_atribute_rotate_toHL

    .fin
    pop hl

    call man_entity_change_velocity

ret



man_create_enemy_shot:
    push hl
    ld a, [num_shots]
    cp MAX_SHOTS_ENEMY
    jp z, .noDispara

    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    ld a, [hl]

    dec hl
    dec hl
    ld c, [hl]  

    inc hl
    ld b, [hl] 

    push af

        ld a, b
        cp 0
        jr z, .Horizontal

        ld de, shot_default_enemy2
        jr .salto

        .Horizontal
        ld de, shot_default_enemy

        .salto

    pop af
    
    push af
    push bc
    call man_game_create_templates_entity
    pop bc
    pop af

    push de
    call man_entity_change_posx
    call man_entity_change_posy
    pop de ;Comprobar con de hacia donde se dispara y luego comprobar la x y la y del personaje para saber donde tiene que disparar

    call man_where_enemy_shot

    push hl
    ld de, ENTITY_VY
    call man_entity_obtein_by_index

    ld a,[hl]           ;tiene la velocidad de y
    cp 0
    jr z, .horizontal
    cp 4
    jr nz, .arriba
    ld a, 2

    jr .comprobar

    .arriba
    ld a, 0

    jr .comprobar

    .horizontal
    inc hl
    inc hl
    ld a,[hl]
    cp 4
    jr nz, .izquierda
    ld a, 3

    jr .comprobar

    .izquierda
    ld a, 1

    .comprobar
    pop hl

    ld de, ENTITY_SPRITE1
    call man_entity_obtein_by_index

    cp 0
    jr nz, .comp2

    ld [hl], $04                            ;Dispara Para arriba
    call man_return_atribute_rotate_toHL

    jr .fin

    .comp2
    cp 1
    jr nz, .comp3

    ld [hl], $14                            ;Derecha y izquierda
    call man_return_atribute_rotate_toHL

    jr .fin

    .comp3
    cp 2
    jr nz, .comp4

    ld [hl], $04
    call man_atribute_rotate_toHL

    jr .fin

    .comp4
    ld [hl], $14
    call man_atribute_rotate_toHL

    .fin

    ld a, [num_shots]
    inc a
    ld [num_shots], a

    
    

.noDispara
pop hl
ret


man_where_enemy_shot:

    ;hl es la entidad disparo
    ;a es la posicion x de quien dispara
    ;c es la posicion y de quien dispara

    ld e, a         ;Ahora e tiene la posicion x de quien dispara
    ld d, c         ;Y d tiene la posicion y de quien dispara
    ld a, b         ;a tiene b, que es la velocidad de quien dispara

    ld b, -4        ;tiene la velocidad de los disparos

    cp 0
    jr z, .Horizontal

    ld a, e         ;Cuanddo el movimiento es vertical
    cp 50
    jr nc, .meterAHL
    ld b, 4

    .meterAHL
    push hl
    ld de, ENTITY_VX
    call man_entity_obtein_by_index

    ld [hl], b
    pop hl
    
    jr .salto

    .Horizontal

    ld a, d
    cp 50
    jr nc, .meterAHL2
    ld b, 4

    .meterAHL2

    push hl
    ld de, ENTITY_VY
    call man_entity_obtein_by_index

    ld [hl], b
    pop hl

    .salto


ret

man_game_destroy_shot:
    
    ld a, 0
    ld [player_shot], a
    

    call man_entity_destroy
ret

man_game_destroy_shot_enemy:

    ld a, [num_shots]
    dec a
    ld [num_shots], a
    call man_entity_destroy
ret

; ///////// FUNCION DESTRUCCION DE FLORES ////////////
;Función: Desmarca una flor como asignada
;--------------------------------------
;Input: A(Indice de la flor a desmarcar)
man_game_unassign_flower:
    ld hl, arrayFlores
    cp 0
    jr z, .unassing
    .avanzar
        inc hl
        dec a
    jr nz, .avanzar
    .unassing
    ld [hl], 0
ret

;Función actualizar los timers de las flores, si es diferente a 2, lo reinicia y si es 2 decrementa 1 hasta llegar a 0
;OUTPUT: C (indice de la flor a actualizar el contador)
man_game_update_flower_timers:
    ld hl, arrayFlores
    ld b, MAX_FLOWERS
    ld c, 0                 ;Indice de la flor a actualizar

    .loop
        ld a, [hl]
        ;cp 2
        ;jr nz, .no_decrease
        push bc
            push hl
                call man_game_update_flower_timer
            pop hl
        pop bc
        ;.no_decrease
        inc hl              ;Incrementar la posición en el
        inc c               ;Incrementar el índice

        dec b               ;Decrementar el número de flores por comprobar
    jr nz, .loop

ret


;Función: Actualiza un timer a partir del indice de la flor
;INPUT: C (Indice de la flor a actualizar el timer)
man_game_update_flower_timer:
    ld hl, arrayTimers      
    ld e, a                 ;E = Estado de la flor
    ld a, c                 ;A = Indice de la flor a actualizar el contador 
    ld d, c                 ;D = Indice de la flor a actualizar el contador
    ld c, 0
    .loop
        cp c 
        jr z, .located
        inc hl
        inc c               ;Incrementar el indice a comprar con A
    jr .loop                ;No comprobaciones porque tiene que estar dentro de los 5 flores, arriba lo obtenemos


    .located
    ld a, e
    cp 0
    jr z, .default
    cp 1
    jr z, .default
    cp $99
    jr z, .fin
    cp 02
    jr z, .continue

    .default

    ld a, TIMER_ENEMY_IN_FLOWER
    ld [hl], a              ;Reinciar el contador


    .continue
    ld a, [hl]
    ld c, a
    dec a
    ld [hl], a

    ld a, c
    cp 0
    jr nz, .no_reset        ;Si el anterior (C) era 0 se reinicia

    ld a, TIMER_ENEMY_IN_FLOWER
    ld [hl], a              ;Reinciar el contador

    ;Marcar flor como muerta
    ld hl, arrayFlores
    push de
    ld a, d                 ;A = Indice de la flor
    ld d , 0
    .loop_flowers
        cp d
        jr z, .found

        inc hl
        inc d
    jr .loop_flowers        ;Nunca va a salir del bucle sin haberlo encontrado, ya que si o si esta dentro de 5


    .found
        ld a, $99
        ld [hl], a
    pop de

    
    ;Destruir enemigo que ha matado a la flor
    call man_entity_find_enemy_flower_id        ;HL = Dirección del enemigo asociado a la flor
    call man_entity_destroy

    ;Destruir la flor en el array de entidades ($99)
    call man_entity_find_flower_id
    ld a, $99
    ld [hl], a

    ld a, [num_flowers]
    dec a
    ld [num_flowers], a

    ; NR21 - Duración y onda cuadrada
    ld a, %10000000      ; Duración más larga, onda cuadrada al 50%
    ld [$FF16], a        ; Registrar en NR21 para canal 2

    ; NR22 - Envolvente de volumen
    ld a, %11100110      ; Volumen inicial alto (15), envolvente descendente y lenta
    ld [$FF17], a        ; Registrar en NR22 para canal 2

    ; NR23 - Parte baja de la frecuencia
    ld a, $50            ; Frecuencia baja para un tono grave
    ld [$FF18], a        ; Registrar en NR23

    ; NR24 - Parte alta de la frecuencia y reinicio del canal
    ld a, %10000000      ; Activar el sonido con frecuencia baja y reiniciar
    ld [$FF19], a        ; Registrar en NR24

    ld a, [num_flowers]
    cp 0
    jr nz, .fin

    ld a, SCENE_GAMEOVER
    ld [SCENE_STATE], a
    
    
    .fin
    .no_reset
ret


man_game_decrementar_counter_create_enmies:
    ld a,  [num_flowers]
    cp MAX_FLOWERS
    jr z, .no_decrease

    ld a, [timer_create_flower]
    dec a
    ld [timer_create_flower], a


.no_decrease
ret
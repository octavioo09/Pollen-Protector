include "../include/hardware.inc"
include "../include/constantes.inc"
include "../include/entity_defines.asm"

SECTION "AI HELPER", WRAM0
    arrived_x:  DS 1
    arrived_y:  DS 1

SECTION "AI COMPORTEMENT", ROM0

; //////////// FUNCIÓN MOVE TO//////////////
; Función: Mueve una entidad hacia una posición objetivo
; --------------------------------------
; Inputs: HL (Dirección de la entidad)
sys_ai_move_to::
    ;Inicializar las variables de ayuda para comrpobar si ha llegado a su destino
    ld a, 0
    ld [arrived_x], a
    ld [arrived_y], a
    
    push hl
    ld de, ENTITY_POS_OBJ_X
    call man_entity_obtein_by_index
    ld a, [hl]              ;A = Posición objetivo X
    pop hl

    push hl
    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    ld b, [hl]              ;B = Posición actual X
    pop hl

    push hl
    ld de, ENTITY_VX
    call man_entity_obtein_by_index     ;HL= Dirección de la velocidad X

    sub b                               ;A = Posición objetivo X - Posición actual X
    jr nc, .objx_greater_or_equal       ;No hay carry si la posición objetivo es mayor

    .objx_lesser
    ld a, -1
    ld [hl], a
    jr .endif_x
    .objx_greater_or_equal
    jr z, .arrived_x
    ld a, 1
    ld [hl], a
    jr .endif_x
    .arrived_x
    ld a, 1
    ld [arrived_x], a 
    ld a, 0
    ld [hl], a
    .endif_x
    pop hl

    push hl
    ld de, ENTITY_POS_OBJ_Y
    call man_entity_obtein_by_index
    ld a, [hl]              ;A = Posición objetivo Y
    pop hl

    push hl
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index
    ld b, [hl]              ;B = Posición actual Y
    pop hl

    push hl
    ld de, ENTITY_VY
    call man_entity_obtein_by_index     ;HL= Dirección de la velocidad Y

    sub b                               ;A = Posición objetivo Y - Posición actual Y
    jr nc, .objx_greater_or_equal_y       ;No hay carry si la posición objetivo es mayor

    .objx_lesser_y                        ;Si hay carry (es menor la objetivo)
    ld a, -1
    ld [hl], a
    jr .endif_y
    .objx_greater_or_equal_y            ;Si no hay carry (es mayor la objetivo o cero)
    jr z, .arrived_y
    ld a, 1
    ld [hl], a
    jr .endif_y
    .arrived_y                          ;Si ha llegado a la objetivo
    ld a, 1
    ld [arrived_y], a
    ld a, 0
    ld [hl], a
    .endif_y                            
    pop hl

    ;Comprobar si ha llegado tanto en X como en Y
    ld a, [arrived_x]
    cp 1
    jr nz, .not_arrived
    ld a, [arrived_y]
    cp 1 
    jr nz, .not_arrived


    ;En el timer de explosión esta el indice de la flor que tiene asignada

    ;Pasar en la b el indice de la flor
    ld de, ENEMY_FLOWER_ASSIGNED
    call man_entity_obtein_by_index
    ld a, [hl]
    ld b, a
    call man_entity_start_timer_flower_id

    .not_arrived

ret

sys_ai_move_to_kamikace::
    ;Inicializar las variables de ayuda para comrpobar si ha llegado a su destino
    ld a, 0
    ld [arrived_x], a
    ld [arrived_y], a
    
    push hl
    ld de, ENTITY_POS_OBJ_X
    call man_entity_obtein_by_index
    ld a, [hl]              ;A = Posición objetivo X
    pop hl

    push hl
    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    ld b, [hl]              ;B = Posición actual X
    pop hl

    push hl
    ld de, ENTITY_VX
    call man_entity_obtein_by_index     ;HL= Dirección de la velocidad X

    sub b                               ;A = Posición objetivo X - Posición actual X
    jr nc, .objx_greater_or_equal       ;No hay carry si la posición objetivo es mayor

    .objx_lesser
    ld a, -1
    ld [hl], a
    jr .endif_x
    .objx_greater_or_equal
    jr z, .arrived_x
    ld a, 1
    ld [hl], a
    jr .endif_x
    .arrived_x
    ld a, 1
    ld [arrived_x], a 
    ld a, 0
    ld [hl], a
    .endif_x
    pop hl

    push hl
    ld de, ENTITY_POS_OBJ_Y
    call man_entity_obtein_by_index
    ld a, [hl]              ;A = Posición objetivo Y
    pop hl

    push hl
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index
    ld b, [hl]              ;B = Posición actual Y
    pop hl

    push hl
    ld de, ENTITY_VY
    call man_entity_obtein_by_index     ;HL= Dirección de la velocidad Y

    sub b                               ;A = Posición objetivo Y - Posición actual Y
    jr nc, .objx_greater_or_equal_y       ;No hay carry si la posición objetivo es mayor

    .objx_lesser_y                        ;Si hay carry (es menor la objetivo)
    ld a, -1
    ld [hl], a
    jr .endif_y
    .objx_greater_or_equal_y            ;Si no hay carry (es mayor la objetivo o cero)
    jr z, .arrived_y
    ld a, 1
    ld [hl], a
    jr .endif_y
    .arrived_y                          ;Si ha llegado a la objetivo
    ld a, 1
    ld [arrived_y], a
    ld a, 0
    ld [hl], a
    .endif_y                            
    pop hl

    ;Comprobar si ha llegado tanto en X como en Y
    ld a, [arrived_x]
    cp 1
    jr nz, .not_arrived
    ld a, [arrived_y]
    cp 1 
    jr nz, .not_arrived


    ld a, [player_dead]
    cp 1
    jr nz, .fin

    call man_entity_destroy
    ld a, [num_kamikaze_created]
    dec a
    ld [num_kamikaze_created], a


    ;En el timer de explosión esta el indice de la flor que tiene asignada
    .fin
    .not_arrived


ret

;///////// FUNCION COMPORTAMIENTO LINEA RECTA ////////////
;Función: Mueve una entidad en linea recta
;--------------------------------------
;Inputs: HL (Dirección de la entidad)
straightMovement:
    
    push hl
    call man_entity_get_two_first_flower_no_dead

    ld hl, array_assign_enemy2
    ld a, [hl]
    ld d, a
    call man_entity_find_flower_id

    ld de, ENTITY_POSX
    call man_entity_obtein_by_index

    ld a, [hl]
    ld c, a
    pop hl

    push hl
    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    ld a, [hl]         ;A = PosX
    pop hl

    cp c
    jr nz, .seguir

    call man_create_enemy_shot

    .seguir
    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    ld a, [hl]              ;A = PosX
    
    inc hl                  ;HL: VX

    cp LIMITE_PLAYER_L
    jr nz, .checkRight
    ld a, 1
    ld [hl], a
    jr .end

    .checkRight
    cp LIMITE_PLAYER_R
    jr nz, .end
    ld a , -1
    ld [hl], a
    
.end
ret

;///////// FUNCION COMPORTAMIENTO LINEA VERTICAL ////////////
;Función: Mueve una entidad en linea vertical
;--------------------------------------
;Inputs: HL (Dirección de la entidad)
upDownMovement:

    push hl
        call man_entity_get_two_first_flower_no_dead

        

        ld hl, array_assign_enemy2
        ld a, c                         ;C = Número de flores no muertas encontradas
        cp 1
        jr z, .misma_flor
        inc hl                          ;Segunda flor que no esta muerta
        .misma_flor
        ld a, [hl]
        ld d, a
        call man_entity_find_flower_id

        ld de, ENTITY_POSY
        call man_entity_obtein_by_index

        ld a, [hl]
        ld c, a
    pop hl

    push hl
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index
    ld a, [hl]         ;A = PosY
    pop hl

    cp c
    jr nz, .seguir

    call man_create_enemy_shot

    .seguir
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index
    ld a, [hl]              ;A = PosY

    inc hl                  ;HL: VY
    
    cp LIMITE_PLAYER_D
    jr nz, .checkUp

    ld a, -1
    ld [hl], a
    jr .end

    .checkUp
    cp LIMITE_PLAYER_U
    jr nz, .end
    ld a , 1
    ld [hl], a

.end
ret


sys_ai_autodestroy_shot_global:                     
    ld de, ENTITY_POSY
    push hl
    call man_entity_obtein_by_index
    ld a, [hl]

    inc hl
    inc hl
    ld d, [hl]

    pop hl
    cp LIMITE_D
    jr nc, .destroy                     

    cp LIMITE_U
    jr c, .destroy

    ld a, d

    cp LIMITE_L
    jr c, .destroy 

    cp LIMITE_R
    jr c, .end                      

    .destroy
    ld a, [hl]
    cp SHIP_TYPE_SHOT_ENEMY
    jr z, .enemigo

    call man_game_destroy_shot
    jr .end
    
    .enemigo
    call man_game_destroy_shot_enemy

.end
ret
    

;//////// FUNCION LLAMADA COMPORTAMIENTO IA ////////////
;Función: LLama a la función de comportamiento de la IA
;--------------------------------------
;Inputs: HL (Dirección de la entidad)
sys_ai_update_one_entity:
    push hl
    call man_entity_returnFunctionAI      ;DE: Dirección de la función del comportamiento de la IA
    
    ld bc, .volver
    push bc
    
    push de                               ;Guardar la dirección de la función (La devuelve la función)
    ret
    .volver
    pop hl
ret


sys_ai_update:
    ld de, sys_ai_update_one_entity
    ld c, SHIP_STATE_IA
    call man_entity_for_all_matching
ret

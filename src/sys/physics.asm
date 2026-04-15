include "../include/constantes.inc"

SECTION "Physics", ROM0

;///////// FUNCION ACTUALIZAR POSICION DEL JUGADOR POR TECLADO ////////////
;Función: Actualiza la posición del jugador en función de las teclas pulsadas
;--------------------------------------
;Inputs: [flancoAscendetes] (Teclas pulsadas)

sys_physics_check_keyboard:
    call read_buttons

    ld a, [is_pause]
    cp 0
    jp nz, .fin

    ld a, [estadoBotones]

    ld d, 0                         ;Velocidad Y que no cambia pero hay que pasarla a la función de cambio de velocidad
    ld e, 0

    call man_entity_return_pos     ;B (Posición Y), C(Posición X)

    .checkStart
    ld a, [flancoAscendente]
    bit 3, a
    jr z, .checkB
    ld a, SCENE_PAUSED
    ld [SCENE_STATE], a
    ld a, 1
    ld [paused], a
    jr .checkB

    .checkB
    ld a, [flancoAscendente]
    bit 1, a
    jr z, .checkLeft
    call man_rotate_player
    jr .checkLeft

    .checkLeft
    ld a, [estadoBotones]
    bit 4, a            ;Si se pulsa izquierda
    jr z, .checkRight

    ld a, LIMITE_PLAYER_R
    cp c
    jr c, .set_v0_left                ;Carry es que pasa el limite
    ld e, 2
    jr .change_vec_left
    .set_v0_left
    ld e, 0

    .change_vec_left
    call man_entity_change_velocity
    jr .checkA

    .checkRight
    bit 5, a            ;Si se pulsa derecha
    jr z, .checkUp

    ld a, LIMITE_PLAYER_L
    cp c
    jr nc, .set_v0_right                ;Carry es que pasa el limite
    ld e, -2
    jr .change_vec_right

    .set_v0_right
    ld e, 0
    .change_vec_right
    call man_entity_change_velocity
    jr .checkA

    .checkUp
    bit 6, a            ;Si se pulsa derecha
    jr z, .checkDown

    ld a, LIMITE_PLAYER_U
    cp b
    jr nc, .set_v0_up                ;Carry es que pasa el limite
    ld d, -2
    jr .change_vec_up

    .set_v0_up
    ld d, 0
    .change_vec_up

    call man_entity_change_velocity
    jr .checkA

    .checkDown
    bit 7, a            ;Si se pulsa derecha
    jr z, .checkA
    
    ld a, LIMITE_PLAYER_D
    cp b
    jr c, .set_v0_down                ;Carry es que pasa el limite
    ld d, 2
    jr .change_vec_down

    .set_v0_down
    ld d, 0
    .change_vec_down

    call man_entity_change_velocity
    jr .checkA

    .checkA
    ld a, [flancoAscendente]
    bit 0, a
    jr z, .anyKey
    push hl
    call man_create_shot_player
    pop hl
    jr .fin

    .anyKey
    call man_entity_change_velocity


.fin
ret



;//////// FUNCION ACTUALIZAR POSICION DE LA ENTIDAD ////////////
;Función: Actualiza la posición de la entidad en la dirección BC
;--------------------------------------
;Inputs: HL (Dirección de la entidad)
sys_physics_update_one_entity::
   ;HL: Dirección de la entidad

   ;Comprobar si tiene input
   inc hl
   ld a , [hl]                          ;A: Estado de la nave
   dec hl
   and SHIP_STATE_INPUT                  ;Comprobar si tiene el estado de input
   push hl
   call nz, sys_physics_check_keyboard   ;Si tiene input, actualizar las velocidades
   pop hl

    
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index
    ld c, 2
    .twoTimes
        
        ld d, h
        ld e, l

        ld a, [hl]
        inc hl      ;HL: VY
        ld b, [hl]
        add b       ;A: PosY + PosX

        ld [de], a
        inc hl
        
        dec c
    jr nz, .twoTimes

ret

;//////// FUNCION ACTUALIZAR FISICA ////////////
;Función: Actualiza la posición de todas las entidades
;--------------------------------------
;Inputs: Ninguno
;Modifica: DE
sys_physics_update:
    ld de, sys_physics_update_one_entity
    call man_entity_for_all
ret


    
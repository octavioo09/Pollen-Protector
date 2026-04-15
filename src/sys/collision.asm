include "../include/constantes.inc"

SECTION "Collision RAM", WRAM0
    Intervals:
    I1: DS 2    ;Interval 1: [X, W]
    I2: DS 2    ;Interval 2: [X, W]

    Colision: DS 1  

SECTION "Collision System", ROM0

; //////////FUNCION PARA DETECTAR COLSIÓN ENTRE DOS ENTIDADES EN 1D///////////
; Función: Detecta si dos intervalos se solapan en una dimensión
; --------------------------------------
; Inputs: HL (Dirección de los intervalos)


; --------------x1----w1
; ----x2----w2
; x2 > x1 + w1 --> C --> NO hay colisión
sys_collision_check_interval_overlap:
    ;Case 1
    ld a, [hl]      ;x1
    inc hl
    ld b, [hl]      ;w1
    add b           ;x1 + w1
    dec a           ; A = (x1 + w1) - 1

    inc hl          
    ld b , [hl]     ;x2
    sub b           ;((x1 + w1) - 1) - x2
    ret c           ;If ((x1 + w1) - 1) - x2 < 0, there is no overlap
    ; --------------------

    ;Case 2
    inc hl
    ld a, [hl]      ;w2
    
    add b           ;w2 + x2

    dec hl
    dec hl
    dec hl
    ld b, [hl]      ;x1

    sub b           ;((w2 + x2) - 1) - x1
    ret c
    ; --------------------
ret

sys_collisions_check_if_two_entities_overlap:
    
        ;Copy Entity 1 to I1
        ld a, [collision_left_byte1]
        ld h, a
        ld a, [collision_left_byte2]
        ld l, a

        ; Diección de la entidad LEFT
        ld de, ENTITY_POSX
        call man_entity_obtein_by_index
        ld a, [hl]          ;X1    
    
        ld [I1], a          ;I1.x

        ld a, ENTITY_WIDTH
        ld [I1 + 1], a      ;I1.w
    
        ;Copy Entity 2 to I2
        ld a, [collision_right_byte1]
        ld h, a
        ld a, [collision_right_byte2]
        ld l, a

        ;HL: Diracción de la entidad RIGHT
        ld de, ENTITY_POSX
        call man_entity_obtein_by_index
        ld a, [hl]          ;X2
    
    
        ld [I2], a          ;I2.x

        ld a, ENTITY_HEIGHT
        ld [I2 + 1], a      ;I2.w
    
        ;Check if they overlap
        ld hl, Intervals
        call sys_collision_check_interval_overlap

        ret c       ;C = NO hay colisión en el eje X

        ;Copy Entity 1 to I1
        ld a, [collision_left_byte1]
        ld h, a
        ld a, [collision_left_byte2]
        ld l, a


        ld de, ENTITY_POSY
        call man_entity_obtein_by_index
        ld a, [hl]          ;X1
    
    
        ld [I1], a          ;I1.x

        ld a, ENTITY_HEIGHT
        ld [I1 + 1], a      ;I1.h
    
        ;Copy Entity 2 to I2
        ld a, [collision_right_byte1]
        ld h, a
        ld a, [collision_right_byte2]
        ld l, a
        

        ld de, ENTITY_POSY
        call man_entity_obtein_by_index
        ld a, [hl]          ;X2

    
        ld [I2], a          ;I2.x

        ld a, ENTITY_HEIGHT
        ld [I2 + 1], a      ;I2.w
    
        ;Check if they overlap
        ld hl, Intervals
        call sys_collision_check_interval_overlap

        ret c       ;C = NO hay colisión en el eje Y

        call sys_destroy_entity_if_collision


ret 


sys_collision_check:
    ld a, [collision_left_byte1]
    ld h, a
    ld a, [collision_left_byte2]
    ld l, a

    ;HL: Dirección de la entidad LEFT
    ld a, [hl]
    ld b, a         ;B = Tipo de la entidad LEFT


    ld de, ENTITY_COLLIDES_AGAINST
    call man_entity_obtein_by_index
    ld a, [hl]
    ld d, a         ;D = Contra que colisiona la entidad LEFT


    ld a, [collision_right_byte1]
    ld h, a
    ld a, [collision_right_byte2]
    ld l, a 

    ;HL: Dirección de la entidad RIGHT
    ld a, [hl]
    ld c, a         ;C = Tipo de la entidad RIGHT

    
    push de
    ld de, ENTITY_COLLIDES_AGAINST
    call man_entity_obtein_by_index
    pop de          ;D = Contra que colisiona la entidad LEFT
    ld a, [hl]
    ld e, a         ;E = Contra que colisiona la entidad RIGHT

    ;B (Tipo entidad 1), C(Tipo entidad 2), 
    ;D (Colision entidad 1), E (Colision entidad 2)

    ld a, d
    and c
    jr nz, .Collision

    ld a, e
    and b
    ret z

    .Collision
    call sys_collisions_check_if_two_entities_overlap

    ret c

ret

;LAS COSAS QUE SE REPITEN METER DENTRO DE UNA FUCIÓN, COMO POR EJEMPLO PONERA A EXPLOSIÓN
;EL DISPARO DEL ENEMIGO TIENE UN DESTROY ESPECIAL QUE RESTA UNO AL NUMEOR DE DISPAROS ENEMIGOS
sys_destroy_entity_if_collision:
    ld a, [collision_right_byte1]
    ld h, a
    ld a, [collision_right_byte2]
    ld l, a
    ld a, [hl]
    cp SHIP_TYPE_SHOT
    jr nz, .comprobarEnemy
    ;Reiniciar el couldown si colisiona una bala
    ld a, 0
    ld [couldown_shot], a
    call man_game_destroy_shot
    jp .seguir
    
    .comprobarEnemy
    ld a, [hl]
    cp SHIP_TYPE_ENEMY1
    jr z, .desasignarFlor
    cp SHIP_TYPE_ENEMY2
    jr z, .decremento
    cp SHIP_TYPE_ENEMY3
    jr z, .decrementaKami

    jr .noShot

    .desasignarFlor
    push hl
        ld de, ENTITY_TIMER_EXPLOSION
        call man_entity_obtein_by_index
        ld a, [hl]
        call man_game_unassign_flower
    pop hl

    jr .explotar

    .decremento
    ld a, [num_air_enemies]
    dec a
    ld [num_air_enemies], a

    jr .explotar

    .decrementaKami
    ld a, [num_kamikaze_created]
    dec a
    ld [num_kamikaze_created], a

    .explotar
    ;Decrementar contador para crear una flor
    call man_game_decrementar_counter_create_enmies

    call add_dead_to_score
    ld a, SHIP_TYPE_EXPLOSION
    ld [hl], a
    push hl
    ld de, ENTITY_SPRITE1
    call man_entity_obtein_by_index
    ld a, 3
    ld [hl], a
    pop hl
    ld de, ENTITY_TIMER_EXPLOSION
    call man_entity_obtein_by_index
    ld a, 15
    ld [hl], a
    jr .seguir


    .noShot
    ld a, [hl]
    cp SHIP_TYPE_PLAYER
    jr nz, .matarSinVida

    push bc
        call sys_collision_culdaun
    pop bc

    ;Inicializar el contador de la explosion
    call man_game_init_explosion_player

    ;Si estas en animación de explosión que no te reste vida
    ld a, [player_dead]
    cp 1
    jr z, .matarSinVida
    
    ld a, [player_lifes]
    dec a
    ld [player_lifes], a

       
   ; NR21 - Duración y onda cuadrada
    ld a, %10000000      ; Duración breve, onda cuadrada al 50%
    ld [$FF16], a        ; Registrar en NR21 para canal 2

    ; NR22 - Envolvente de volumen
    ld a, %11100001      ; Volumen inicial alto (14), rápida envolvente decreciente
    ld [$FF17], a        ; Registrar en NR22 para canal 2

    ; NR23 - Parte baja de la frecuencia
    ld a, $FF            ; Parte baja de la frecuencia aún más alta
    ld [$FF18], a        ; Registrar en NR23

    ; NR24 - Parte alta de la frecuencia y reinicio del canal
    ld a, %10000000      ; Activar el sonido con frecuencia alta y reiniciar
    ld [$FF19], a        ; Registrar en NR24 


    cp 0
    jr nz, .seguir

    .matarSinVida
    call man_entity_destroy
    

    .seguir
    ld a, [collision_left_byte1]
    ld h, a
    ld a, [collision_left_byte2]
    ld l, a
    ld a, [hl]
    cp SHIP_TYPE_SHOT
    jr nz, .comprobarEnemy2
    ;Reiniciar el couldown si colisiona una bala
    ld a, 0
    ld [couldown_shot], a
    call man_game_destroy_shot
    jr .fin
    
    .comprobarEnemy2
    ld a, [hl]
    cp SHIP_TYPE_ENEMY1
    jr z, .desasignarFlor2
    cp SHIP_TYPE_ENEMY2
    jr z, .decremento2
        cp SHIP_TYPE_ENEMY3
    jr z, .decrementaKami2

    jr .noShot2

    .desasignarFlor2
    push hl
        ld de, ENTITY_TIMER_EXPLOSION
        call man_entity_obtein_by_index
        ld a, [hl]
        call man_game_unassign_flower
    pop hl

    jr .explotar2

    .decremento2
    ld a, [num_air_enemies]
    dec a
    ld [num_air_enemies], a

    jr .explotar2

    .decrementaKami2
    ld a, [num_kamikaze_created]
    dec a
    ld [num_kamikaze_created], a

    .explotar2
    ;Decrementar contador para crear una flor
    call man_game_decrementar_counter_create_enmies
    
    call add_dead_to_score
    ld a, SHIP_TYPE_EXPLOSION
    ld [hl], a
    push hl
    ld de, ENTITY_SPRITE1
    call man_entity_obtein_by_index
    ld a, 3
    ld [hl], a
    pop hl
    ld de, ENTITY_TIMER_EXPLOSION
    call man_entity_obtein_by_index
    ld a, 15
    ld [hl], a
    jr .fin


    .noShot2
    ld a, [hl]
    cp SHIP_TYPE_PLAYER
    jr nz, .matarSinVida2

    ;Inicializar el contador de la explosion
    call man_game_init_explosion_player
    push bc
        call sys_collision_culdaun
    pop bc

    ld a, [player_lifes]
    dec a
    ld [player_lifes], a

       
   ; NR21 - Duración y onda cuadrada
    ld a, %10000000      ; Duración breve, onda cuadrada al 50%
    ld [$FF16], a        ; Registrar en NR21 para canal 2

    ; NR22 - Envolvente de volumen
    ld a, %11100001      ; Volumen inicial alto (14), rápida envolvente decreciente
    ld [$FF17], a        ; Registrar en NR22 para canal 2

    ; NR23 - Parte baja de la frecuencia
    ld a, $FF            ; Parte baja de la frecuencia aún más alta
    ld [$FF18], a        ; Registrar en NR23

    ; NR24 - Parte alta de la frecuencia y reinicio del canal
    ld a, %10000000      ; Activar el sonido con frecuencia alta y reiniciar
    ld [$FF19], a        ; Registrar en NR24 

    cp 0
    jr nz, .fin

    .matarSinVida2
    call man_entity_destroy
    
    .fin
ret

sys_collision_culdaun:
    
    ld c, 100               ;tiempo de culdaun
    ld b, 0

    call wait_vblank_start

    .bucle
    ld a, b
    cp 0
    jr nz, .vidaRestada
        ld a, [player_lifes]
        dec a
        add $7A
        ld [$9811], a

        ld b, 1
    .vidaRestada
    dec c
    jr nz, .bucle
ret

;Igual con simplemente pasar la dirección hl de cada entidad en el foreach y en vez de pasar de, seguir sumando para coger 
;la que te pasan en hl y la siguiente, bueno no porque solo comprobaria con la siguiente no con todas

sys_collision_update:
    ld de, sys_collision_check
    call man_entity_for_all_pairs_matching
ret
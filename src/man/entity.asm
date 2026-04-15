include "../include/constantes.inc"
include "../include/entity_defines.asm"




;En ROM a información mínima de la entidad (Sprites que la forman)
SECTION "Player Data", ROM0
;Esto es necesario si cambia dinámicamente durante el juego el id, por ejemplo si la nave tiene diferentes apariencias según el nivel
;En el nivel 1 usa los sprites 0 y 1 pero en el nivel 2 usa los sprites 2 y 3. Entonces se haría así:
; playerDataLevel1:
;    DB 0, 1  
;playerDataLevel2:
;   DB 2, 3  
;Si siempre son los mismos no haría falta guardarlos en ROM para luego copiarlos a RAM, sino que podríamos utiizar directamente las 
;constantes
playerData:
    DB PLAYER_SPRITE_ID1, PLAYER_SPRITE_ID2

enemy1Data:
    DB ENEMY_TIPE0_SPRITE_ID1, ENEMY_TIPE0_SPRITE_ID2
    

SECTION "Entity Array", WRAM0

    
    entityArray:: DS ENTITY_SIZE * MAX_ENTITIES        ;Primer slot para el jugador, siguientes los enemigos


SECTION "Variables", WRAM0
    ;Cada entidad libre es la 0, la 11, la 22
    RSRESET
    next_entity_free_byte1: DS 1        ;Primer byte del incremento a sumar a la dirección incial para la siguiente nave libre
    next_entity_free_byte2: DS 1        ;Segundo byte del incremento a sumar a la dirección incial para la siguiente nave libre
    free_check:             DS 1        ;Variable para comprobar si hay espacio para una entidad
    actual_entity:          DS 1        ;Dirección de la entidad actual
    collision_right_byte1:  DS 1        
    collision_right_byte2:  DS 1        
    collision_left_byte1:   DS 1        
    collision_left_byte2:   DS 1   
    help_1byte:             DS 1            


SECTION "Functions", ROM0
man_entity_init::
    ld a, 0
    ld [next_entity_free_byte1], a
    ld [next_entity_free_byte2], a
    ld [num_ships], a
    ld [num_shots], a
    ld [num_entities], a
    ld [free_check], a
    ld [actual_entity], a
    ld [collision_left_byte1], a
    ld [collision_left_byte2], a
    ld [collision_right_byte1], a
    ld [collision_right_byte2], a

    call man_initEntityArray
ret

;///////// FUNCION INICIALIZACION ARRAY NAVES A 0 ////////////
;Función: Inicializa los bytes del array de naves a 0
;--------------------------------------
;Modifica: HL, BC, D, A

man_initEntityArray::
    ld hl, entityArray                    ;Dirección de inicio del array de naves
    ld bc, ENTITY_SIZE * MAX_ENTITIES     ;Número de bytes del array de naves a inicializar
    ld d, 0  

    ld a, 0
    ld [help_1byte], a                           

    .initLoop
        ld a, d 
        ld [hl], a
        inc hl
        dec bc
        ld a, b
        or c
    jr nz, .initLoop

ret

; -----------------------------CREAR ENTIDADES Y BUSCAR LIBRES----------------------------------------

; ///////// FUNCION ENCONTRAR PRIMER SLOT LIBRE ////////////
;Función: Encuentra el primer slot libre en el array de naves (puede estar por enmedio de validas)
;--------------------------------------
;Output: HL: Dirección del primer slot
;Modifica: HL, DE
;Warnings: Si no hay slots libres, el bucle seguirá

man_entity_find_first_free_slot:
    ld a, [num_entities]
    cp MAX_ENTITIES
    jr z, .end

    ld hl, entityArray
    ld de, ENTITY_SIZE
    ld b, SHIP_TYPE_INVALID        ;B: Estado pasamos a la función de comprobar

    .loop
        call man_entity_is_of_type_b    
        jr z, .encontrado
        add hl, de
    jr .loop

    .end
        ld hl, $FFFF
        
    .encontrado
        ld a, h
        ld [next_entity_free_byte1], a
        ld a, l
        ld [next_entity_free_byte2], a

        ret
    


; ////////// FUNCION INICIALIZACION NAVE POR DEFECTO ////////////
;Función: Inicializa los valores de la nave con los valores que se pasan en DE
;--------------------------------------
;Inputs: DE (Dirección de los valores de la nave por defecto)
;Modifica: HL, DE, BC, A
man_setEntityValues:
    ld a, [next_entity_free_byte1]
    ld h, a
    ld a , [next_entity_free_byte2]
    ld l, a                             ;HL: Dirección de la nave a modificar

    ld b, ENTITY_SIZE
    .darValores
        ld a, [de]
        ld [hl], a
        inc de
        inc hl
        dec b
    jr nz, .darValores

ret


;////////// FUNCION OBTENER ATRIBUTO POR INDICE ////////////
;Función: Obtiene el atributo de la entidad por el índice del atributo que se le pasa
;--------------------------------------
;Input: DE(Indice del atributo)
;Output: HL(Dirección del atributo)
;WARNING: Desactiva todos los flags
man_entity_obtein_by_index:
    add hl, de
ret

; ///////// FUNCION INICIALIZACION JUGADOR ////////////
;Función: Crea los valores de las entidades tanto enemigas como las del jugador con valores predeterminados
;--------------------------------------
;Input: 
;Modifica: DE, B, HL, A

;man_createEnemyDefault::
;    ld de, enemy_default   
;    push de
;    call man_entity_find_first_free_slot
;    pop de 
;    call man_setEntityValues          ;Modifica los valores del array de naves con los valores de la nave por defecto
;
;    ld a, [num_ships]
;    inc a
;    ld [num_ships], a
;
;    ld a, [num_entities]
;    inc a
;    ld [num_entities], a
;ret

;man_createEnemy1Default::
;    ld de, enemy1_default   
;    push de
;    call man_entity_find_first_free_slot
;    pop de 
;    call man_setEntityValues          ;Modifica los valores del array de naves con los valores de la nave por defecto
;
;    ld a, [num_ships]
;    inc a
;    ld [num_ships], a
;
;    ld a, [num_entities]
;    inc a
;    ld [num_entities], a
;ret
;man_createShotDefault::
;
;    ld de, player_default
;    push de
;    call man_entity_find_first_free_slot
;    pop de
;    call man_setEntityValues
;
;    ld a, [num_shots]
;    inc a
;    ld [num_ships], a
;
;    ld a, [num_entities]
;    inc a
;    ld [num_entities], a
;
;ret
; ---------------------------------------------------------------------------------------------------


; -----------------------------DESTRUIR ENTIDADES----------------------------------------

; ///////// FUNCION DESTRUIR NAVE ////////////
;Función: Pone el tipo de la nave que se le pasa a invalido
;--------------------------------------
;Input: HL(Dirección de la nave a destruir)
man_entity_destroy::

    ld a, [hl]
    cp SHIP_TYPE_PLAYER
    jr nz, .NoPersonaje
    ld a, SCENE_GAMEOVER
    ld [SCENE_STATE], a

    .NoPersonaje
    ld [hl], SHIP_TYPE_INVALID

    ld a, [num_entities]
    dec a
    ld [num_entities], a


ret

; ///////// FUNCIÓN MARCAR COMO DESTRUIDA ////////////
;Función: Marca la entidad actual como destruida
;--------------------------------------
;Input: HL(Dirección de la nave a marcar)
;Precondición: HL debe de ser una dirección válida


man_entity_set4destruction:
    ld a, [hl]              ;A: Estado de la nave actual
    ;or SHIP_STATE_DEAD      ;Añadir el bit de componente que indica que esta muerta
    ld a, SHIP_TYPE_DEAD

    ld [hl], a              ;Actualizar el estado de la nave
ret

; ///////// FUNCION ACTUALIZAR GESTOR DE ENTIDADES ////////////
;Función: Actualiza en Entity Manager destruyendo todas las naves que estan marcadas como muertas
;-------------------------------------
;Modifica: HL, DE, A, B

; indice de la entidad  = 3

man_entity_update:
    ld hl, entityArray
    ld a, [num_entities] 
    ld b, a                 ;B = 3

    .recorrer
        ld a, [hl]
        cp SHIP_TYPE_INVALID
        jr z, .esInvalido

        cp SHIP_TYPE_DEAD
        jr nz, .comprobarExplosion
        call man_entity_destroy
        jr .decrementar

        .comprobarExplosion
        cp SHIP_TYPE_EXPLOSION
        jr nz, .decrementar

        push hl
        ld de, ENTITY_TIMER_EXPLOSION
        call man_entity_obtein_by_index

        ld a, [hl]
        dec a
        ld [hl], a
        pop hl

        jr nz, .decrementar
        call man_entity_destroy
        jr .decrementar


        .esInvalido
        ld de, ENTITY_SIZE
        add hl, de
        jr .recorrer

        .decrementar
        ld de, ENTITY_SIZE
        add hl, de
        dec b
        
        ;ARREGLAR ESTO, PARA QUE LAS INVALIDAS NO DECREMENTEN COMO ENTIDAD
    jr nz, .recorrer
ret
; ---------------------------------------------------------------------------------------------------


; ///////// FUNCION PROGRAMACION INVERTIDA  ////////////
; Función: Llama a una función para cada entidad que cumpla una condición
;--------------------------------------
; Inputs: DE: Dirección de la función a llamar
; --------------------------------------
; Warnings: Todas las entidades validas deben de estar seguidas en el array
    ;DE: Dirección de la función a llamar



man_entity_for_all:
    ld hl, entityArray
    ld a, [num_entities]
    ld b, a                             ;B: Número de naves activas

    .bucle
        push bc

        ld a, [hl]                      ;A: Estado de la nave
        cp SHIP_TYPE_INVALID
        jr z, .noCallFunc
        cp SHIP_TYPE_EXPLOSION
        jr z, .noCallFunc

        
        push hl                         ;Guardamos la dirección por si se modifica en la función
        push de                         ;Guardamos la dirección de la función a llamar por si se modifica en la función que llamamos
        ld bc, .turnBack
        push bc                         ;Dirección de retorno en la pila

        push de
        ret                             ;Llamada a la función
        .turnBack

        pop de
        pop hl

        jr .notDoPopBC

        .noCallFunc
        pop bc
        call incPos
        jr .bucle

        
        .notDoPopBC
        call incPos
        pop bc
        dec b

    jr nz, .bucle
ret



; ///////// FUNCION PROGRAMACION INVERTIDA  ////////////
; Función: Llama a una función para cada entidad que cumpla una condición
;--------------------------------------
; Inputs: DE: Dirección de la función a llamar, C: Tipo de entidad
; --------------------------------------
; Warnings: Todas las entidades validas deben de estar seguidas en el array
    ;DE: Dirección de la función a llamar

man_entity_for_all_matching:
    ld hl, entityArray
    ld a, [num_entities]
    ld b, a                             ;B: Número de naves activas

    .bucle
        push bc
        ld a, [hl]                      ;A: Tipo de la nave
        cp SHIP_TYPE_INVALID
        jr z, .isInvalid
        cp SHIP_TYPE_EXPLOSION
        jr z, .noTypeRequired

        inc hl
        ld a, [hl]                      ;A: Componente de la nave
        dec hl
        and c
        cp c
        jr nz, .noTypeRequired


        push hl
        push de
        ld bc, .volver
        push bc

        push de
        ret

        .volver
        pop de
        pop hl 
        jr .noTypeRequired
        

        .isInvalid
        pop bc
        call incPos
        jr .bucle

        .noTypeRequired
        call incPos
        pop bc
        dec b
        
    jr nz, .bucle
ret

man_entity_for_all_pairs_matching:

    ld hl, entityArray
    ld a, [num_entities]
    ld b, a                             ;B: Número de naves activas
    cp 1
    jr z, .fin

    .bucle1
        
        ld a, [hl]                      ;A: Tipo de la nave
        cp SHIP_TYPE_INVALID
        jr z, .leftIsInvalid
        cp SHIP_TYPE_EXPLOSION
        jr z, .noTypeRequired

        inc hl
        ld a, [hl]                      ;A: Componente de la nave
        dec hl                          ;HL siempre apunta al primero de la entidad

        and SHIP_STATE_COLLIDER         ;Extraes el bit de colision
        jr z, .noTypeRequired


        ; Entity LEFT es valida y collider
        ld a, HIGH(hl)
        ld [collision_left_byte1],a
        ld a, LOW(hl)
        ld [collision_left_byte2],a

        push bc
        push hl
        call man_entity_for_all_pairs_matching2
        pop hl ;HL: Dirección de la entidad LEFT
        pop bc
        jr .noTypeRequired


        .leftIsInvalid
        call incPos
        jr .bucle1

        .noTypeRequired
        call incPos
        dec b
        ld a, b 
        cp 1
        ret z
        
    jr nz, .bucle1
.fin
ret



;             v
;[E][E][E][E][I][E]   Posible problema

; v  i  i  i     i
;[E][E][E][E][I][E]   Posible problema

man_entity_for_all_pairs_matching2:
    dec b
    call incPos

    .bucle2
    push bc
        ld a, [hl]                      ;A: Tipo de la nave
        cp SHIP_TYPE_INVALID
        jr z, .rightIsInvalid
        cp SHIP_TYPE_EXPLOSION
        jr z, .noTypeRequiredRight

        inc hl
        ld a, [hl]                      ;A: Componente de la nave
        dec hl

        and SHIP_STATE_COLLIDER         ;Extraes el bit de colision
        jr z, .noTypeRequiredRight

        ; Entity RIGHT es valida y collider
        ld a, HIGH(hl)
        ld [collision_right_byte1], a
        ld a, LOW(hl)
        ld [collision_right_byte2], a

        push hl
        push de 
        ld bc, .volver
        push bc
        push de
        ret

        .volver
        pop de
        pop hl
        jr .noTypeRequiredRight

        .rightIsInvalid
        pop bc
        call incPos
        jr .bucle2

        .noTypeRequiredRight
        call incPos
        pop bc
        dec b

    jr nz, .bucle2
ret


; Input: HL (Dirección de la entidad actual)
; Output: HL (Dirección de la siguiente entidad)
incPos:
    push bc
        ld bc, ENTITY_SIZE
        add hl, bc
    pop bc
ret



; ///////// FUNCION INCREMENTAR POSICION ////////////
;Función: Incrementa la posición del HL en SHIP_SIZE
;--------------------------------------
;Modidify; HL, BC
;Input: HL: Dirección de la entidad
man_incrementarPosicion:
    ld bc, ENTITY_SIZE
    add hl, bc
ret

; ///////// FUNCION RESERVAR NAVE ////////////
;Función: Reserva una nave para su uso
;--------------------------------------
;Output: HL: Dirección de la nave reservada
;Input: HL(Dirección de la nave a reservar), B (Tipo de entidad)
;Warnings: Si HL es FFFF, no se reserva (no hay libres)

man_entity_alloc:
    ld [hl], b 
ret





; ///////// FUNCION COMPROBAR SI ES TIPO DADO ////////////
;Función: Comprueba si la nave es del tipo que se le pasa
;--------------------------------------
;Output: Z si es del tipo, NZ si no lo es
;Input: HL(Dirección de la nave, primera pos (commponente)), B (Tipo a comprobar)

man_entity_is_of_type_b:
    ld a, [hl]
    cp b
ret


; ///////// FUNCION COMPROBAR SI HAY ESPACIO ////////////
;Función: Comprueba si hay espacio para una entidad
;--------------------------------------
;Output: Z si hay espacio, NZ si no lo hay
;Input: B (Tipo de entidad)
;Modifica: HL
man_entity_check_free:
    ld a, $02                   ;Tipo de entidad nave
    cp b
    jr z, .naves
    ld a, $03                   ;Tipo de entidad disparo
    cp b
    jr z, .shots

    .naves
        ld c, MAX_SHIPS
        ld a, [num_ships]
        cp c
    ret

    .shots
        ld c, MAX_SHOTS
        ld a, [num_shots]
        cp c
    ret
    


; ///////// FUNCION CAMBIAR VELOCIDADES ////////////
;Función: Cambia las velocidades de la nave
;--------------------------------------
;Input: HL(Dirección de la nave), D (Velocidad en Y), E (Velocidad en X)
;Modifica: A

man_entity_change_velocity:
push hl
 ;Para cuando se cambia al mover el personaje que no altere las velocidades que son "d e"
    push de
    ld de, ENTITY_VY
    call man_entity_obtein_by_index
    pop de
    
    ld [hl], d
    inc hl
    inc hl
    ld [hl], e

    ld a, [player_lifes]
    cp 0
    jr z, .acabado

    ld a, 1
    ld [SCENE_STATE], a

    .acabado
pop hl
ret

;Función: Devuelve la posición X e Y
;OUTPUT: B(Posición Y), C(Posición X)
man_entity_return_pos:
    
    push hl
    push de
        ld de, ENTITY_POSY
        add hl, de
        ld a, [hl]
        ld b, a

        inc hl
        inc hl

        ld a, [hl]
        ld c, a
    pop de
    pop hl 
ret


; ///////// FUNCION LLAMAR FUNCION AI ////////////
;Función: Devuelve la dirección de la función AI de la entidad
;--------------------------------------
;Input: HL(Dirección de la entidad)
;Output: DE(Dirección de la función AI)
man_entity_returnFunctionAI:
;push hl
;    ld de, ENTITY_SIZE
;    add hl, de
;    dec hl
;    dec hl
;    dec hl                  ;HL: Dirección de la funcion
;    ld d, [hl]              ;Valor alto de la dirección de la función
;    inc hl
;    ld e, [hl]              ;Valor bajo de la dirección de la función
;pop hl

push hl
    ld de, ENTITY_COMPORTMENT
    call man_entity_obtein_by_index
    ld d, [hl]              ;Valor alto de la dirección de la función
    inc hl
    ld e, [hl]              ;Valor bajo de la dirección de la función
pop hl
ret


; ///////// FUNCION CAMBIAR POSICION X ////////////
;Función: Cambia la posición X de la entidad
;--------------------------------------
;Input: HL(Dirección de la entidad), A (Posición X)

man_entity_change_posx:
push hl
    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    ld [hl], a
pop hl
ret

; ///////// FUNCION OBTENER POSICION X OBJETIVO////////////
;Función: Cambia la posición X objetivo de la entidad
;--------------------------------------
;Input: HL(Dirección de la entidad), A (Posición X Objetivo)

man_entity_get_pos_x:
push hl
    ld de, ENTITY_POSX
    call man_entity_obtein_by_index
    ld a, [hl]
pop hl
ret

; ///////// FUNCION CAMBIAR POSICION Y OBJETIVO////////////
;Función: Cambia la posición Y objetivo de la entidad
;--------------------------------------
;Input: HL(Dirección de la entidad)
;OUTPUT: A (Pos Y)
man_entity_get_pos_y:
push hl
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index
    ld a, [hl]
pop hl
ret

; ///////// FUNCION CAMBIAR POSICION X OBJETIVO////////////
;Función: Cambia la posición X objetivo de la entidad
;--------------------------------------
;Input: HL(Dirección de la entidad), A (Posición X Objetivo)

man_entity_change_pos_obj_x:
push hl
    ld de, ENTITY_POS_OBJ_X
    call man_entity_obtein_by_index
    ld [hl], a
pop hl
ret

; ///////// FUNCION CAMBIAR POSICION Y ////////////
;Función: Cambia la posición Y de la entidad
;--------------------------------------
;Input: HL(Dirección de la entidad), C (Posición Y)

man_entity_change_posy:
push hl
    ld de, ENTITY_POSY
    call man_entity_obtein_by_index
    ld [hl], c
pop hl
ret

; ///////// FUNCION CAMBIAR POSICION Y OBJETIVO////////////
;Función: Cambia la posición Y objetivo de la entidad
;--------------------------------------
;Input: HL(Dirección de la entidad), A (Posición Y Objetivo)
man_entity_change_pos_obj_y:
push hl
    ld de, ENTITY_POS_OBJ_Y
    call man_entity_obtein_by_index
    ld [hl], a
pop hl
ret

man_entity_rotate_down:
    ld de, ATRIBUTOS_SPRITE1
    push hl
    call man_entity_obtein_by_index
    ld a, %01000000
    ld [hl], a
    pop hl
ret


;////// FUNCION ENCONTRAR PRIMERA FLOR ////////////
;Función: Encuentra la primera flor en el array de entidades
;--------------------------------------
;Output: HL: Dirección de la primera flor
;Modifica: HL, DE, B
man_entity_find_first_flower:
    
;    ld hl, entityArray
;    ld de, ENTITY_SIZE
;    ld b, TYPE_FLOWER        ;B: Estado pasamos a la función de comprobar
;
;    .loop
;        call man_entity_is_of_type_b    
;        jr z, .encontrado
;        add hl, de
;    jr .loop
;
;    .noEncontrado
;        ld hl, $FFFF
;
;    .encontrado
    ld hl, $C0D0
ret

man_entity_next_entity:
push de 
    ld de, ENTITY_SIZE
    add hl, de
pop de
ret

    

;Input: B (Indice flor)
man_entity_start_timer_flower_id:
    ld hl, arrayFlores
    ld a, b
    cp 0 
    jr z, .no_avanzar

    .avanzar
        inc hl
        dec b
    jr nz, .avanzar

    .no_avanzar
        ld a, [hl]
        cp 1
        jr nz, .no_change               ;Si no esta en estado asignada, no cambiar a estado inicio contador (si no en estado muerta tambien cambiaría)
        ld a, 2                         ;2 en el arrayFlores (Contador activo)
        ld [hl], a

    .no_change
ret


;Función: Encotrar al enemigo asignado al indice de la flor
;INPUT: D (Indice de la flor)
;OUTPUT: HL (Dirección del enemigo)

man_entity_find_enemy_flower_id:
    ld hl, entityArray
    ld b, SHIP_TYPE_ENEMY1
    ld c, MAX_ENTITIES

    .loop
        ld a, [hl]
        cp b
        jr nz, .no_type

            push hl
            push de
                ld de, ENEMY_FLOWER_ASSIGNED
                call man_entity_obtein_by_index
                ld a, [hl]                          ;A = Indice de la flor asignado
            pop de
            pop hl
            cp d                                ;B = Indice de la flor
            jr z, .found
            
        
        .no_type
        call incPos
        dec c
    jr nz, .loop

    .found
ret

man_entity_find_flower_id:
    call man_entity_find_first_flower

    ld a, d
    cp 0
    jr z, .no_incrementar
    .incrementar
        call incPos
        dec a
        cp 0
    jr nz, .incrementar
    .no_incrementar
    

ret
    

;Función: Guarde las dos primeras flores no muertas
man_entity_get_two_first_flower_no_dead_priority_assigned:
    ld hl, arrayFlores
    ld b, MAX_FLOWERS
    ld c, 0
    ld de, array_assign_enemy2

    .loop
        ld a, [hl]
        cp TYPE_FLOWER_DEAD
        jr z, .no_add
        cp 0
        jr z, .no_add

        ;Si no es 0 ni 99 es decir o 1 o 2
        inc c
        ld a, c
        ld [de], a
        inc de
        cp 2
        jr z, .exit

        .no_add
        inc hl
        dec b
    jr nz, .loop

    ;Comprueba cuantas flores asignadas ha encontrado. Si no es una es 0
    ;Si es 2 ya habría salido arriba
    ld a, c
    cp 1
    jr z, .add_one

    ;Si no ha añadido ninguno asignado, intenta añadir dos 0
    ld b, MAX_FLOWERS
    ld de, array_assign_enemy2
    .loop2
        ld a, [hl]
        cp 0
        jr nz, .no_add2

        inc c
        ld a, c
        ld [de], a
        inc de
        cp 2
        jr z, .exit

        .no_add2
        inc hl
        dec b
    jr nz, .loop2

    
    ;Si ha añadido solo 1 asignado, intenta añadir dos 0
    .add_one
    ld b, MAX_FLOWERS
    ld de, array_assign_enemy2 + 1
    
    .loop1
        ld a, [hl]
        cp 0
        jr nz, .no_add1

        inc c
        ld a, c
        ld [de], a
        cp 1
        jr z, .exit

        .no_add1
        inc hl
        dec b
    jr nz, .loop1




    .exit           ;C = 2. (2 Flores asignadas)
ret


man_entity_get_two_first_flower_no_dead:
    ld hl, arrayFlores
    ld b, MAX_FLOWERS
    ld c, 0
    ld de, array_help_flowers
    ld a, 0
    ld [help_1byte], a

    .loop
        ld a, [hl]
        cp TYPE_FLOWER_DEAD
        jr z, .no_add

        ld a, c
        ld [de], a
        inc de
        ;Número de flores no muertas encontradas
        ld a, [help_1byte]
        inc a
        ld [help_1byte], a


        .no_add
        inc hl
        inc c
        dec b
    jr nz, .loop


    ;Generar numeros aleatorios entre 0 y [help_1byte]
    
    ld a, [help_1byte]
    cp 0
    jr z, .not_do
    dec a
    ld c, a

    push bc
    call generate_random
    pop bc
    and c
    
    ld d, a                         ;D = Primer indice a elegir


    push de
    push bc
    call generate_random
    pop bc
    pop de
    and c

    ld e, a                         ;E = Segundo indice a elegir

    ld hl, array_help_flowers      ;2 bytes, 2 tipos de enemigos
    push de
        ld e, d
        ld d, 0
        add hl, de
    pop de

    ld a, [hl]
    ld b, a                         ;B = Primer indice de la flor

    ld hl, array_help_flowers      ;2 bytes, 2 tipos de enemigos
    push de
        ld d, 0
        add hl, de
    pop de

    ld a, [hl]
    ld c, a

    ld hl, array_assign_enemy2
    ld a, b
    ld [hl+], a
    ld a, c
    ld [hl], a
    
.not_do
.exit
ret


;Función: Cambiar el sprite de la entidad
;Input: B (Sprite)
man_entity_change_sprite:
    ld de, ENTITY_SPRITE1
    add hl, de
    ld a, b
    ld [hl], a

ret

;Funcion: Devuelve el sprite
;Output: B (Sprite)
man_entity_get_sprite:
push hl
    ld de, ENTITY_SPRITE1
    add hl, de
    ld a, [hl]
    ld b, a
pop hl

ret

;Función: Encuentra la primera flor marcada como muerta
;Output: HL (Posicion de la primera flor muerta)
;Warning: Siempre que entre tiene que haber una flor muerta
man_entity_find_first_flower_dead: 
    ld hl, arrayFlores
    ld b, 5
    ld c, 0

    .loop
        ld a, [hl]
        cp TYPE_FLOWER_DEAD
        jr z, .encontrada
        inc hl
        inc c
        dec b
    jr nz, .loop

    .encontrada
    ld a, 0         ;Poner la flor como sin asignar en el array de flores
    ld [hl], a

    ;Encontrar la flor en el array de entidades
    call man_entity_find_first_flower
    ld a, c
    cp 0
    jr z, .no_advance
    .advance
        call incPos
        dec c
    jr nz, .advance

    .no_advance

ret
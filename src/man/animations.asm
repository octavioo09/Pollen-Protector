include "../include/hardware.inc"
include "../include/constantes.inc"
;include "../include/entity_defines.asm"

SECTION "ANIMATION", ROM0


;///////// FUNCION ANIMACION////////////
;Función: Obtener en HL la posición del valor de una entidad pasado por d
;--------------------------------------
;INPUT: E: Direccion de la entidad actual
;Modifica: HL, BC, D, A




;///////// FUNCION ANIMACION////////////
;Función: Inicializa los bytes del array de naves a 0
;--------------------------------------
;INPUT: HL: Direccion de la entidad actual
;Modifica: HL, BC, D, A
man_animation_update_for_one:
  
    ld a, [hl]
    cp TYPE_FLOWER
    jr z, .fin


    push hl
    
    ld de, ENTITY_ANIMATION_TIMER
    call man_entity_obtein_by_index

    ld a, [hl]                  ; Carga el timer para saber si parar o no
    dec a
    ld [hl], a                       
    jr nz, .skip_animation      ; Si no ha llegado a 0, saltar el cambio de frame
    ld a, 10                    
    ld [hl], a

    pop hl

    ld de, ENTITY_FRAME_ANIMATION  ;Hay que hacer una funcion que lo que haga sea hacer toda esta pesca, le pases el indice y te devuelva en hl la direccion
    call man_entity_obtein_by_index

    ld a, [hl]                  ; Cargar el índice del frame actual
    inc a                       ; Incrementar el índice del frame
    cp 2                        
    jr nz, .update_sprite       ; Si no ha alcanzado el último frame, actualizar
    xor a                       ; Reiniciar el índice si ha alcanzado el último frame

    .update_sprite:
    ld [hl], a

    cp 1                        ; Comparar con el segundo frame
    jr nz, .primero
       
    dec hl                     ; Dirección de la OAM para el sprite del jugador
    dec hl                     ; Dirección de la OAM para el sprite del jugador
    inc [hl]

    ret

    .primero:
    dec hl                     ; Dirección de la OAM para el sprite del jugador
    dec hl                     ; Dirección de la OAM para el sprite del jugador
    dec [hl]
    
    ret

    .skip_animation:
    
    pop hl

    .fin
ret

man_animation_update:

    ld de, man_animation_update_for_one
    call man_entity_for_all

ret
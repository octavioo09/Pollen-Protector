include "../include/hardware.inc"
include "../include/constantes.inc"
SECTION "Input variables", HRAM
    estadoBotones:      DS 1
    estadoDirecciones:  DS 1
    flancoAscendente:   DS 1

SECTION "Utils", ROM0
wait_vblank_start::
    ld a, [$FF44]
    cp 144
    jr nz, wait_vblank_start
ret


load_all_sprites_VRAM8x8:
    call wait_vblank_start

    ld de, $8000
    ld hl, Abeja
    ld bc, AbejaFin-Abeja
    call load_sprite_fuente_VRAM

    ld de, $8100
    ld hl, AbejaRight
    ld bc, FinAbejaRight-AbejaRight
    call load_sprite_fuente_VRAM

    call wait_vblank_start
    ld de, $8FF0
    ld hl, Abeja2
    call load_sprite_VRAM

    ld de, $80F0
    ld hl, AbejaRight2
    call load_sprite_VRAM

    call wait_vblank_start
    ld de, $8020
    ld hl, Cangrejo
    call load_sprite_VRAM
    ld hl, Explosion
    call load_sprite_VRAM
    ld hl, Misil
    call load_sprite_VRAM

    ld de, $8140
    ld hl, MisilInvertido
    call load_sprite_VRAM

    ld de, $8050
    ld hl, Insectos
    ld bc, FinInsectos-Insectos
    call load_sprite_fuente_VRAM

    ld de, $8150
    ld hl, InsectosGirados
    ld bc, FinInsectosGirados-InsectosGirados
    call load_sprite_fuente_VRAM


    ld de, $8400

    ld hl, Fondo
    ld bc, Finfondo-Fondo
    call load_sprite_fuente_VRAM

    ld hl, Vallas
    ld bc, FinVallas-Vallas
    call load_sprite_fuente_VRAM

    ld de, $8600
    ld hl, Fuente 
    ld bc, TILE_SIZE
    call load_sprite_fuente_VRAM

    ld de, $8900
    ld hl, Inicio
    ld bc, finInicio-Inicio
    call load_sprite_fuente_VRAM
ret


;///////// FUNCION CARGAR SPRITE EN VRAM ////////////
;Función: Carga un sprite en la VRAM
;--------------------------------------
;Inputs: HL (Dirección del sprite)
load_sprite_VRAM::
    ;call wait_vblank_start
    ;ld hl, Abeja
    ld b, 16

    .copiar
        ld a, [hl]
        ld [de], a
        inc hl
        inc de
        dec b
    jr nz, .copiar

ret

 load_sprite_fuente_VRAM::
    call wait_vblank_start
    ;Apagar pantalla
    ld a, [rLCDC]
    res 7, a
    ld [rLCDC], a

    .copiar
        ld a, [hl]
        ld [de], a
        inc hl
        inc de
        dec bc
        ld a, c
        cp 0
    jr nz, .copiar
        ld a, b
        cp 0
    jr nz, .copiar

    ;Encender pantalla
    ld a, [rLCDC]
    set 7, a
    ld [rLCDC], a

ret


read_buttons:
    ld a, $20               ;00100000, seleccionan los botones, desactiva las acciones y deja activado con 0 todo lo demás
    ldh [rP1], a            ;Se seleccionan del registro de entrada del joypad los botones
    ld a, [rP1]             ;Se lee el registro de entrada del joypad

    cpl                     ;Se invierten los bits (1 si se pulsa 0 no)  
    and $0F                 ;0000 xxxx. Se eliminan los bits de las direcciones
    swap a                  ;xxxx 0000. Se intercambian los nibbles (los mueve a la izquierda, para poner luego a la dcha los de acción)

    ld b, a                 ;Se guarda en B el valor de los botones de dirección


    ld a, $30
    ldh [rP1], a

    
    ld a, $10               ;00010000, seleccionan las direcciones, desactiva las botones y deja activado con 0 todo lo demás
    ldh [rP1], a            ;Se seleccionan del registro de entrada del joypad las acciones
    ld a, [rP1]             ;Se lee el registro de entrada del joypad

    cpl
    and $0F                 ;0000 xxxx
    
    or b                    ;xxxx 0000. Se combinan los bits de acción con los de dirección almacenados en b
                            ;0000 xxxx
    ld b,a                  ;Se guarda en b el estado de los botones actual
    ldh a, [estadoBotones]   ;Se carga en a el estado de los botones anterior


    xor b                   ;Se comparan (Si ha cambiado 1, si no ha cambiado 0)
    and b                   ;Nos quedamos con los que en el actual sean 1, es decir en el anterior eran 0

    ldh [flancoAscendente], a  ;Se guarda en el estado de los botones el valor de los botones que han cambiado

    ld a, b                 ;Se carga en a el estado de los botones actual
    ldh [estadoBotones], a  ;Se guarda en el estado de los botones el valor de los botones actual

    ld a, $30
    ldh [rP1], a

ret


limpiarSpriteBuffer:
    ld hl, wShadowOAM
    ld b, 160
    ld a, 0
    .limpiar
        ld [hl], a
        inc hl
        dec b
    jr nz, .limpiar
ret

copiarEntities2DMA:        

    ld hl, entityArray
    ld de, wShadowOAM
    ld b, 40

    .copiar
        ld a, [hl]          ;Estado
        cp SHIP_TYPE_INVALID
        jr z, .ponerA0
        cp TYPE_FLOWER_DEAD
        jr z, .ponerA0

        push hl
            inc hl
            inc hl
            ld a, [hl]
            ld [de], a      ;POSY
            inc de
            inc hl
            inc hl
            ld a, [hl]
            ld [de], a      ;POSX
            inc de 
            inc hl
            inc hl
            ld a, [hl]
            ld [de], a      ;Sprite
            inc de 
            inc hl
            ld a, [hl]
            ld [de], a      ;Atributos
            inc de 
        pop hl
        jr .siguiente


        ;Si hay una entidad por en medio a 00, en la oam se pondrá todo 0 en esa posición, por lo que quedarán huecos por enmedio
        .ponerA0
            ld a, 0
            ld [de], a
            inc de
            ld [de], a
            inc de
            ld [de], a
            inc de
            ld [de], a
            inc de


    .siguiente
    push de
        ld de, ENTITY_SIZE
        add hl, de
    pop de

        dec b
    jr nz, .copiar
ret


SECTION "Random Seed", WRAM0
rand_seed:      DS 4        ; Semilla para el generador aleatorio (32 bits)

SECTION "Initialization", ROM0
initialize_seed:
    ; Inicializar la semilla (por ejemplo, usando un número fijo)
    ld hl, rand_seed
    ;Coger el timer
    .coger_timer
        ld a, [$FF04]
        add $24
        cp 0
    jr z, .coger_timer

    ;ld a, $AB          ; Byte menos significativo
    ld [hl], a          ; Almacenar en seed[0]
    inc hl

    add a
    add a
    add $20
    ;ld a, $1F          ; Segundo byte
    ld [hl], a          ; Almacenar en seed[1]
    inc hl

    
    add a
    ;ld a, $E8          ; Tercer byte
    ld [hl], a          ; Almacenar en seed[2]
    inc hl

    add $14
    ;ld a, $99          ; Byte más significativo
    ld [hl], a          ; Almacenar en seed[3]
    ret

SECTION "Random Generator", ROM0

; cpct_nextRandom_mxor_u8
; Entradas: DE:HL = estado (32 bits)
; Salidas:   DE:HL = nuevo estado (32 bits)
;            A = número aleatorio de 8 bits
generate_random:
    ld hl, rand_seed   ; Cargar dirección de la semilla en HL
    ld d, [hl]         ; Cargar x (s[0]) en D
    inc hl
    ld e, [hl]         ; Cargar z (s[1]) en E
    inc hl
    ld b, [hl]         ; Cargar y (s[2]) en B
    inc hl
    ld c, [hl]         ; Cargar w (s[3]) en C

    ; Aplicar el algoritmo XOR Shift
    ld a, b            ; x' = y
    ld d, a           ; Almacenar nuevo x en D

    ld a, e            ; y' = z
    ld b, a           ; Almacenar nuevo y en B

    ld a, c            ; z' = w
    ld e, a           ; Almacenar nuevo z en E

    ; t = x ^ (x << 3)
    ld a, d            ; Cargar x
    ld h, a            ; Guardar x en H
    sla a               ; a = x << 1
    sla a               ; a = x << 2
    sla a               ; a = x << 3
    xor h               ; t = x ^ (x << 3)

    ; t = t ^ (t >> 1)
    ld h, a            ; Guardar t en H
    sra a               ; Desplazar t a la derecha
    xor h               ; t = t ^ (t >> 1)

    ; w' = w ^ (w << 1) ^ t
    ld a, c            ; Cargar w
    ld h, a            ; Guardar w en H
    sla a               ; a = w << 1
    xor h               ; w' = w ^ (w << 1)
    xor d               ; w' = w' ^ t
    ld c, a            ; Almacenar nuevo w en C

    ; Actualizar el estado
    ld hl, rand_seed   ; Cargar dirección de la semilla en HL
    ld a, d            ; Cargar nuevo x
    ld [hl], a         ; Almacenar nuevo x
    inc hl
    ld a, e            ; Cargar nuevo y
    ld [hl], a         ; Almacenar nuevo y
    inc hl
    ld a, b            ; Cargar nuevo z
    ld [hl], a         ; Almacenar nuevo z
    inc hl
    ld a, c            ; Cargar nuevo w
    ld [hl], a         ; Almacenar nuevo w

    ; Retornar el byte menos significativo
    ld a, d            ; Cargar el byte menos significativo como resultado
ret


wait_for_a_press:
    ld a, 1
    ld [is_pause], a

    call read_buttons
    ld a, [flancoAscendente]
    and %00000001            ; Comprobar si el botón A (bit 0) está presionado
    jr z, wait_for_a_press   ; Esperar hasta que A esté presionado

    ;Desactivar la ventana cuando termine de escribir
    ld a, [rLCDC]
    and %11011111
    ld [rLCDC], a

    ld a, 0
    ld [is_pause], a
ret



; Este código actualiza el temporizador sin bloquear el flujo de ejecución del juego
wait_for_warning_timer:
    ld a, [warning_timer]
    cp 0
    jr z, .salir_decrementar   ; Si es 0, salir para ocultar la ventana y reiniciar el temporizador

    ; Decrementa el temporizador si aún no ha llegado a 0
    dec a
    ld [warning_timer], a
    ret                        ; Regresa sin bloquear la ejecución del juego

    .salir_decrementar
    ; Si el temporizador llegó a 0, reinicia el temporizador y oculta la ventana
    

    ; Desactivar la ventana cuando termine de escribir
    ld a, [rLCDC]
    and %11011111
    ld [rLCDC], a
ret

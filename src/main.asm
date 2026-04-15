include "../include/constantes.inc"

SECTION "Entry point", ROM0[$150]

main::

   ;;LLAMAR AL MANAGER ESCENAS
   juego:

   call man_escenas_init         ;Se inicializa la priera escena a INICIO
   call man_escenas_update       ;Se actualizan las escenas


      ;call man_game_init
      ;call man_game_play

   di     ;; Disable Interrupts
   halt   ;; Halt the CPU (stop procesing here)

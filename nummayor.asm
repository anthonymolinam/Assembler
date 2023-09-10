.data
numbers:    .word 5, 10, 2, 8, 20   # Declaración de un arreglo llamado "numbers" con valores iniciales
newline:    .asciiz "\n"           # Declaración de una cadena llamada "newline" para imprimir una nueva línea

.text
main:
    # Configuración inicial
    la $t0, numbers         # Cargamos la dirección base del arreglo "numbers" en $t0
    lw $t1, 0($t0)          # Cargamos el primer número del arreglo en $t1
    lw $t2, 0($t0)          # Inicializamos $t2 con el primer número del arreglo como candidato mayor

loop:
    lw $t3, 4($t0)          # Cargamos el siguiente número en el arreglo en $t3
    beq $t3, $zero, done    # Si $t3 es igual a cero, significa que hemos llegado al final del arreglo, así que salimos del bucle

    # Comparamos $t3 con el candidato actual en $t2
    bgt $t3, $t2, update    # Si $t3 es mayor que el candidato actual $t2, saltamos a la etiqueta "update"
    j continue              # Si no, continuamos en la etiqueta "continue"

update:
    move $t2, $t3           # Actualizamos $t2 con el nuevo candidato mayor, que es $t3

continue:
    addi $t0, $t0, 4        # Avanzamos al siguiente número en el arreglo (cada número ocupa 4 bytes)
    j loop                  # Saltamos de nuevo a la etiqueta "loop" para procesar el siguiente número en el arreglo

done:
    # Imprimir el número mayor en la consola
    li $v0, 1                # Código de servicio 1 para imprimir un entero
    move $a0, $t2            # Cargamos el número mayor (en $t2) en el registro de argumento $a0
    syscall

    # Imprimir una nueva línea
    li $v0, 4                # Código de servicio 4 para imprimir una cadena
    la $a0, newline          # Cargamos la dirección de la cadena "newline" en el registro de argumento $a0
    syscall

    # Terminamos el programa
    li $v0, 10               # Código de servicio 10 para salir del programa
    syscall

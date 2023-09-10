.data
numbers:    .word 5, 10, 2, 8, 20   # Aquí puedes ingresar tus números separados por comas
newline:    .asciiz "\n"

.text
main:
    # Configuración inicial
    la $t0, numbers         # Cargamos la dirección base del arreglo
    lw $t1, 0($t0)          # Cargamos el primer número en $t1
    lw $t2, 0($t0)          # Inicializamos $t2 con el primer número como candidato menor

loop:
    lw $t3, 4($t0)          # Cargamos el siguiente número en el arreglo en $t3
    beq $t3, $zero, done    # Si llegamos al final del arreglo, salimos del bucle

    # Comparamos $t3 con el candidato actual en $t2
    blt $t3, $t2, update    # Si $t3 es menor que el candidato actual $t2, saltamos a la etiqueta "update"
    j continue              # Si no, continuamos en la etiqueta "continue"

update:
    move $t2, $t3           # Actualizamos $t2 con el nuevo candidato menor, que es $t3

continue:
    addi $t0, $t0, 4        # Avanzamos al siguiente número en el arreglo (cada número ocupa 4 bytes)
    j loop                  # Saltamos de nuevo a la etiqueta "loop" para procesar el siguiente número en el arreglo

done:
    # Imprimir el número menor en la consola
    li $v0, 1                # Código de servicio 1 para imprimir un entero
    move $a0, $t2            # Cargamos el número menor (en $t2) en el registro de argumento $a0
    syscall

    # Imprimir una nueva línea
    li $v0, 4                # Código de servicio 4 para imprimir una cadena
    la $a0, newline          # Cargamos la dirección de la cadena "newline" en el registro de argumento $a0
    syscall

    # Terminamos el programa
    li $v0, 10               # Código de servicio 10 para salir del programa
    syscall

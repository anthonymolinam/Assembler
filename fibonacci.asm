.data
fib_msg: .asciiz "Serie de Fibonacci:\n"      # Mensaje inicial
result_msg: .asciiz "Resultado: "               # Mensaje para los resultados
newline: .asciiz "\n"                           # Salto de l�nea

.text

main:
    # Imprimir el mensaje de la serie de Fibonacci
    li $v0, 4
    la $a0, fib_msg
    syscall

    # Inicializar los primeros dos t�rminos de la serie
    li $t0, 0   # F(0)
    li $t1, 1   # F(1)

    # Calcular y mostrar los t�rminos siguientes de la serie
    li $t3, 10  # N�mero de t�rminos a calcular (cambia seg�n tus necesidades)

calculate_fibonacci:
    # Calcular el siguiente t�rmino de Fibonacci: F(n) = F(n-1) + F(n-2)
    addu $t2, $t0, $t1  # Utilizar addu en lugar de add para evitar desbordamientos

    # Imprimir el t�rmino calculado
    li $v0, 4
    la $a0, result_msg
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir un salto de l�nea
    li $v0, 4
    la $a0, newline
    syscall

    # Actualizar los valores para la pr�xima iteraci�n
    move $t0, $t1
    move $t1, $t2

    # Decrementar el contador de t�rminos y verificar si hemos terminado
    subi $t3, $t3, 1
    bnez $t3, calculate_fibonacci

    # Salir del programa
    li $v0, 10
    syscall

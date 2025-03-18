        # ApellidoNombre_Fibonacci.asm
        .data
promptCount:    .asciiz "Cuantos numeros de la serie Fibonacci desea generar? "
msgSeries:      .asciiz "\nLa serie Fibonacci es: "
msgSum:         .asciiz "\nLa suma de la serie es: "
space:          .asciiz " "
newline:        .asciiz "\n"

        .text
main:
        # Imprimir prompt para pedir la cantidad de numeros de Fibonacci
        li      $v0, 4
        la      $a0, promptCount
        syscall

        # Leer la cantidad de numeros
        li      $v0, 5
        syscall
        move    $t0, $v0            # $t0 = cantidad de numeros solicitados

        # Imprimir mensaje inicial de la serie
        li      $v0, 4
        la      $a0, msgSeries
        syscall

        # Inicializar la suma de la serie en 0
        li      $t7, 0              # $t7 acumulador de la suma

        # Verificar si se debe generar al menos el primer numero (0)
        bgtz    $t0, fib_start
        j       end_program         # Si la cantidad es 0 o negativa, salir

fib_start:
        # Imprimir el primer numero: 0
        li      $v0, 1
        li      $a0, 0
        syscall

        # Imprimir un espacio
        li      $v0, 4
        la      $a0, space
        syscall

        # El primer numero (0) ya se imprime; se decrementa la cantidad
        addi    $t0, $t0, -1

        # Si ya no hay mas numeros, saltar a imprimir la suma
        blez    $t0, print_sum

        # Imprimir el segundo numero: 1
        li      $v0, 1
        li      $a0, 1
        syscall

        # Imprimir un espacio
        li      $v0, 4
        la      $a0, space
        syscall

        # Acumular el segundo numero en la suma
        addi    $t7, $t7, 1

        # Decrementar la cantidad de numeros restantes
        addi    $t0, $t0, -1

        # Preparar variables para el ciclo Fibonacci:
        # $t1 = a (inicialmente 0) y $t2 = b (inicialmente 1)
        li      $t1, 0
        li      $t2, 1

fib_loop:
        blez    $t0, print_sum       # Si ya no quedan numeros, salir del ciclo

        # Calcular el siguiente numero: t3 = a + b
        add     $t3, $t1, $t2

        # Imprimir el siguiente numero
        li      $v0, 1
        move    $a0, $t3
        syscall

        # Imprimir un espacio
        li      $v0, 4
        la      $a0, space
        syscall

        # Acumular el numero actual en la suma
        add     $t7, $t7, $t3

        # Actualizar los valores para la siguiente iteracion: a = b, b = t3
        move    $t1, $t2
        move    $t2, $t3

        # Decrementar la cantidad de numeros restantes
        addi    $t0, $t0, -1
        j       fib_loop

print_sum:
        # Imprimir mensaje de la suma
        li      $v0, 4
        la      $a0, msgSum
        syscall

        # Imprimir el valor acumulado en la suma
        li      $v0, 1
        move    $a0, $t7
        syscall

        # Imprimir salto de linea final
        li      $v0, 4
        la      $a0, newline
        syscall

end_program:
        # Terminar el programa
        li      $v0, 10
        syscall

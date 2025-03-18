        # ApellidoNombre_Menor.asm
        .data
promptCount:    .asciiz "Cuantos numeros desea comparar (3 a 5)? "
promptNumber:   .asciiz "Digite un numero: "
msgResult:      .asciiz "\nEl numero menor es: "
newline:        .asciiz "\n"

        .text
main:
        # Imprimir mensaje para pedir la cantidad de numeros a comparar
        li      $v0, 4
        la      $a0, promptCount
        syscall

        # Leer cantidad de numeros
        li      $v0, 5
        syscall
        move    $t0, $v0            # $t0 = cantidad de numeros

        # Pedir el primer numero
        li      $v0, 4
        la      $a0, promptNumber
        syscall

        li      $v0, 5              # Leer el primer numero
        syscall
        move    $t1, $v0            # $t1 guarda el numero menor (inicialmente el primer numero)

        # Preparar el contador del ciclo: se resta 1 al total
        addi    $t2, $t0, -1        # $t2 = cantidad - 1

loop:
        beq     $t2, $zero, print_result   # Si ya se leyeron todos, salir del ciclo

        # Pedir el siguiente numero
        li      $v0, 4
        la      $a0, promptNumber
        syscall

        li      $v0, 5              # Leer el numero actual
        syscall
        move    $t3, $v0            # $t3 = numero actual

        # Comparar el numero actual con el menor almacenado en $t1
        bge     $t3, $t1, skip_update   # Si t3 >= t1, no se actualiza el minimo
        move    $t1, $t3            # Actualizar el numero menor

skip_update:
        addi    $t2, $t2, -1        # Decrementar el contador
        j       loop                # Repetir el ciclo

print_result:
        # Imprimir mensaje de resultado
        li      $v0, 4
        la      $a0, msgResult
        syscall

        # Imprimir el numero menor encontrado
        li      $v0, 1
        move    $a0, $t1
        syscall

        # Imprimir salto de linea final
        li      $v0, 4
        la      $a0, newline
        syscall

        # Terminar el programa
        li      $v0, 10
        syscall

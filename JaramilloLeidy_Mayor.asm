        # ApellidoNombre_Mayor.asm
        .data
promptCount:    .asciiz "Cuantos numeros desea comparar (3 a 5)? "
promptNumber:   .asciiz "Digite un numero: "
msgResult:      .asciiz "\nEl numero mayor es: "
newline:        .asciiz "\n"

        .text
main:
        # Imprimir mensaje para pedir la cantidad de numeros a comparar
        li      $v0, 4              # Syscall 4: imprimir cadena
        la      $a0, promptCount
        syscall

        # Leer cantidad de numeros
        li      $v0, 5              # Syscall 5: leer entero
        syscall
        move    $t0, $v0            # $t0 contiene la cantidad de numeros

        # Pedir el primer numero
        li      $v0, 4
        la      $a0, promptNumber
        syscall

        li      $v0, 5              # Leer primer numero
        syscall
        move    $t1, $v0            # $t1 se usará para almacenar el mayor (inicialmente el primer numero)

        # Preparar el contador de ciclo: ya se leyó 1 número, se deben leer (cantidad-1) números más
        addi    $t2, $t0, -1        # $t2 = cantidad - 1

loop:
        beq     $t2, $zero, print_result   # Si ya se leyeron todos, saltar a imprimir resultado

        # Pedir el siguiente numero
        li      $v0, 4
        la      $a0, promptNumber
        syscall

        li      $v0, 5              # Leer el numero
        syscall
        move    $t3, $v0            # $t3 = numero actual

        # Comparar numero actual con el mayor almacenado en $t1
        ble     $t3, $t1, skip_update   # Si t3 <= t1, no se actualiza el mayor
        move    $t1, $t3            # Actualizar el mayor

skip_update:
        addi    $t2, $t2, -1        # Decrementar el contador de numeros restantes
        j       loop                # Repetir el ciclo

print_result:
        # Imprimir mensaje de resultado
        li      $v0, 4
        la      $a0, msgResult
        syscall

        # Imprimir el numero mayor encontrado
        li      $v0, 1              # Syscall 1: imprimir entero
        move    $a0, $t1
        syscall

        # Imprimir salto de linea final
        li      $v0, 4
        la      $a0, newline
        syscall

        # Terminar el programa
        li      $v0, 10
        syscall

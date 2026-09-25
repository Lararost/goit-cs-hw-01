; Task 1
; Calculate b - c + a
; Compatible with TASM/MASM for 16-bit DOS

.model small
.stack 100h

.data
    a dw 7
    b dw 10
    c dw 4

    result_msg db 'Result: $'
    newline db 13, 10, '$'

.code

main proc
    mov ax, @data
    mov ds, ax

    ; b - c + a
    mov ax, b
    sub ax, c
    add ax, a

    ; Save result while printing the label
    push ax

    lea dx, result_msg
    mov ah, 09h
    int 21h

    ; Restore and print the calculated value
    pop ax
    call print_num

    lea dx, newline
    mov ah, 09h
    int 21h

    mov ax, 4C00h
    int 21h
main endp


; ------------------------------------------------------------
; print_num
; Prints a signed integer stored in AX.
; ------------------------------------------------------------
print_num proc
    cmp ax, 0
    jge check_zero

    ; Print minus sign for a negative number
    push ax
    mov dl, '-'
    mov ah, 02h
    int 21h
    pop ax
    neg ax

check_zero:
    cmp ax, 0
    jne convert_number

    mov dl, '0'
    mov ah, 02h
    int 21h
    ret

convert_number:
    xor cx, cx
    mov bx, 10

divide_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne divide_loop

print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_loop

    ret
print_num endp

end main

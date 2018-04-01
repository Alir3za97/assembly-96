section .data
    source dw 10, 100, 8, 7, 103, 5, -20000, -3, 2, 1   ;input numbers
    len equ ($ - source)/2 
section .bss
    array resw len
section .text
    global _start                               
_start:
    xor rcx, rcx
    mov cx, len
    mov edi, source
    mov esi, array

transfer:
    mov ax, [edi]                                       ;insert numbers in array
    mov [esi], ax

    add esi, 2
    add edi, 2

    loop transfer

    call bubblesort

exit:
    mov ebx, 0
    mov eax, 1
    int 80h

;-------------------------------------------------------

bubblesort:                                             ;sort Array with start pointer _array_ and length _len_

    xor rcx, rcx                                        ;initialize registers
    mov cx, len
    dec cx

    mov r8, 1                                           ;return if len == 1
    xor r9, r9
    mov r9w, len
    cmp r9w, r8w
    je return 

mainloop:                                               ;main loop of bubble sort

    mov esi, array
    
    xor r9, r9

    innerloop:

        inc r9w
        
        xor r10, r10
        xor r11, r11 
        mov r10w, [esi]
        mov r11w, [esi + 2]
        cmp r10w, r11w                                  ;check if [esi] > [esi + 2] (two consecutive numbers in array)
        jng endinnerloop

        mov [esi], r11w                                 ;if [esi] > [esi + 2] then swap [esi], [esi + 2] (two consecutive numbers in array)
        mov [esi + 2], r10w

    endinnerloop:
        add esi, 2
        cmp r9w, cx
        jne innerloop
    
    loop mainloop

return:
    ret
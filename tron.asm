
;.386
;.model small
;.stack 100h
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX
	
	mov dx, 100 ; oszlop kezdopoz
	mov bx, 100 ; sor kezdopoz
	push dx
	push bx
	
	mov ax, 13h ; grafikus mod beallitasa
	int 10h
	
	mov ax, 0a000h
	mov es, ax
	
	xor cx, cx
	mov cl, 15
	
Rajz:
	; pixel = Y * 320 + X
	pop dx
	;xor ah, ah
	;mov al, dh
	mov ax, dx
	push dx
	mov bx, 320
	mul bx
	pop dx
	pop bx
	;add al, dl ; + X
	;jnc Pixel ; ha nem csordul tul nincs carry bit
	;inc ah
	
Pixel:
	push bx
	push dx
	add ax, bx
	mov di, ax
	;mov al, 128 ; szin beallitasa
	;mov al, 15 ; szin beallitasa
	mov al, cl
	mov es:[di], al ; koordinatara allunk, extra szegmenssel memoria cimre
	
Var:
	; bevitel
	xor ah, ah
	int 16h
	
	cmp al, 27 ; esc
	jz jmp_Program_Vege
	
	cmp ah, 75 ; bal nyil scan Code
	jz Balra
	
	cmp ah, 77 ; jobb nyil scan Code
	jz Jobbra
	
	cmp ah, 72 ; fel nyil scan Code
	jz Felfele
	
	cmp ah, 80 ; le nyil scan Code
	jz Lefele
	
	cmp al, 48 ; szin0 fekete
	jz szin0
	
	cmp al, 49 ; szin1 feher
	jz szin1
	
	cmp al, 50 ; szin2 piros
	jz szin2
	
	cmp al, 51 ; szin3 zold
	jz szin3
	
	cmp al, 52 ; szin4 kek
	jz szin4
	
	cmp al, 53 ; szin5 citrom
	jz szin5
	
	cmp al, 54
	jz text_mod
	
	cmp al, 55
	jz vga_mod
	
	jmp Var ; kulonben uj bevitelt kerunk (hibas bevitel tortent)

jmp_Program_Vege:
	jmp Program_Vege
	
Tarol1:
	push dx ; frissitett koordinatakat visszatesszuk
	jmp Rajz

Tarol2:
	push dx ; X
	push bx ; Y
	jmp Rajz
	
Balra:
	pop bx ; Y
	pop dx ; X aktualis koordinatakat kivesszuk
	dec dx ; x csokkentese
	cmp dx, 1
	jnc Tarol2
	inc dx ; kulonben noveljuk 
	jmp Tarol2
	
Jobbra:
	pop bx ; Y
	pop dx ; X aktualis koordinatakat kivesszuk
	inc dx ; x novelese
	cmp dx, 320
	jc Tarol2
	dec dx ; kulonben csokkentjuk 
	jmp Tarol2
	
Felfele:
	pop dx ; Y aktualis koordinatakat kivesszuk
	dec dx ; y csokkentese
	cmp dx, 1
	jnc Tarol1
	inc dx ; kulonben noveljuk 
	jmp Tarol1
	
Lefele:
	pop dx ; Y aktualis koordinatakat kivesszuk
	inc dx ; y novelese
	cmp dx, 200
	jc Tarol1
	dec dx ; kulonben csokkentjuk 
	jmp Tarol1
	
szin0:
	mov cl, 0 ; fekete
	jmp Var
	
szin1:
	mov cl, 15 ; feher
	jmp Var
	
szin2:
	mov cl, 39 ; piros
	jmp Var

szin3:
	mov cl, 46 ; zold
	jmp Var
	
szin4:
	mov cl, 32 ; kek
	jmp Var
	
szin5:
	mov cl, 44 ; citrom
	jmp Var
	
text_mod:
	mov ax, 3h ; Set the video mode to text mode
	int 10h ; Call BIOS video services
	jmp Var
	
vga_mod:
	mov ax, 13h ; grafikus mod beallitasa
	int 10h
	
	mov ax, 0a000h
	mov es, ax
	jmp Var
	
Program_Vege:
	mov ax, 03h
	int 10h
	
	pop dx
	pop bx
	
	mov	ax, 4c00h
	int	21h



Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start





; start_menu:
	; call text_mode
	
	; mov di, offset numbers
	; mov ax, 10
	; mov [di], ax

	; start_menu_bevitel:
		; xor ah, ah
		; int 16h
		
		; ; kilepes a menubol
		; cmp ah, 1 ; esc scan code
		; jz Program_Vege
		
		; ; jatek inditasa
		; cmp ah, 28 ; enter scan code
		; jz jatek_inditasa
		
		; jmp start_menu_bevitel

; jatek_inditasa:
	; ; adatok:
	; ; dx -> 1-es jatekos oszlop
	; ; ch -> 1-es jatekos sor
	; ; bx -> 2-es jatekos oszlop
	; ; cl -> 2-es jatekos sor
	; ; dx-cx(ch), bx-cx(cl)
	
	; call vga_mode
	
	; xor cx, cx
	; mov dx, 100 ; 1-es oszlop kezdopoz
	; mov di, offset numbers
	; mov dx, [di]
	; mov ch, 100 ; 1-es sor kezdopoz
	
	; mov bx, 200 ; 2-es oszlop kezdopoz
	; mov cl, 150 ; 2-es sor kezdopoz
	
	; push bx ; 2-es oszlop
	; push cx ; sor
	; push dx ; 1-es oszlop
	
	; xor ax, ax
	; int 16h
	


; kirajzolas:
	; ; pixel = Y * 320 + X
	; ; pop dx
	; ; mov ax, dx
	; ; push dx
	; ; mov bx, 320
	; ; mul bx
	; ; pop dx
	; ; pop bx

	; ; push bx
	; ; push dx
	; ; add ax, bx
	; ; mov di, ax
	
	; pop dx
	; mov ax, dx ; megvan az 1es oszlop
	; push dx
	; mov bx, 320
	; mul bx ; ax-ben uj ertek
	; pop dx ; oszlop
	; pop cx ; sor
	; xor bx, bx
	; mov bl, ch
	
	; push cx
	; push dx ; uj oszlop
	; add ax, bx ; ax=ax*320 + bx
	; mov di, ax ; 
	
	; mov al, 32 ; szin beallitasa
	; mov es:[di], al ; koordinatara allunk, extra szegmenssel memoria cimre
	
	
	
	; pop cx ; 1-es oszlop
	; pop bx ; sor
	; pop dx ; 2-es oszlop
	; mov ax, dx ; megvan a 2es oszlop
	; push dx ; 2-es oszlop be
	; push bx ; sor be
	; mov bx, 320
	; mul bx ; ax-ben uj ertek 2-es sor
	; pop dx ; 2-es oszlop ki
	; pop bx ; sor ki
	; ;xor bx, bx
	; ;mov bl, ch
	
	; ;push cx
	; ;push dx ; uj oszlop
	; push dx ; 2-es oszlop be
	; push bx ; sor be
	; push cx ; 1-es oszlop be
	
	; add ax, bx ; ax=ax*320 + bx
	; mov di, ax ; 
	
	; mov al, 32 ; szin beallitasa
	; mov es:[di], al ; koordinatara allunk, extra szegmenssel memoria cimre
	
	; xor ax, ax
	; int 16h
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	; ; pixel = Y * 320 + X
	; mov di, offset jatekos_1_oszlop
	; mov dx, [di]
	; mov ax, dx
	
	; mov bx, 320
	; mul bx
	; mov di, offset jatekos_1_sor
	; mov bx, [di]
	
	; mov di, offset jatekos_1_sor
	; mov [di], bx
	; mov di, offset jatekos_1_oszlop
	; mov [di], dx
	; add ax, bx
	; mov di, ax
	
	; mov al, 32 ; szin beallitasa
	; mov es:[di], al ; koordinatara allunk, extra szegmenssel memoria cimre
	
	
	; ; ; pixel = Y * 320 + X
	; mov di, offset jatekos_2_oszlop
	; mov dx, [di]
	; mov ax, dx
	
	; mov bx, 320
	; mul bx
	; mov di, offset jatekos_2_sor
	; mov bx, [di]
	
	; mov di, offset jatekos_2_sor
	; mov [di], bx
	; mov di, offset jatekos_2_oszlop
	; mov [di], dx
	; add ax, bx
	; mov di, ax
	
	; mov al, 48 ; szin beallitasa
	; mov es:[di], al ; koordinatara allunk, extra szegmenssel memoria cimre
	
	; xor ax, ax
	; int 16h















; checkskey: ;checks if key is being pressed
  ; mov ah,1
  ; int 16h
  ; jz checkskey ;jumps if key isnt pressed
  ; mov ah,0 ;checks which key is pressed
  ; int 16h
  ; cmp ah,11h ;if key pressed is w jump to upboard
  ; je upboard1
  ; cmp ah,01fh ;if key pressed is s jump to downboard
  ; je downboard1
  ; cmp ah,050h
  ; je downboard2
  ; cmp ah,048h
  ; je upboard2
  ; jmp checkskey ;if key isnt pressed jump to check key














	; mov di, offset number
	; mov ax, [di] ; Move the 16-bit value stored in 'number' to AX
	; add ax, 10
	; mov [di], ax
	; xor di, di
	; xor ax, ax
	; mov di, offset number
	; mov ax, [di]
	; mov bx, 10 ; Set BX to 10 for division
	; mov cx, 0 ; Initialize CX to 0 for counting digits
; print_digit:
    ; mov dx, 0 ; Clear DX for division
    ; div bx ; Divide AX by BX
    ; push dx ; Push the remainder onto the stack
    ; inc cx ; Increment CX to count the number of digits
    ; test ax, ax ; Check if AX is 0
    ; jnz print_digit ; If not, continue printing digits
; print_loop:
    ; pop dx ; Pop the remainder from the stack
    ; add dl, '0' ; Convert the remainder to ASCII
    ; mov ah, 02h ; Set AH to 02h for printing a character
    ; int 21h ; Call the DOS interrupt to print the character
    ; loop print_loop ; Loop until all digits have been printed
	
	; xor ax, ax
	; int 16h
	
	;jmp Program_Vege
	
	
	
	
	
	
	
	
	
	
	
	
	



































; varakozas:
	; ;bevitel
	; xor ah, ah
	; int 16h
	
	
	; ; mov ah, 01h
	; ; int 16h
	; ; jz nincs_input ; jumps if key isnt pressed
	
	; ; ; van input
	; ; mov ah, 00h ; checks which key is pressed
	; ; int 16h
	; ; jmp van_input
	
; ; nincs_input:
	; ; mov di, offset jatekos_1_irany
	; ; mov ax, [di] ; utolso irany betoltese
	; ; jmp van_input ; betoltesre kerult az elozo irany
	
; ; van_input:
	; cmp ah, 1 ; esc scan code
	; jz jmp_Program_Vege_2
	
	; cmp ah, 14 ; backspace scan code vissza a menube
	; jz jmp_start_menu_1
	
	; cmp ah, 75 ; bal nyil scan Code
	; jz jmp_jatekos_1_balra
	
	; cmp ah, 77 ; jobb nyil scan Code
	; jz jmp_jatekos_1_jobbra
	
	; cmp ah, 72 ; fel nyil scan Code
	; jz jmp_jatekos_1_felfele
	
	; cmp ah, 80 ; le nyil scan Code
	; jz jmp_jatekos_1_lefele
	
	; cmp al, 97 ; a ascii Code
	; jz jmp_jatekos_2_balra
	
	; cmp al, 100 ; d ascii Code
	; jz jmp_jatekos_2_jobbra
	
	; cmp al, 119; w ascii code
	; jz jmp_jatekos_2_felfele
	
	; cmp al, 115 ; s ascii Code
	; jz jmp_jatekos_2_lefele
	
	; jmp varakozas ; kulonben uj bevitelt kerunk (hibas bevitel tortent)



































; DelayFunction:
    ; ; Input: CX = Number of milliseconds to delay
    ; ;MOV CX, 100 ; Set the delay value

    ; ; Convert milliseconds to timer ticks
    ; MOV AX, CX
    ; MOV BX, 18 ; 18.2 ticks per second (approximately)
    ; MUL BX     ; DX:AX = AX * BX
    ; MOV CX, AX ; Copy the result back to CX

    ; ; Get the current timer tick count
    ; MOV AH, 2CH
    ; INT 21H

    ; ; Calculate the target tick count
    ; ADD CX, DX

; DelayLoop:
    ; ; Get the current timer tick count
    ; MOV AH, 2CH
    ; INT 21H

    ; ; Compare with the target tick count
    ; CMP CX, DX
    ; JBE DelayLoop

    ; RET
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
; varakozas:
	; ; xor ah, ah
	; ; int 16h
	
	; mov ah, 01h
	; int 16h
	; jz nincs_input ; jumps if key isnt pressed
	
	; ; van input
	; mov ah, 00h ; checks which key is pressed
	; int 16h
	; jmp van_input
	
; nincs_input:
	; mov di, offset jatekos_1_irany
	; mov ax, [di] ; utolso irany betoltese
	; jmp van_input ; betoltesre kerult az elozo irany
	
; van_input:
		; call DelayFunction
	; cmp ah, 1 ; esc scan code
	; jz jmp_Program_Vege_2
	
	; cmp ah, 14 ; backspace scan code vissza a menube
	; jz jmp_start_menu_1
	
	; xor cx, cx
	; mov di, offset utolso_mozgatott_jatekos
	; mov cx, [di]
	; cmp cx, 2
	; jz jatekos_1_mozgatas
	; cmp cx, 1
	; jz jatekos_2_mozgatas
	
	; jmp varakozas

; jatekos_1_mozgatas:
	; cmp ah, 75 ; bal nyil scan Code
	; jz jmp_jatekos_1_balra
	
	; cmp ah, 77 ; jobb nyil scan Code
	; jz jmp_jatekos_1_jobbra
	
	; cmp ah, 72 ; fel nyil scan Code
	; jz jmp_jatekos_1_felfele
	
	; cmp ah, 80 ; le nyil scan Code
	; jz jmp_jatekos_1_lefele
	
	; xor cx, cx
	; mov cx, 1
	; mov di, offset utolso_mozgatott_jatekos
	; mov [di], cx
	
	; jmp varakozas
	
; jatekos_2_mozgatas:
	
	; cmp al, 97 ; a ascii Code
	; jz jmp_jatekos_2_balra
	
	; cmp al, 100 ; d ascii Code
	; jz jmp_jatekos_2_jobbra
	
	; cmp al, 119; w ascii code
	; jz jmp_jatekos_2_felfele
	
	; cmp al, 115 ; s ascii Code
	; jz jmp_jatekos_2_lefele
	
	; xor cx, cx
	; mov cx, 2
	; mov di, offset utolso_mozgatott_jatekos
	; mov [di], cx
	
	; jmp varakozas
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	;varakozas:
	;bevitel
	; xor ah, ah
	; int 16h
	
	
	; mov ah, 01h
	; int 16h
	; jz nincs_input ; jumps if key isnt pressed
	
	; ; van input
	; mov ah, 00h ; checks which key is pressed
	; int 16h
	; jmp van_input
	
; nincs_input:
	; xor ax, ax
	; mov di, offset jatekos_1_irany ; ah
	; mov cx, [di]
	; mov ah, ch ; utolso irany betoltese
	; mov di, offset jatekos_2_irany ; al
	; mov cx, [di]
	; mov al, cl
	; jmp van_input ; betoltesre kerult az elozo irany
	
; ; van_input:
	; cmp ah, 1 ; esc scan code
	; jz jmp_Program_Vege_2
	
	; cmp ah, 14 ; backspace scan code vissza a menube
	; jz jmp_start_menu_1
	
	; cmp ah, 75 ; bal nyil scan Code
	; jz jmp_jatekos_1_balra
	
	; cmp ah, 77 ; jobb nyil scan Code
	; jz jmp_jatekos_1_jobbra
	
	; cmp ah, 72 ; fel nyil scan Code
	; jz jmp_jatekos_1_felfele
	
	; cmp ah, 80 ; le nyil scan Code
	; jz jmp_jatekos_1_lefele
	
	; cmp al, 97 ; a ascii Code
	; jz jmp_jatekos_2_balra
	
	; cmp al, 100 ; d ascii Code
	; jz jmp_jatekos_2_jobbra
	
	; cmp al, 119 ; w ascii code
	; jz jmp_jatekos_2_felfele
	
	; cmp al, 115 ; s ascii Code
	; jz jmp_jatekos_2_lefele
	
	; jmp varakozas ; kulonben uj bevitelt kerunk (hibas bevitel tortent)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
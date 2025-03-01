
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov	ax, Code
	mov	DS, AX
	
	; idozites
	xor dx, dx
	push dx ; verembe tarolunk
	
	jmp start_menu

vga_mode:
	mov ax, 13h ; grafikus mod beallitasa
	int 10h
	
	mov ax, 0a000h
	mov es, ax
	xor ax, ax
	
	call vga_sarga_keret
	ret

text_mode:
	mov ax, 3h ; szoveges mod beallitasa
	int 10h
	xor ax, ax
	ret

jmp_Program_Vege_1:
	jmp Program_Vege

start_menu:
	call text_mode
	call menu_kiir
	
		start_menu_bevitel:
			xor ah, ah
			int 16h
			
			; kilepes a menubol
			cmp ah, 1 ; esc scan code
			jz jmp_Program_Vege_1
			
			cmp ah, 14 ; backspace scan code vissza a menube
			jz start_menu
			
			; jatek inditasa
			cmp ah, 28 ; enter scan code
			jz jatek_inditasa
			
			jmp start_menu_bevitel ; hibas bevitel

jatek_inditasa:
	; poziciok inicializalasa
	mov ax, 100
	mov di, offset jatekos_1_oszlop
	mov [di], ax
	
	mov di, offset jatekos_1_sor
	mov [di], ax
	
	mov ax, 0
	mov di, offset jatekos_1_oszlop_elozo
	mov [di], ax
	
	mov di, offset jatekos_1_sor_elozo
	mov [di], ax
	
	mov di, offset jatekos_1_irany
	mov [di], ax
	
	mov di, offset jatekos_2_irany
	mov [di], ax
	
	mov di, offset jatekos_2_oszlop_elozo
	mov [di], ax
	
	mov di, offset jatekos_2_sor_elozo
	mov [di], ax
	
	mov ax, 50
	mov di, offset jatekos_2_oszlop
	mov [di], ax
	
	mov di, offset jatekos_2_sor
	mov [di], ax
	
	mov di, offset utolso_mozgatott_jatekos
	mov ax, 2
	mov [di], ax
	
	call vga_mode
	
	jmp Kirajzol

jmp_jatekos_2_nyert:
	jmp jatekos_2_nyert

Kirajzol:
	; jatekos1 elozo kirajzol
	mov di, offset jatekos_1_sor_elozo
	mov dx, [di]
	mov ax, dx
	mov bx, 320
	mul bx
	mov dx, [di]
	
	mov di, offset jatekos_1_oszlop_elozo
	mov bx, [di]
	
	mov [di], bx
	mov di, offset jatekos_1_sor_elozo
	mov [di], dx
	
	add ax, bx
	mov di, ax
	
	;mov al, 40 ; piros
	mov al, 43 ; narancs
	
	mov es:[di], al
	
	; jatekos1 kirajzol
	mov di, offset jatekos_1_sor
	mov dx, [di]
	mov ax, dx
	mov bx, 320
	mul bx
	mov dx, [di]
	
	mov di, offset jatekos_1_oszlop
	mov bx, [di]
	
	mov [di], bx
	mov di, offset jatekos_1_sor
	mov [di], dx
	
	add ax, bx
	mov di, ax
	
	; jatekos1 utkozott valamivel
	mov al, 43 ; narancs
	cmp es:[di], al
	jz jmp_jatekos_2_nyert
	
	mov al, 11 ; vilagoskek
	cmp es:[di], al
	jz jmp_jatekos_2_nyert
	
	mov al, 47 ; zold
	cmp es:[di], al
	jz jmp_jatekos_2_nyert
	
	mov al, 14 ; sarga
	cmp es:[di], al
	jz jmp_jatekos_2_nyert
	; jatekos1 utkozott valamivel
	
	mov al, 40 ; piros
	;mov al, 43 ; narancs
	mov es:[di], al
	
	
	; jatekos2 elozo kirajzol
	mov di, offset jatekos_2_sor_elozo
	mov dx, [di]
	mov ax, dx
	mov bx, 320
	mul bx
	mov dx, [di]
	
	mov di, offset jatekos_2_oszlop_elozo
	mov bx, [di]
	
	mov [di], bx
	mov di, offset jatekos_2_sor_elozo
	mov [di], dx
	
	add ax, bx
	mov di, ax
	
	;mov al, 47 ; zold
	mov al, 11 ; vilagoskek
	mov es:[di], al
	
	; jatekos2 kirajzol
	mov di, offset jatekos_2_sor
	mov dx, [di]
	mov ax, dx
	mov bx, 320
	mul bx
	mov dx, [di]
	
	mov di, offset jatekos_2_oszlop
	mov bx, [di]
	
	mov [di], bx
	mov di, offset jatekos_2_sor
	mov [di], dx
	
	add ax, bx
	mov di, ax
	
	; jatekos2 utkozott valamivel
	mov al, 11 ; vilagoskek
	cmp es:[di], al
	jz jmp_jatekos_1_nyert
	
	mov al, 43 ; narancs
	cmp es:[di], al
	jz jmp_jatekos_1_nyert
	
	mov al, 40 ; piros
	cmp es:[di], al
	jz jmp_jatekos_1_nyert
	
	mov al, 14 ; sarga
	cmp es:[di], al
	jz jmp_jatekos_1_nyert
	; jatekos2 utkozott valamivel
	
	mov al, 47 ; zold
	;mov al, 11 ; vilagoskek
	mov es:[di], al
	
	jmp varakozas

jmp_jatekos_1_nyert:
	jmp jatekos_1_nyert

jmp_Program_Vege_2:
	jmp Program_Vege

jmp_start_menu_1:
	jmp start_menu

varakozas:
	;xor ax, ax
	; bevitel
	mov ah, 01h ; beker egy billentyut
	int 16h ; billentyu bekerese ax-be
	
	jz nincsbill ; ha nincs leutott billentyu
	mov ah, 00h
	int 16h ; al-be bekerul a bill
	
van_input:
	cmp ah, 1 ; esc scan code
	jz jmp_Program_Vege_2
	
	cmp ah, 14 ; backspace scan code vissza a menube
	jz jmp_start_menu_1
	
	; melyik jatekos mozgasa kovetkezhet
	mov di, offset utolso_mozgatott_jatekos
	mov cx, [di]
	cmp cx, 2
	jz jatekos_1_mozoghat
	
	cmp cx, 1
	jz jatekos_2_mozoghat
	
	jmp nincsbill
	
jatekos_1_mozoghat:
	mov di, offset utolso_mozgatott_jatekos
	mov cx, 1
	mov [di], cx
	
	cmp ah, 75 ; bal nyil scan Code
	jz jmp_jatekos_1_balra
	
	cmp ah, 77 ; jobb nyil scan Code
	jz jmp_jatekos_1_jobbra
	
	cmp ah, 72 ; fel nyil scan Code
	jz jmp_jatekos_1_felfele
	
	cmp ah, 80 ; le nyil scan Code
	jz jmp_jatekos_1_lefele
	
	jmp varakozas

jatekos_2_mozoghat:
	mov di, offset utolso_mozgatott_jatekos
	mov cx, 2
	mov [di], cx
	
	cmp al, 97 ; a ascii Code
	jz jmp_jatekos_2_balra
	
	cmp al, 100 ; d ascii Code
	jz jmp_jatekos_2_jobbra
	
	cmp al, 119 ; w ascii code
	jz jmp_jatekos_2_felfele
	
	cmp al, 115 ; s ascii Code
	jz jmp_jatekos_2_lefele
	
	jmp varakozas
	
nincsbill:
	xor ah, ah
	int 1ah ; cx:dx system time, regiszter kiterjesztes, a ket 16bites regisztert egy 32biteskent kezeli
	
	; T eltelt = Taktualis - Tregi
	
	pop cx ; regi ido cx-be, kimozgatja a verembol cx-be
	push cx ; bemasolja a verembe
	mov ax, dx ; aktualis ido mentese ax-be
	
	sub dx, cx ; Teltelt kiszamolasa a mostani - regi idobol
	push ax ; aktualis ido verembe
	
	mov al, 3 ; kesleltetes
	jmp beallit

beallit:
	xor ah, ah
	cmp dx, ax ; dx 16 bit miatt nem eleg az al
	
	pop ax ; elozo ido aktualizalasa
	
	jc varakozas ; ha meg nem telt el a megfelelo ido
	
	pop cx
	push ax
	
	; tobbi kod ami tick-enkent fog lefutni
	
	;nincs_input:
	xor ax, ax
	mov di, offset jatekos_1_irany ; ah
	mov cx, [di]
	mov ah, ch ; utolso irany betoltese
	mov di, offset jatekos_2_irany ; al
	mov cx, [di]
	mov al, cl
	jmp van_input ; betoltesre kerult az elozo irany
	
	jmp varakozas

jmp_jatekos_1_balra:
	jmp jatekos_1_balra
	
jmp_jatekos_1_jobbra:
	jmp jatekos_1_jobbra
	
jmp_jatekos_1_felfele:
	jmp jatekos_1_felfele
	
jmp_jatekos_1_lefele:
	jmp jatekos_1_lefele

jmp_jatekos_2_balra:
	jmp jatekos_2_balra

jmp_jatekos_2_jobbra:
	jmp jatekos_2_jobbra
	
jmp_jatekos_2_felfele:
	jmp jatekos_2_felfele
	
jmp_jatekos_2_lefele:
	jmp jatekos_2_lefele

jatekos_1_tarol_elozo:
	mov di, offset jatekos_1_sor_elozo
	mov [di], bx ; sor
	
	mov di, offset jatekos_1_oszlop_elozo
	mov [di], dx ; oszlop
	ret

jatekos_1_tarol:
	mov di, offset jatekos_1_sor
	mov [di], bx ; sor
	mov di, offset jatekos_1_oszlop
	mov [di], dx ; oszlop
	jmp Kirajzol

jatekos_1_balra:
	xor bx, bx
	xor dx, dx
	
	xor ax, ax
	mov di, offset jatekos_1_irany
	mov ah, 75 ; bal scan
	mov [di], ax
	
	mov di, offset jatekos_1_sor
	mov bx, [di] ; sor
	
	mov di, offset jatekos_1_oszlop
	mov dx, [di] ; oszlop
	
	call jatekos_1_tarol_elozo
	
	dec dx
	cmp dx, 0 ; 1 ha nem szabad a falra allni
	jnc jatekos_1_tarol
	inc dx
	jmp jatekos_1_tarol
	
jatekos_1_jobbra:
	xor bx, bx
	xor dx, dx
	
	xor ax, ax
	mov di, offset jatekos_1_irany
	mov ah, 77 ; jobb scan
	mov [di], ax
	
	mov di, offset jatekos_1_sor
	mov bx, [di] ; sor
	
	mov di, offset jatekos_1_oszlop
	mov dx, [di] ; oszlop
	
	call jatekos_1_tarol_elozo
	
	inc dx
	cmp dx, 320 ; 319 ha nem szabad a falra allni
	jc jatekos_1_tarol
	dec dx
	jmp jatekos_1_tarol
	
jatekos_1_felfele:
	xor bx, bx
	xor dx, dx
	
	xor ax, ax
	mov di, offset jatekos_1_irany
	mov ah, 72 ; fel scan
	mov [di], ax
	
	mov di, offset jatekos_1_sor
	mov bx, [di] ; sor
	
	mov di, offset jatekos_1_oszlop
	mov dx, [di] ; oszlop
	
	call jatekos_1_tarol_elozo
	
	dec bx
	cmp bx, 0 ; 1 ha nem szabad a falra allni
	jnc jatekos_1_tarol
	inc bx
	jmp jatekos_1_tarol
	
jatekos_1_lefele:
	xor bx, bx
	xor dx, dx
	
	xor ax, ax
	mov di, offset jatekos_1_irany
	mov ah, 80 ; le scan
	mov [di], ax
	
	mov di, offset jatekos_1_sor
	mov bx, [di] ; sor
	
	mov di, offset jatekos_1_oszlop
	mov dx, [di] ; oszlop
	
	call jatekos_1_tarol_elozo
	
	inc bx
	cmp bx, 200 ; 199 ha nem szabad a falra allni
	jc jmp_jatekos_1_tarol
	dec bx
	jmp jatekos_1_tarol
	
jmp_jatekos_1_tarol:
	jmp jatekos_1_tarol

jatekos_2_tarol_elozo:
	mov di, offset jatekos_2_sor_elozo
	mov [di], bx ; sor
	
	mov di, offset jatekos_2_oszlop_elozo
	mov [di], dx ; oszlop
	ret

jatekos_2_tarol:
	mov di, offset jatekos_2_sor
	mov [di], bx ; sor
	mov di, offset jatekos_2_oszlop
	mov [di], dx ; oszlop
	jmp Kirajzol

jatekos_2_balra:
	xor bx, bx
	xor dx, dx
	
	xor ax, ax
	mov di, offset jatekos_2_irany
	mov al, 97 ; a ascii Code
	mov [di], ax
	
	mov di, offset jatekos_2_sor
	mov bx, [di] ; sor
	
	mov di, offset jatekos_2_oszlop
	mov dx, [di] ; oszlop
	
	call jatekos_2_tarol_elozo
	
	dec dx
	cmp dx, 0 ; 1 ha nem szabad a falra allni
	jnc jatekos_2_tarol
	inc dx
	jmp jatekos_2_tarol
	
jatekos_2_jobbra:
	xor bx, bx
	xor dx, dx
	
	xor ax, ax
	mov di, offset jatekos_2_irany
	mov al, 100 ; d ascii Code
	mov [di], ax
	
	mov di, offset jatekos_2_sor
	mov bx, [di] ; sor
	
	mov di, offset jatekos_2_oszlop
	mov dx, [di] ; oszlop
	
	call jatekos_2_tarol_elozo
	
	inc dx
	cmp dx, 320 ; 319 ha nem szabad a falra allni
	jc jatekos_2_tarol
	dec dx
	jmp jatekos_2_tarol
	
jatekos_2_felfele:
	xor bx, bx
	xor dx, dx
	
	xor ax, ax
	mov di, offset jatekos_2_irany
	mov al, 119 ; w ascii code
	mov [di], ax
	
	mov di, offset jatekos_2_sor
	mov bx, [di] ; sor
	
	mov di, offset jatekos_2_oszlop
	mov dx, [di] ; oszlop
	
	call jatekos_2_tarol_elozo
	
	dec bx
	cmp bx, 0 ; 1 ha nem szabad a falra allni
	jnc jatekos_2_tarol
	inc bx
	jmp jatekos_2_tarol
	
jatekos_2_lefele:
	xor bx, bx
	xor dx, dx
	
	xor ax, ax
	mov di, offset jatekos_2_irany
	mov al, 115 ; s ascii Code
	mov [di], ax
	
	mov di, offset jatekos_2_sor
	mov bx, [di] ; sor
	
	mov di, offset jatekos_2_oszlop
	mov dx, [di] ; oszlop
	
	call jatekos_2_tarol_elozo
	
	inc bx
	cmp bx, 200 ; 199 ha nem szabad a falra allni
	jc jmp_jatekos_2_tarol
	dec bx
	jmp jatekos_2_tarol

jmp_jatekos_2_tarol:
	jmp jatekos_2_tarol

vga_sarga_keret:
	mov cx, 200
keret_bal:
	mov ax, cx
	mov bx, 320
	mul bx
	mov bx, 0
	;mov dx, cx
	
	add ax, bx
	mov di, ax
	
	mov al, 14 ; sarga
	mov es:[di], al
	
	loop keret_bal
	
	mov cx, 200
keret_jobb:
	mov ax, cx
	mov bx, 320
	mul bx
	mov bx, 319
	;mov dx, cx
	
	add ax, bx
	mov di, ax
	
	mov al, 14 ; sarga
	mov es:[di], al
	
	loop keret_jobb
	
	mov cx, 320
keret_felso:
	mov ax, 0
	mov bx, 320
	mul bx
	mov bx, cx
	;mov dx, 0
	
	add ax, bx
	mov di, ax
	
	mov al, 14 ; sarga
	mov es:[di], al
	
	loop keret_felso
	
	mov cx, 320
keret_also:
	mov ax, 199
	mov bx, 320
	mul bx
	mov bx, cx
	;mov dx, 199
	
	add ax, bx
	mov di, ax
	
	mov al, 14 ; sarga
	mov es:[di], al
	
	loop keret_also
	ret

menu_kiir:
	mov ax, 03h ; kepernyo torol
	int 10h
	
	mov ah, 02h ; kurzor pozicional
	mov bh, 0
	mov dh, 10 ; sor
	mov dl, 10 ; oszlop
	int 10h
	
	mov dx, offset start_menu_inditas
	mov ah, 09h
	int 21h
	
	mov ah, 02h ; kurzor pozicional
	mov bh, 0
	mov dh, 15 ; sor
	mov dl, 10 ; oszlop
	int 10h
	
	mov dx, offset start_menu_kilepes
	mov ah, 09h
	int 21h
	
	mov ah, 02h ; kurzor pozicional
	mov bh, 0
	mov dh, 20 ; sor
	mov dl, 10 ; oszlop
	int 10h
	
	mov dx, offset start_menu_vissza
	mov ah, 09h
	int 21h
	
	ret

jatekos_1_nyert:
	call text_mode
	call menu_kiir
	mov ah, 02h ; kurzor pozicional
	mov bh, 0
	mov dh, 5 ; sor
	mov dl, 10 ; oszlop
	int 10h
	
	mov dx, offset start_menu_jatekos_1_nyert
	mov ah, 09h
	int 21h
	
	mov ah, 02h ; kurzor pozicional
	mov bh, 0
	mov dh, 23 ; sor
	mov dl, 10 ; oszlop
	int 10h
	
	mov dx, offset start_menu_folytatas
	mov ah, 09h
	int 21h
	
	jmp jatekos_nyert_bevitel_var
	
jatekos_2_nyert:
	call text_mode
	call menu_kiir
	mov ah, 02h ; kurzor pozicional
	mov bh, 0
	mov dh, 5 ; sor
	mov dl, 10 ; oszlop
	int 10h
	
	mov dx, offset start_menu_jatekos_2_nyert
	mov ah, 09h
	int 21h
	
	mov ah, 02h ; kurzor pozicional
	mov bh, 0
	mov dh, 23 ; sor
	mov dl, 10 ; oszlop
	int 10h
	
	mov dx, offset start_menu_folytatas
	mov ah, 09h
	int 21h
	
	jmp jatekos_nyert_bevitel_var

jatekos_nyert_bevitel_var:
	xor ah, ah
	int 16h
	
	cmp ah, 1 ; esc scan Code
	jz Program_Vege
	cmp ah, 57 ; space scan Code
	jz jmp_start_menu_2
	jmp jatekos_nyert_bevitel_var

jmp_start_menu_2:
	jmp start_menu

Program_Vege:
	pop cx
	
	mov ax, 03h
	int 10h
	
	mov	ax, 4c00h
	int	21h

start_menu_inditas:
	db "Jatek inditasa - Enter$"

start_menu_kilepes:
	db "Kilepes a programbol - ESC$"

start_menu_vissza:
	db "Vissza a menube - Backspace$"

start_menu_jatekos_1_nyert:
	db "Jatekos 1 nyert$"

start_menu_jatekos_2_nyert:
	db "Jatekos 2 nyert$"
	
start_menu_folytatas:
	db "Folytatashoz nyomjon Space-t$"

jatekos_1_oszlop dw 0
jatekos_1_oszlop_elozo dw 0
jatekos_1_sor dw 0
jatekos_1_sor_elozo dw 0
jatekos_1_irany dw 0

jatekos_2_oszlop dw 0
jatekos_2_oszlop_elozo dw 0
jatekos_2_sor dw 0
jatekos_2_sor_elozo dw 0
jatekos_2_irany dw 0

utolso_mozgatott_jatekos dw 2

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

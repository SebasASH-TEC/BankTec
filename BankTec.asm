org 100h

jmp inicio


;Constantes
MAX_CUENTAS equ 10   ; Se utilizan los registros al, bl, etc para 8 bits, y ax, bx para 16 bits, no son intercambiables tan facil
SIZE_CUENTA equ 4
NUMERO equ 0
SALDO  equ 2   
           
;Variables           
cuentas db MAX_CUENTAS * SIZE_CUENTA dup(0)
contadorCuentas db 0
numeroCuenta dw ?
monto dw ?
indiceCuenta dw ?   



;Mensajes
menu db 13,10,"===== SISTEMA BANCARIO =====",13,10
     db "1. Crear cuenta",13,10
     db "2. Depositar",13,10
     db "3. Retirar",13,10
     db "4. Consultar saldo",13,10
     db "5. Reporte general",13,10
     db "6. Desactivar cuenta",13,10
     db "7. Salir",13,10
     db "Seleccione una opcion: $"

msgCrear db 13,10,"Ingrese numero de cuenta: $"
msgGuardado db 13,10,"Cuenta creada correctamente.$"
msgBancoLleno db 13,10,"No se pueden crear mas cuentas.$"

msgDepositoCuenta db 13,10,"Numero de cuenta: $"
msgMonto db 13,10,"Monto a depositar: $"
msgNoExiste db 13,10,"Cuenta no encontrada.$"
msgDepositoOK db 13,10,"Deposito realizado.$"
msgReporte db 13,10,"xd$"
msgDesactivar db 13,10,"xd$"
msgYaExiste db 13,10,"El numero de cuenta ya esta registrado.$"
msgMontoDebitar db 13,10,"Monto a retirar: $"
msgDebitoOK db 13,10,"Retiro realizado.$"
msgDebitoNo db 13,10,"No hay plata papi.$"


inicio:

menu_loop:

    call MostrarMenu
    call LeerOpcion

    cmp al,'1'
    je opcion1

    cmp al,'2'
    je opcion2

    cmp al,'3'
    je opcion3

    cmp al,'4'
    je opcion4

    cmp al,'5'
    je opcion5

    cmp al,'6'
    je opcion6

    cmp al,'7'
    je salir

    jmp menu_loop


;Opciones del menu
opcion1:
    call CrearCuenta
    jmp menu_loop

opcion2:
    call Depositar
    jmp menu_loop

opcion3:
    call Debitar
    jmp menu_loop

opcion4:
    call ConsultarSaldo
    jmp menu_loop

opcion5:
    mov dx, offset msgReporte
    call print
    jmp menu_loop

opcion6:
    mov dx, offset msgDesactivar
    call print
    jmp menu_loop



CrearCuenta proc    ; proc es codigo reutilizable, y debe terminar con el endp. Se refiere a que son funciones que otra 
                    ; funcion puede llamar
    mov al, contadorCuentas
    cmp al, MAX_CUENTAS
    je banco_lleno

    mov dx, offset msgCrear
    call print

    call LeerNumero
    mov numeroCuenta, ax 
    
    call BuscarCuenta
    jnc cuenta_ya_existe ;salta si no hay acarreo o sea se encontro ya la cuenta

    mov bx,0
    mov bl,contadorCuentas
    mov ax,SIZE_CUENTA
    mul bx
    mov si,ax
    add si,offset cuentas

    mov ax,numeroCuenta
    mov [si + NUMERO],ax

    mov word ptr [si + SALDO],0

    inc contadorCuentas

    mov dx, offset msgGuardado
    call print

    ret
    
cuenta_ya_existe:
    mov dx, offset msgYaExiste
    call print
    ret

banco_lleno:
    mov dx, offset msgBancoLleno
    call print
    ret

CrearCuenta endp



MostrarMenu proc
    mov dx, offset menu
    call print
    ret
MostrarMenu endp


LeerOpcion proc
    mov ah,01h
    int 21h
    ret
LeerOpcion endp


print proc        ; Yipi
    mov ah,09h    ; Hice un print para strings que terminan en $
    int 21h       ; Porque que pereza repetir ese codigo xd
    ret
print endp

BuscarCuenta proc

    xor cx,cx        ; El XOR es para poder guardar algo que estaba en cx (16 bits) en un registro de 8
    mov cl,contadorCuentas
    cmp cx,0
    je no_encontrada

    mov si, offset cuentas

buscar_loop:

    mov ax, [si + NUMERO]
    cmp ax, numeroCuenta
    je encontrada

    add si, SIZE_CUENTA
    loop buscar_loop   ; Loop es un cmp cx con 0, luego dec cx en -1, y luego hace jmp a lo que usted le especifique

no_encontrada:
    stc
    ret

encontrada:
    clc
    ret

BuscarCuenta endp

Depositar proc       ; La funcion esta es super basica, pero no se que restricciones poner
                     ; Acepta decimales, pero como aun no hay consulta de saldo no se si si sirve xd
    mov dx, offset msgDepositoCuenta
    call print

    call LeerNumero
    mov numeroCuenta,ax

    call BuscarCuenta
    jc call CuentaNoExiste

    mov dx, offset msgMonto
    call print

    call LeerNumero
    mov monto,ax

    mov ax,[si + SALDO]
    add ax,monto
    mov [si + SALDO],ax

    mov dx, offset msgDepositoOK
    call print
    ret


Depositar endp  

Debitar proc          ; aqui trato de hacer la funcion de debitar, en teoria valida que exista la cuenta
                      ; luego valida que el saldo no sea menor al monto que se quiera debitar
    
    mov dx, offset msgDepositoCuenta
    call print

    call LeerNumero
    mov numeroCuenta,ax

    call BuscarCuenta
    jc call CuentaNoExiste

    mov dx, offset msgMontoDebitar
    call print

    call LeerNumero
    mov monto,ax
    
    mov ax,[si + SALDO]
    cmp ax,monto                      ; si la plata que uno quiere sacar es menor al saldo da errorsh
    jb saldo_no_hay
    
    sub ax,monto
    mov [si + SALDO],ax

    mov dx, offset msgDebitoOK
    call print
    ret
    
    saldo_no_hay:
    mov dx, offset msgDebitoNo
    call print
    ret 
       
Debitar endp 

ConsultarSaldo proc      ;no funciona  100
    
    mov dx, offset msgDepositoCuenta
    call print

    call LeerNumero
    mov numeroCuenta,ax

    call BuscarCuenta
    jc call CuentaNoExiste
    
    ;mov dx,[si + SALDO]
    ;call print
    ret
     
ConsultarSaldo endp

LeerNumero proc       ; Tiene que leer cada digito por aparte, porque sino la consola solo acepta un digito
                      ; Y para combinarlo la tecnica de multiplicar por 10 y sumarle el anterior, y asi escala unidades, decenas, etc

    xor bx,bx        ; bx va a ser el numero final porque leer el teclado destruye ax

leer_loop:

    mov ah,01h
    int 21h          ; ah, 01h lee el caracter y lo guarda en al

    cmp al,13        ; enter termina de escribir el numero (Es 13 en ascii)
    je fin_lectura

    sub al,'0'       ; Traduce del ascii a numero
    mov cl,al        ; Es necesario porque el input del teclado asm lo ve como ascii
                     ; Entonces digamos, ascii empieza en 48 (El 0 en ascii es 48), entonces al numero que me da el teclado
    xor ch,ch        ; Le resto 48, limpio la parte alta, y con eso tengo el numero real guardado en cx
    
    mov ax,bx        ; Saco el numero que tenia acumulado de bx hacia ax
    mov dx,10        ; 
    mul dx           ; AX = AX * 10 

    add ax,cx        ; AX = AX + digito nuevo (Que estaba esperando en cx)
    mov bx,ax        ; Vuelvo a meter el numero ya sumado a bx

    jmp leer_loop

fin_lectura:

    mov ax,bx        ; Al final muevo todo de bx a ax 
    ret

LeerNumero endp
                 
                 
CuentaNoExiste proc ; Manda el mensaje que no existe la cuenta Isaac estaria orgulloso de mi
    
    mov dx, offset msgNoExiste
    call print
    ret 
      
CuentaNoExiste endp      

salir:
    mov ah,4Ch
    int 21h
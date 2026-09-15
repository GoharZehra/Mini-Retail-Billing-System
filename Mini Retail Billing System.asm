.MODEL SMALL
.STACK 100H
.DATA

; -------- ITEM NAMES --------
item1 db '1. Apple ','$'
item2 db '2. Banana ','$'
item3 db '3. Milk ','$'
item4 db '4. Bread ','$'
item5 db '5. Eggs ','$'

itemNames dw offset item1, offset item2, offset item3, offset item4, offset item5
prices db 2, 1, 5, 3, 4

; -------- MESSAGES --------
menuMsg db '===== SHOP MENU =====','$'
sepLine db '---------------------','$'
askItem db 'Select (1-5), 0=done: ','$'
askQty db 'Enter quantity (1-9): ','$'

badInput db 'Invalid! Try again.','$'
fullMsg db 'Cart is full!','$'
invHdr db '===== INVOICE =====','$'
invCol db 'Item Qty Price Tot','$'
invSep db '---------------------','$'
gtMsg db 'Grand Total:RS ','$'
thankStr db 'Thank you!','$'
nlStr db 13,10,'$'
qStr db 'Q: ','$'
pStr db 'P: ','$'
tStr db 'T: ','$'
rsStr db ' rs','$'

; -------- VARS --------
choice db 0
qty db 0
itemTotal db 0
grandTotal db 0
cartIndex db 0

numH db 0
numT db 0
numU db 0

; -------- CART --------
cartItem db 10 dup(0)
cartQty db 10 dup(0)
cartTotal db 10 dup(0)

.CODE

MAIN PROC
MOV AX, @DATA
MOV DS, AX

;================================================
MENU_LOOP:
;================================================

LEA DX, nlStr
MOV AH, 09H
INT 21H

LEA DX, menuMsg
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

LEA DX, sepLine
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

MOV SI, 0
MOV DI, 0

PRINT_LOOP:
CMP DI, 5
JGE DONE_PRINT

MOV DX, itemNames[SI]
MOV AH, 09H
INT 21H

MOV BX, DI
MOV AL, prices[BX]
ADD AL, '0'
MOV DL, AL
MOV AH, 02H
INT 21H

LEA DX, rsStr
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

ADD SI, 2
INC DI

JMP PRINT_LOOP

DONE_PRINT:

LEA DX, sepLine
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

;================================================
; GET ITEM CHOICE
;================================================
LEA DX, askItem
MOV AH, 09H
INT 21H

MOV AH, 01H
INT 21H
SUB AL, '0'
MOV choice, AL

CMP AL, 0
JE SHOW_INVOICE

CMP AL, 1
JL BAD_ITEM

CMP AL, 5
JG BAD_ITEM

MOV BL, cartIndex
CMP BL, 10
JGE CART_FULL

JMP GET_QTY

BAD_ITEM:
LEA DX, nlStr
MOV AH, 09H
INT 21H
LEA DX, badInput
MOV AH, 09H
INT 21H
LEA DX, nlStr
MOV AH, 09H
INT 21H
JMP MENU_LOOP

CART_FULL:
LEA DX, nlStr
MOV AH, 09H
INT 21H
LEA DX, fullMsg
MOV AH, 09H
INT 21H
LEA DX, nlStr

MOV AH, 09H
INT 21H
JMP SHOW_INVOICE

;================================================
; GET QUANTITY
;================================================
GET_QTY:
LEA DX, nlStr
MOV AH, 09H
INT 21H

LEA DX, askQty
MOV AH, 09H
INT 21H

MOV AH, 01H
INT 21H
SUB AL, '0'

CMP AL, 1
JL BAD_QTY
CMP AL, 9
JG BAD_QTY

MOV qty, AL
JMP DO_CALC

BAD_QTY:

LEA DX, nlStr
MOV AH, 09H
INT 21H
LEA DX, badInput
MOV AH, 09H
INT 21H
LEA DX, nlStr
MOV AH, 09H
INT 21H
JMP MENU_LOOP

;================================================
; CALCULATE
;================================================
DO_CALC:
MOV AL, choice
DEC AL
MOV BH, 0
MOV BL, AL
MOV AL, prices[BX]

MOV BL, qty
MUL BL

MOV itemTotal, AL

MOV AL, grandTotal
ADD AL, itemTotal
MOV grandTotal, AL

MOV BL, cartIndex
MOV BH, 0
MOV SI, BX

MOV AL, choice
MOV cartItem[SI], AL

MOV AL, qty
MOV cartQty[SI], AL

MOV AL, itemTotal
MOV cartTotal[SI], AL

INC cartIndex
JMP MENU_LOOP

;================================================
; INVOICE
;================================================
SHOW_INVOICE:

LEA DX, nlStr
MOV AH, 09H
INT 21H

LEA DX, invHdr
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

LEA DX, invCol
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

LEA DX, invSep
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

MOV BL, cartIndex
MOV BH, 0
MOV CX, BX
MOV SI, 0

CMP CX, 0
JE PRINT_GT

INV_LOOP:
PUSH CX

; --- item name ---
MOV BL, cartItem[SI]
DEC BL
MOV BH, 0
SHL BX, 1
MOV DX, itemNames[BX]
MOV AH, 09H
INT 21H

; --- Q: qty ---
LEA DX, qStr
MOV AH, 09H
INT 21H

MOV AL, cartQty[SI]
ADD AL, '0'
MOV DL, AL
MOV AH, 02H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

; --- P: price ---
LEA DX, pStr

MOV AH, 09H
INT 21H

MOV BL, cartItem[SI]
DEC BL
MOV BH, 0
MOV AL, prices[BX]
ADD AL, '0'
MOV DL, AL
MOV AH, 02H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

; --- T: item total ---
LEA DX, tStr
MOV AH, 09H
INT 21H

MOV AL, cartTotal[SI]
AAM
MOV numT, AH
MOV numU, AL

MOV DL, numT
ADD DL, '0'
MOV AH, 02H

INT 21H

MOV DL, numU
ADD DL, '0'
MOV AH, 02H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

LEA DX, invSep
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

POP CX
INC SI
LOOP INV_LOOP

;================================================
; GRAND TOTAL
;================================================
PRINT_GT:

LEA DX, gtMsg

MOV AH, 09H
INT 21H

MOV AL, grandTotal
MOV AH, 0
MOV BL, 100
DIV BL
MOV numH, AL
MOV AL, AH
AAM
MOV numT, AH
MOV numU, AL

; print hundreds if > 0
MOV AL, numH
CMP AL, 0
JE SKIP_H
ADD AL, '0'
MOV DL, AL
MOV AH, 02H
INT 21H

SKIP_H:
MOV AL, numT
CMP AL, 0
JNE PRINT_T
MOV AL, numH
CMP AL, 0
JE SKIP_T

MOV DL, '0'
MOV AH, 02H
INT 21H
JMP PRINT_U

PRINT_T:
MOV AL, numT
ADD AL, '0'
MOV DL, AL
MOV AH, 02H
INT 21H

SKIP_T:
PRINT_U:
MOV AL, numU
ADD AL, '0'
MOV DL, AL
MOV AH, 02H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

LEA DX, invSep
MOV AH, 09H
INT 21H

LEA DX, nlStr

MOV AH, 09H
INT 21H

LEA DX, thankStr
MOV AH, 09H
INT 21H

LEA DX, nlStr
MOV AH, 09H
INT 21H

;================================================
EXIT_PROGRAM:
MOV AH, 4CH
INT 21H

MAIN ENDP
END MAIN
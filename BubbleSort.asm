;Bubble Sort algorithm
;CIS 11
;Andrew Lemus, Jaqueline Gastelum, Ezequiel Hernandez, Joon Im
;R0  File item
;R1  File item
;R2  Work variable
;R3  File pointer
;R4  Outer loop counter
;R5  Inner loop counter
    
.ORIG   x3000

ARRAY .FILL x5000
;Count the number of items to be sorted and store the value in R7
	LD 	R2, COUNTER
	LEA	R1, ARRAY1
	LD 	R4, COUNTER2
DO_WHILE_LOOP
	GETC
	STR	R0, R1, #0
	ADD	R1, R1, #1
	ADD	R2, R2, #-1
	BRp DO_WHILE_LOOP
END_DO_WHILE_LOOP
	LEA	R3, ARRAY2
HALT
;local data
ARRAY2 .BLKW #10
COUNTER .FILL #10
NEWLINE .STRINGZ "/n"
COUNTER2 .FILL #10

	LEA	R0, NUM
	ADD	R1, R1, R0
	LD	R2, ASCII
FOR_LOOP
	LDR	R4, R1, #0
	BRz	END_LOOP
	ADD	R4, R4, R2
	STR	R4, R1, #0
	ADD	R1, R1, #1
	BRnzp	FOR_LOOP
END_LOOP
PUTS
HALT
ASCII	.fill x30
NUM	.fill x01
	.fill x02
	.fill x03
	.fill x04
HALT

	AND     R2, R2, #0	; Initialize R2 = 0 (counter)
	LD      R3, FILE  	; Put file pointer into R3
COUNT	LDR     R0, R3, #0	; Put next file item into R0
	BRZ     END_COUNT	; Loop until file item is 0
	ADD     R3, R3, #1	; Increment file pointer
	ADD     R2, R2, #1	; Increment counter
	BRNZP   COUNT		; Counter loop
END_COUNT	ADD     R4, R2, #0  ; Store total items in R4 (outer loop count)
	BRZ     SORTED		; Empty file

;Do the bubble sort
OUTERLOOP	ADD     R4, R4, #-1	; loop n - 1 times
	BRNZ    SORTED     	; Looping complete, exit
	ADD     R5, R4, #0  ; Initialize inner loop counter to outer
	LD      R3, FILE    ; Set file pointer to beginning of file
INNERLOOP   	LDR     R0, R3, #0  ; Get item at file pointer
	LDR     R1, R3, #1  ; Get next item
	NOT     R2, R1      ; clear register
	ADD     R2, R2, #1  ;        ... next item
	ADD     R2, R0, R2  ; swap = item - next item
	BRNZ    SWAPPED     ; Don't swap if in order (item <= next item)
	STR     R1, R3, #0  ; Perform ...
	STR     R0, R3, #1  ;         ... swap
SWAPPED     	ADD     R3, R3, #1  ; Increment file pointer
            	ADD     R5, R5, #-1 ; Decrement inner loop counter
	BRP     INNERLOOP   ; End of inner loop
	BRNZP   OUTERLOOP   ; End of outer loop
SORTED     	HALT

FILE	.FILL   x3500       ; File location
	.END

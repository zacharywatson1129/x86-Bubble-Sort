.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
vals dd 4, 1, 8, 2, 5, 3, 7, 0, -1, 6
      ;-1, 0, 1, 2, 3, 4, 5, 6, 7, 8
sz dd LENGTHOF vals
outterCount dd 0
innerCount dd 0
count dd 0
temp dd 0
temp2 dd 0
temp3 dd 0
max dd 1
four dd 4

.code
main PROC
	; max is SIZE - 1
	mov eax, sz
	dec eax
	mov max, eax
	xor eax, eax ; reset EAX
	jmp outterLoop

outterLoop:
	mov edx, max
	cmp outterCount, edx 
	JE exitProgram ; stop program if outer loop has reached max
	; otherwise, continue on
	mov innerCount, 0
	jmp innerLoop

innerLoop:
	mov edx, max
	cmp innerCount, edx 
	JE resetAndJumpToOuter ; return to outerLoop
	; otherwise, continue on.

	; Let's use eax for index innerCount.
	; Let's use ebx for index innerCount + 1.
	; Let's use ecx for value at eax.
	; Let's use edx for value at ebx.
	mov eax, innerCount ; we have to use eax to access vals array
	mul four
	mov ebx, eax
	add ebx, 4
	mov ecx, vals[eax] ; value at index eax is ecx
	mov edx, vals[ebx] ; value at index ebx is edx
	cmp ecx, edx ; inner if statement...magic of it all
	jg swap
	inc innerCount
	jmp innerLoop

resetAndJumpToOuter:
	inc outterCount
	jmp outterLoop

swap:
	mov vals[eax], edx
	mov vals[ebx], ecx
	inc innerCount
	jmp innerLoop

exitProgram:
INVOKE ExitProcess,0
main ENDP
END main

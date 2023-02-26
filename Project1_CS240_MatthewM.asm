# Matthew Murillo	CS240		2/5/2021	Project 1

.data 
Prompt: .asciiz 	"\n Please input a value of N = "
Result: .asciiz 	"The sum of the integers from 1 to N is "
Bye:    .asciiz	 	"\n ***Thanks for trying! Adios!***"
	.globl		main
	.text
main:	
	li	$v0, 4 		# system call code for Print String
	la 	$a0, Prompt 	# load address of Prompt into $a0 
	syscall			# print the Prompt statement
	li	$v0, 5		# system call code for Read Integer
	syscall			# read inputed number N into $v0
	blez	$v0, End	# If N is below 0, end the program by branching to End
	li 	$t0 , 0		# clear register $t0 to be 0

Loop:
	add 	$t0, $t0, $v0	# add the integers and store it to sum $t0
	addi	$v0, $v0, -1	# summing of the integers in reverse by subtracting by 1
	bnez	$v0, Loop	# if $v0 equals to 0, then we have finished summing up the integers
	
	li 	$v0, 4		# system call for Print String
	la	$a0, Result	# load address of Result to $a0
	syscall			# print the Result statement
	
	li	$v0, 1		# system call for Print Integer
	move	$a0, $t0	# transfer integer from $t0 to $a0 to be printed
	syscall			# print out the sum, $a0
	b	main		# branch back to main
	
End: 
	li 	$v0, 4		# system call for Print String
	la	$a0, Bye	# load address of Bye to $a0
	syscall			# print the Bye statement
	li 	$v0, 10		# terminate program run
	syscall			#return control to system
	

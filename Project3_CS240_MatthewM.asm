# Project 3	Matthew Murillo		5-3-21		CS240
.data
prompt: .asciiz "Please enter a 4 letter word: "
result: .asciiz "\nThe reversed word you entered is: "
input: .space 5	#allocate space for the input
output: .space 5#allocate space for the output

#########################################################################
# Description: The user would input a word that is 4 letters long	#
# then the inputed word would be reversed by manipulating the letters	#
# in the stack by reversing the order then printing it to the user.	#										    	
#########################################################################

.text
#read in the word inputed by the user
li 	$v0 	4	#system call code for print string
la 	$a0 	prompt	#load address of prompt to $a0
syscall			#print the prompt statement

li 	$v0 	8	#system call code for read string
li 	$a1 	5	#input size of input, which is n-1, to $a1
la 	$a0 	input	#load address of input to $a0
syscall			#user inputs string

lb 	$t0 	0($a0)	#load first letter to $t0
lb 	$t1 	1($a0)	#load second letter to $t1
lb 	$t2 	2($a0)	#load third letter to $t2
lb 	$t3 	3($a0)	#load fourth letter to $t3

#pushing letters to byte backwards because of little endians
addi 	$sp 	$sp -4	#allocate 4 byte in the stack
sb 	$t3 	0($sp)	#store forth letter to first allocated byte
sb 	$t2 	1($sp)	#store third letter to second allocated byte
sb 	$t1 	2($sp)	#store second letter to third allocated byte
sb 	$t0 	3($sp)	#store first letter to fourth allocated byte

#pop out word from the stack
lw 	$t4 	0($sp)	#load the word from stack to $t4
addi 	$sp 	$sp 4	#add 4 to the stack to (pop out) the word
sw 	$t4 	output	#store the word from $t4 to output

#print result of the reversed word
li 	$v0 	4	#system call code for print string
la 	$a0 	result	#load address of result to $a0
syscall			#print result statement

li 	$v0 	4	#system call code for print string
la 	$a0 	output	#load address of output to $a0
syscall			#print the reversed word

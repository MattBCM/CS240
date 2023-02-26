# Matthew Murillo	CS240		4/3/2021	Project 2

.data 
Prompt: .asciiz 	"\nPlease input a value of N = "
Result: .asciiz 	"\nThe sum of the integers from 1 to N is "
fpnum:	.asciiz 	"Floating point number detected! Changed to integer: "
Bye:    .asciiz	 	"\n***Thanks for trying! Adios!***"
	.globl		main
	.text
	
#######################################################################
# $s3 = Exponent							#
# $s4 = if >= 0, then number inputed is a fraction, else its not	#
# $s5 = integer that's been converted					#
#									#
# Description: Program reads in a floating point and is converted	#
# to an integer to get it's sum. To do this we manipulate the 		#
# binary numbers to get the required components to get the integer.	#										    	
#######################################################################

main:	
	li	$v0, 4 		# system call code for Print String
	la 	$a0, Prompt 	# load address of Prompt into $a0 
	syscall			# print the Prompt statement
	li	$v0, 6		# system call code for Read Float
	syscall			# read inputed number N into $v0
	li 	$t0 , 0		# clear register $t0 to be 0
	
#Conversion 	
	mfc1	$t1, $f0	# moving floating number from $f0 to $t1
	blez	$t1, End	#If it's less than or equal to 0, then branch to Bye, ending the program.
	srl	$t2, $t1, 23	# shifts to get rid of signif; stores it to $t2
	
	add 	$s3, $t2, -127 # $s3 becomes the exponent when subtracted from 127
	
	sll	$t4, $t1, 9	# shift the float by 9 to get rid of exponent and sign bit
	srl	$t5, $t4, 9	# shift back 9 to get "0" bits in once were the exponent and sign
	add	$t6, $t5, 8388608 # add in the implied bit to the significand
	add	$t7, $s3, 9	# add 9 to the exponent
	sllv	$s4, $t6, $t7	# left shift 9 + expnt to get the fractional portion. If this not equal to 0, then the number is a fraction.
	
	rol 	$t4, $t6, $t7	#Rotate left to get the integer of the right most bit
	
	li 	$t5, 31		
	sub 	$t2, $t5, $s3	#$t2 becomes the shift value
	sllv	$t5, $t4, $t2	#left shift to take out the fraction part
	srlv	$s5, $t5, $t2	#bring back the bits to be "0"
	move	$v1, $s5	#move the integer from $s5 to $v0 to start getting the sum
	
	bnez	$s4, float	# if $s4 is not zero, then we branch to float
	
Loop:
	add 	$t0, $t0, $v1	# add the integers and store it to sum $t0
	addi	$v1, $v1, -1	# summing of the integers in reverse by subtracting by 1
	bnez	$v1, Loop	# if $v1 equals to 0, then we have finished summing up the integers
	
	li 	$v0, 4		# system call for Print String
	la	$a0, Result	# load address of Result to $a0
	syscall			# print the Result statement
	
	li	$v0, 1		# system call for Print Integer
	move	$a0, $t0	# transfer integer from $t0 to $a0 to be printed
	syscall			# print out the sum, $a0
	b	main		# branch back to main
	
float:
	li	$v0, 4		# system call for Print String
	la	$a0, fpnum	# load address of fpnum to $a0
	syscall			# prints the floating num statement
	
	li 	$v0, 1		# system call for Print Integer
	move	$a0, $s5	# move the integer from $s5 to $a0
	syscall			# prints the integer
	b	Loop		# branch back to the Loop
			
End: 
	li 	$v0, 4		# system call for Print String
	la	$a0, Bye	# load address of Bye to $a0
	syscall			# print the Bye statement
	li 	$v0, 10		# terminate program run
	syscall			#return control to system
	

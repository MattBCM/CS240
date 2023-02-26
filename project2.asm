.data 
Prompt: .asciiz 	"\nPlease input N = "
Result: .asciiz 	"\nThe sum of the integers is "
float:	.asciiz 	"Floating number, number is now:  "
Bye:    .asciiz	 	"\nAdios!***"
	.globl		main
	.text
	

main:	
	li	$v0, 4 		
	la 	$a0, Prompt 
	syscall				#Prints integer
	li	$v0, 6		
	syscall				#Enter a floating point
	li 	$t0 , 0		
		
# beginning of conversion
	mfc1	$t1, $f0		#move floating point to $t1
	blez	$t1, End	
	srl	$t2, $t1, 23	
	
	subi 	$s3, $t2, 127 		#subtract 127 from t2 to get exponent, $s3
	
	sll	$t4, $t1, 9	
	srl	$t5, $t4, 9		#shift left and right to get the significand

	add	$t6, $t5, 8388608   	#add implied bit
	add	$t7, $s3, 9		#add in 9 to exponent
	sllv	$s4, $t6, $t7		#left shift 9+exponent to get fractional portion
	
	rol 	$t4, $t6, $t7		#rotate to get right most bit
	
	li 	$t5, 31			#load in 31 to t5
	sub 	$t2, $t5, $s3	
	sllv	$t5, $t4, $t2	
	srlv	$s5, $t5, $t2		#shift bits to take out fractional portion
	move	$v1, $s5		#move integer to v1
	
	bnez	$s4, Float		#if s4 != 0, branch to float
	
Loop:
	add 	$t0, $t0, $v1		#add the integer to t0
	addi	$v1, $v1, -1		#subtract by 1
	bnez	$v1, Loop		# if v1 = 0, then branch to end
	
	li 	$v0, 4			#num for print string
	la	$a0, Result		#store address of Result to a0
	syscall				#print result
		
	li	$v0, 1			#num for print integer
	move	$a0, $t0		#move number from t0 to a0
	syscall				#print a0
	b	main			#branch back to main
	
Float:
	li	$v0, 4			
	la	$a0, float	
	syscall				#print to the user that number changed from floating to integer
	
	li 	$v0, 1			#print number
	move	$a0, $s5		
	syscall				#print the number that it changed to
	b	Loop			#branch to loop
			
End: 
	li 	$v0, 4		
	la	$a0, Bye	
	syscall				#print End prompt
	li 	$v0, 10		
	syscall				#end program
	

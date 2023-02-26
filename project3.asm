.data
Enter: .asciiz "Please enter a 4-letter word: "
Result: .asciiz "\nThe reversed word is: "
Input: .space 5#allocate
Output: .space 5#allocate

.text

li $v0 4	
la $a0 Enter	
syscall	#prints the Enter statement

li $v0 8	
li $a1 5
la $a0 Input
syscall	#the person inputs a 4 letter word to the program

#load each latter to seperate registers
lb $t0 0($a0)	
lb $t1 1($a0)	
lb $t2 2($a0)	
lb $t3 3($a0)	

#puttingg letters to stack
addi $sp $sp -4	#allocate 4 byte in the stack
sb $t3 0($sp)	
sb $t2 1($sp)	
sb $t1 2($sp)	
sb $t0 3($sp)	

#pop out the word that was reversed to stack
lw $s0 0($sp)
addi $sp $sp 4
sw $s0 Output
#print result of the reversed word
li $v0 4	
la $a0 Result	
syscall	#print result statement

li $v0 4	
la $a0 Output	
syscall	#print the reversed word

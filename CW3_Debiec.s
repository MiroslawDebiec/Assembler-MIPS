######################################################################################################################################
## Name of Program:	CW3_Debiec	
## Version number:	1.0
## Date last changed: 23/08/2016
## Author: Miroslaw Debiec						Student ID: B00540796
##
## Description of Program: Presenting stored integer value in graph form, displaying simple statistics of data (Min. Max and Avg).		
##
## Description of Changes and who and when done: Final version completed by Miroslaw Debiec on 23/08/2016	
## 			  				
## 
######################################################################################################################################


.data
array:	
	.word 0x6E, 0x76, 0x80, 0x90, 0x85, 0x96, 0x8C, 0x93, 0xAC, 0x9D
	.word 0xB2, 0xB3, 0xB2, 0xB7, 0xBE, 0xB3, 0xBF, 0xC3, 0xD0, 0xD3
	.word 0xCB, 0xC4, 0xCA, 0xDC, 0xD5, 0xCA, 0xD5, 0xE3, 0xD6, 0xCF
	#.word 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 #enters min value of 1
	.word 0xDB, 0xD1, 0xDE, 0xD0, 0xD7, 0xD6, 0xE3, 0xE2, 0xCA, 0xD2
	.word 0xD8, 0xCF, 0xD3, 0xD1, 0xC9, 0xCC, 0xC9, 0xB2, 0xB8, 0xAF
	.word 0xB9, 0xA1, 0xA3, 0xB0, 0x94, 0x95, 0x8E, 0x97, 0x95, 0x8B
	.word 0x80, 0x7C, 0x84, 0x6F, 0x65, 0x70, 0x68, 0x5F, 0x54, 0x4F
	#.word 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF #enters max value of 255
	.word 0x49, 0x53, 0x4A, 0x4B, 0x36, 0x32, 0x3B, 0x2D, 0x2A, 0x33
	.word 0x1E, 0x2D, 0x2A, 0x2A, 0x1D, 0x10, 0x10, 0x0A, 0x13, 0x09
	.word 0x14, 0x16, 0x11, 0x0C, 0x18, 0x15, 0x13, 0x0F, 0x1A, 0x05
	.word 0x05, 0x19, 0x15, 0x0F, 0x1A, 0x1B, 0x24, 0x25, 0x29, 0x27
	.word 0x2C, 0x35, 0x2A, 0x38, 0x2E, 0x39, 0x47, 0x40, 0x54, 0x55


title: .asciiz 		"                         Data Graph                          \n"
breakline: .asciiz 	"-------------------------------------------------------------\n"
menu: .asciiz 		"| Item |  Value  |               Indicator                  |\n"
newline: .asciiz "\n"
blankSpace: .asciiz "    "
sign: .asciiz "#"
tabulator: .asciiz "\t"
max: .asciiz "MAX = "
min: .asciiz "MIN = "
avg: .asciiz "AVG = "

arraylength:
	.word 120

	.globl main
	.text	

main: 
	############# Displaying Tittle/ Table #################	
	li $v0,4			#setting service
	la $a0, title			#allocating text
	syscall				#printing to the screen

	li $v0,4			#setting service
	la $a0,breakline		#allocating text
	syscall 			#printing to the screen

	li $v0,4			#setting service
	la $a0,menu			#allocating text
	syscall 			#printing to the screen

	li $v0,4			#setting service
	la $a0,breakline		#allocating text
	syscall 			#printing to the screen

	############## Setting Initial Values ##################
	la $t3, array			#putting array into t3
	li $t5, 120			#setting upper bound	
	li $t6, 0			#initiatin counter = 0
	li $t7, 0			#initiating max = 0
	li $t8, 1000			#initiating min = 1000
	li $t9, 0			#initiating avg = 0

loop:	
		############## Checcking for End of the Loop ###############
		beq $t6, $t5, calcAvg		#checking if counter reaches the max value. 
		
		############ Reaching the Value of the Array ##############
		move $t0, $t6			#putting index into t2
		add $t0, $t0, $t0		#increasing index x2
		add $t0, $t0, $t0		#increasing index x4
		add $t1, $t0, $t3		#combining 	
		lw $t4, 0($t1)			#accessing the word
		addi $t6, $t6, 1		#counter++

		################ Checking for Max, Min #################
		add $t9, $t9, $t4		#adding value of the array to $t9	
		slt $t0, $t7, $t4		#checks if current value max ($t7) is lower than value of array ($t4)  
		bne $t0, $0, checkMax 		#if true ($t0 == 1) jump checkMax
		slt $t0, $t4, $t8		#checks if current value max ($t7) is lower than value of array ($t4)  
		bne $t0, $0, checkMin 		#if true ($t0 == 1) jump checkMax
		
		j displayingResult
		
		################ Setting Maximum Value #################
		checkMax:
			move $t7, $t4			#moves value of array ($t4) into current value max ($t7)
			move $t0, $0	 		#resetting value of $t0
			j displayingResult

		################ Setting Minimum Value #################
		checkMin:
			move $t8, $t4			#moves value of array ($t4) into current value max ($t7) 
			move $t0, $0			#resetting value of $t0
			j displayingResult

		################ Displaying Item Number and Actual Value #################
		displayingResult:
			li $v0,4			#setting service
			la $a0,blankSpace		#allocating text
			syscall 			#printing to the screen
	
			li $v0, 1			#setting service
			move $a0, $t6			#allocating value of counter ($t6)
			syscall				#printing to the screen
			
			li $v0,4			#setting service
			la $a0,tabulator		#allocating text
			syscall 			#printing to the screen

			li $v0, 1			#setting service
			move $a0, $t4			#allocating value of array ($t4) at given index ($t0)
			syscall				#printing to the screen

			li $v0,4			#setting service
			la $a0,tabulator		#allocating text
			syscall 			#printing to the screen
	
			j displayingIndicator
		
		################ Displaying '#' represenattion through iteration #################		
		displayingIndicator:
			blez $t4, newLine		#if value of counter ($t4) <= 0 go to 'loop'
			li $v0,4			#setting service
			la $a0,sign			#allocating text
			syscall 			#printing to the screen '#' sign
			subu $t4,$t4, 5			#counter decrase by 5 (scale down by factor x5)				
			
			j displayingIndicator		
		
		################ Calculating Average #################	
		calcAvg: 
			div $t9, $t6			#calculating average
			mflo $t0			#moving result of average from $LO into $t0
			j displayingStats
							
		newLine: 
			li $v0,4			#setting service
			la $a0,newline			#allocating text
			syscall 			#printing to the screen

			j loop
		
		################ Displaying Max, Min and AVG #################
		displayingStats:
			li $v0,4			#setting service
			la $a0,breakline		#allocating text
			syscall 			#printing to the screen

			li $v0,4			#setting service
			la $a0,max			#allocating text
			syscall 			#printing to the screen

			li $v0, 1			#setting service
			move $a0, $t7			#allocating value of max ($t7)
			syscall				#printing to the screen

			li $v0,4			#setting service
			la $a0,blankSpace		#allocating text
			syscall 			#printing to the screen

			li $v0,4			#setting service
			la $a0,min			#allocating text
			syscall 			#printing to the screen

			li $v0, 1			#setting service
			move $a0, $t8			#allocating value of min ($t8)
			syscall				#printing to the screen

			li $v0,4			#setting service
			la $a0,blankSpace		#allocating text
			syscall 			#printing to the screen

			li $v0,4			#setting service
			la $a0,avg			#allocating text
			syscall 			#printing to the screen
			
			li $v0, 1	
			move $a0, $t0			#allocating value of average ($t0)
			syscall				#printing to the screen
			
			j end

################ Terminating Program #################		
end:	
	li $v0,10
	syscall	
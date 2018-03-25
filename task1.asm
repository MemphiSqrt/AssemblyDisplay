	.data
list:	.asciiz "Alpha ","Bravo ","Charlie ","Delta ","Echo ","Foxtrot ","Golf ","Hotel ","India ","Juliet ","Kilo ","Lima ","Mike ","November ","Oscar ","Papa ","Quebec ","Romeo ","Sierra ","Tango ","Uniform ","Victor ","Whisky ","X-ray ","Yankee ","Zulu "
list2:	.asciiz "alpha ","bravo ","charlie ","delta ","echo ","foxtrot ","golf ","hotel ","india ","juliet ","kilo ","lima ","mike ","november ","oscar ","papa ","quebec ","romeo ","sierra ","tango ","uniform ","victor ","whisky ","x-ray ","yankee ","zulu "
index:	.word 0,7,14,23,30,36,45,51,58,65,73,79,85,91,101,108,114,122,129,137,144,153,161,169,176,184	
number: .asciiz "zero ", "one ", "two ", "three ", "four ", "five ", "six ", "seven ","eight ","nine " 
index_n: 	.word 0,6,11,16,23,29,35,40,47,54   
name_id:	.asciiz "\r\nname: Tao Yuanzheng. id:1600012799"
	.text 	
	.globl main
main:	
	li $v0, 12	
	syscall	
	beq $v0, '?', goend	
	sub $t1, $v0, 48	
	slt $s0, $t1, $0	
	bne $s0, $0, others	
	
	# number	
	sub $t2, $t1, 10	
	slt $s1, $t2, $0	
	bne $s1, $0, getnum	
	
	# capital	
	sub $t2, $v0, 91	
	slt $s1, $t2, $0	
	sub $t2, $v0, 64	
	sgt $s2, $t2, $0	
	and $s0, $s1, $s2	
	bne $s0, $0, printlist	
	
	# lower case	
	sub $t2, $v0, 123	
	slt $s1, $t2, $0	
	sub $t2, $v0, 96	
	sgt $s2, $t2, $0	
	and $s0, $s1, $s2	
	bne $s0, $0, printlist2	
	j others
	
getnum:	
	sll $t1, $t1, 2	
	la $s0, index_n	
	add $s0, $s0, $t1	
	lw $s1, ($s0)	
	la $a0, number	
	add $a0, $a0, $s1	
	li $v0, 4	
	syscall	
	j main
	
printlist:	
	sub $t2, $t2, 1	
	sll $t2, $t2, 2	
	la $s0, index	
	add $s0, $s0, $t2	
	lw $s1, ($s0)	
	la $a0, list	
	add $a0, $s1, $a0	
	li $v0, 4	
	syscall	
	j main
	
printlist2:	
	sub $t2, $t2, 1	
	sll $t2, $t2, 2	
	la $s0, index	
	add $s0, $s0, $t2	
	lw $s1, ($s0)	
	la $a0, list2	
	add $a0, $s1, $a0	
	li $v0, 4	
	syscall	
	j main
	
others:	
	li $a0, 42	
	li $v0, 11	
	syscall	
	j main
	
goend:	
	li $v0, 10	
	syscall

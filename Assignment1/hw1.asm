.data

	#Sayilarin kucuk harfle baslayan text karsiliklari
	zeroText: .asciiz "zero"
	oneText: .asciiz "one"
	twoText: .asciiz "two"
	threeText: .asciiz "three"
	fourText: .asciiz "four"
	fiveText: .asciiz "five"
	sixText: .asciiz "six"
	sevenText: .asciiz "seven"
	eightText: .asciiz "eight"
	nineText: .asciiz "nine"
	
	#Sayilarin buyuk harfle baslayan text karsiliklari
	zeroTextB: .asciiz "Zero"
	oneTextB: .asciiz "One"
	twoTextB: .asciiz "Two"
	threeTextB: .asciiz "Three"
	fourTextB: .asciiz "Four"
	fiveTextB: .asciiz "Five"
	sixTextB: .asciiz "Six"
	sevenTextB: .asciiz "Seven"
	eightTextB: .asciiz "Eight"
	nineTextB: .asciiz "Nine"
	
	#Sayilarin byte ile yaziomis halleri
	zero: .byte '0'
	one: .byte '1'
	two: .byte '2'
	three: .byte '3'
	four: .byte '4'
	five: .byte '5'
	six: .byte '6'
	seven: .byte '7'
	eight: .byte '8'
	nine: .byte '9'
	
	#okunacak dosyanin adi
	fileStr: .asciiz "input_hw1.txt"
	
	#dosyadan okununan text in tutuldugu data txtData'dir
	txtData: .space 256
		 .text
		
	

.text
	main:	
		
		#open file
		li $v0,13
		la $a0,fileStr
		li $a1,0
		li $a2,0
		syscall
		move $s0,$v0
	
		#read file
		li $v0,14
		move $a0,$s0
		li $a2,256
		la $a1,txtData
		syscall
	
		#close file
		li $v0,16
		move $a0,$s0
		syscall
		

		li $t0,0  #dogu counter'i
		while:		#while ile teker teker dosyanin karakterlerini alip ekrana yazdirma dongusu
			la $a1,txtData #txtData nin baslangic adrsi $a1 e atilir
			addu $a1,$a1,$t0   # $a1 registerinde baslangic adresi tutulan txtData nin, $t0. indexinin adresi $a1 e atilir
			lbu $a0,0($a1)     # $a1 ile baslayan txtDatanin 0. elemani $a0 a atilir.

			#sirasiyla sayilarin byte karsiliklarinin adresi $a2 ye atilip sonra contenti t5 e atilir ve herbirinin control labellerine gidilir eger okunan deger ile karsilastirilan deger esitse
			la $a2,zero
			lb $t5,0($a2)
			beq $a0,$t5,controlZero
						
			la $a2,one
			lb $t5,0($a2)
			beq $a0,$t5,controlOne
			
			la $a2,two
			lb $t5,0($a2)
			beq $a0,$t5,controlTwo
		
			la $a2,three
			lb $t5,0($a2)
			beq $a0,$t5,controlThree
			
			la $a2,four
			lb $t5,0($a2)
			beq $a0,$t5,controlFour

			la $a2,five
			lb $t5,0($a2)
			beq $a0,$t5,controlFive

			la $a2,six
			lb $t5,0($a2)
			beq $a0,$t5,controlSix
			
			la $a2,seven
			lb $t5,0($a2)
			beq $a0,$t5,controlSeven
			
			la $a2,eight
			lb $t5,0($a2)
			beq $a0,$t5,controlEight

			la $a2,nine
			lb $t5,0($a2)
			beq $a0,$t5,controlNine
			
			#eger tek digitli bir sayi disinda bir karakter geldiyse sadece yazdirilir											
			printOnly:
				beq  $a0,$zero,exit #sona gelmismi kontrolu
				li $v0,11 #sona geldiyse program bitirilir
				syscall
				
			#dongunun donmesine sebep olur	
			contiune:
				addi $t0,$t0,1
				j while
		
		#control methodlarinda ayni isler yapilir bu yuzden sadece zeroda aciklama yapacagim
		controlZero:
			
			lbu $a2,1($a1)   #sayinin bir sonraki digitine bakilir
			li $t8,'.' #$t8 digitine '.' karakteri atilir
			beq  $a2,$t8,printOnly	#eger "." varsa texte cevirme
			lbu $a3,-1($a1) #sayinin bir onceki digitine bakilir
			beq  $a3,$t8,printOnly	#eger "." varsa texte cevirme
					
			jal twoDigits #2 digitten fazlami kontrolu yapilir			

			lbu $a3,-2($a1)   #sayinin iki onceki digitine bakilir
			li $t8,'.'																								
			beq  $a3,$t8,controlZeroB #Yeni cumle basimi
			beq  $t0,$zero,printZeroB #dosya basimi?
			jal printZero #eger yukardaki laballere girmiyorsa sadece kucuk zero yazisi yazilir
			j contiune # donguye devam edilir
		
		#cumle basi control methodlarinda ayni isler yapilir bu yuzden sadece zeroda aciklama yapacagim
		controlZeroB:
			lbu $a3,-1($a1) #sayinin bir onceki digitine bakilir
			li $t8,' ' #eger bosluksa cumle basidir ve buyuk yazilir ilk harf
			beq  $a3,$t8,printZeroB #Yeni cumle basimi
			j contiune #karakter okuma dongusune devam		
		#print methodlarinda ayni isler yapilir bu yuzden sadece zeroda aciklama yapacagim	
		printZero:
			li $v0,4 #zero texti ekrana yazdirilir
			la $a0,zeroText
			syscall
			jr $ra	#fonksiyon cagrisinin bir altina geri donulur
		
					
						
								
		controlOne:

			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly	
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly		
				
			jal twoDigits	
			
													
			lbu $a3,-2($a1)
			li $t8,'.'													
			beq  $a3,$t8,controlOneB
			beq  $t0,$zero,printOneB
			jal printOne
			j contiune
		controlOneB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printOneB
			j contiune			
		printOne:
			li $v0,4
			la $a0,oneText
			syscall
			jr $ra			
			
			
		controlTwo:

			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly			
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly	
			
																		
			jal twoDigits																						

																																							
			lbu $a3,-2($a1)
			li $t8,'.'																																																																																																																					
			beq  $a3,$t8,controlTwoB
			beq  $t0,$zero,printTwoB
			jal printTwo
			j contiune
		controlTwoB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printTwoB
			j contiune			
		printTwo:
			li $v0,4
			la $a0,twoText
			syscall
			jr $ra			
			
			
			
		controlThree:
		
			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly		
			
					
			jal twoDigits	
			
															
			lbu $a3,-2($a1)
			li $t8,'.'																																								
			beq  $a3,$t8,controlThreeB 	
			beq  $t0,$zero,printThreeB
			jal printThree
			j contiune
		controlThreeB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printThreeB
			j contiune	
		printThree:
			li $v0,4
			la $a0,threeText
			syscall
			jr $ra
			
			
		controlFour:

			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly	
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly		
			
					
			jal twoDigits						

													
			lbu $a3,-2($a1)
			li $t8,'.'																																							
			beq  $a3,$t8,controlFourB 		
			beq  $t0,$zero,printFourB
			jal printFour
			j contiune
		controlFourB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printFourB
			j contiune	
		printFour:
			li $v0,4
			la $a0,fourText
			syscall
			jr $ra			
			
			
		controlFive:

			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly	
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly		

		
			jal twoDigits
			
							
			lbu $a3,-2($a1)
			li $t8,'.'															
			beq  $a3,$t8,controlFiveB 		
			beq  $t0,$zero,printFiveB
			jal printFive
			j contiune
		controlFiveB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printFiveB
			j contiune	
		printFive:
			li $v0,4
			la $a0,fiveText
			syscall
			jr $ra			
			
			
			
		controlSix:

			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly	
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly	



			jal twoDigits				
				
										
			lbu $a3,-2($a1)
			li $t8,'.'																						
			beq  $a3,$t8,controlSixB 		
			beq  $t0,$zero,printSixB
			jal printSix
			j contiune
		controlSixB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printSixB
			j contiune	
			
		printSix:
			li $v0,4
			la $a0,sixText
			syscall
			jr $ra
						
			
			
		controlSeven:
			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly	
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly	
			
						
			jal twoDigits									
																											
			lbu $a3,-2($a1)
			li $t8,'.'												
			beq  $a3,$t8,controlSevenB 	
			beq  $t0,$zero,printSevenB
			jal printSeven
			j contiune
		controlSevenB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printSevenB
			j contiune	
		printSeven:
			li $v0,4
			la $a0,sevenText
			syscall
			jr $ra
					
							
			
		controlEight:

			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly	
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly		
			
					
			jal twoDigits										
											

			lbu $a3,-2($a1)
			li $t8,'.'																														
			beq  $a3,$t8,controlEightB 	
			beq  $t0,$zero,printEightB
			jal printEight
			j contiune
		controlEightB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printEightB
			j contiune		
		printEight:
			li $v0,4
			la $a0,eightText
			syscall
			jr $ra
			
			
			
		controlNine:

			lbu $a2,1($a1)
			li $t8,'.'
			beq  $a2,$t8,printOnly	
			lbu $a3,-1($a1)
			beq  $a3,$t8,printOnly		
			
					
			jal twoDigits							
											
			
															
			lbu $a3,-2($a1)
			li $t8,'.'																																							
			beq  $a3,$t8,controlNineB 		
			beq  $t0,$zero,printNineB
			jal printNine
			j contiune
		controlNineB:
			lbu $a3,-1($a1)
			li $t8,' '
			beq  $a3,$t8,printNineB
			j contiune		
		printNine:
			li $v0,4
			la $a0,nineText
			syscall
			jr $ra
			
		
		#cumle basiysa sayisnin sadece bas harfi buyuk yazilir
		printZeroB:
			li $v0,4
			la $a0,zeroTextB
			syscall
			j contiune
			
		printOneB:
			li $v0,4
			la $a0,oneTextB
			syscall
			j contiune
			
		printTwoB:
			li $v0,4
			la $a0,twoTextB
			syscall
			j contiune
		printThreeB:
			li $v0,4
			la $a0,threeTextB
			syscall
			j contiune
			
		printFourB:
			li $v0,4
			la $a0,fourTextB
			syscall
			j contiune
		printFiveB:
			li $v0,4
			la $a0,fiveTextB
			syscall
			j contiune
			
		printSixB:
			li $v0,4
			la $a0,sixTextB
			syscall
			j contiune
		printSevenB:
			li $v0,4
			la $a0,sevenTextB
			syscall
			j contiune
			
		printEightB:
			li $v0,4
			la $a0,eightTextB
			syscall
			j contiune	
		printNineB:
			li $v0,4
			la $a0,nineTextB
			syscall
			j contiune
				
		#eger iki veya daha fazla digitli ise cevrilmeden sadece print edilir			
		twoDigits:
			li $t8,'0'
			beq  $a2,$t8,printOnly	
			li $t8,'1'
			beq  $a2,$t8,printOnly				
			li $t8,'2'
			beq  $a2,$t8,printOnly				
			li $t8,'3'
			beq  $a2,$t8,printOnly				
			li $t8,'4'
			beq  $a2,$t8,printOnly				
			li $t8,'5'
			beq  $a2,$t8,printOnly				
			li $t8,'6'
			beq  $a2,$t8,printOnly				
			li $t8,'7'
			beq  $a2,$t8,printOnly				
			li $t8,'8'
			beq  $a2,$t8,printOnly	
			li $t8,'9'
			beq  $a2,$t8,printOnly		
			######################################################3
			li $t8,'0'
			beq  $a3,$t8,printOnly			
			li $t8,'1'
			beq  $a3,$t8,printOnly	
			li $t8,'2'
			beq  $a3,$t8,printOnly	
			li $t8,'3'
			beq  $a3,$t8,printOnly	
			li $t8,'4'
			beq  $a3,$t8,printOnly	
			li $t8,'5'
			beq  $a3,$t8,printOnly	
			li $t8,'6'
			beq  $a3,$t8,printOnly	
			li $t8,'7'
			beq  $a3,$t8,printOnly	
			li $t8,'8'
			beq  $a3,$t8,printOnly	
			li $t8,'9'
			beq  $a3,$t8,printOnly	
			jr $ra				
								
		#program bitisi
		exit:
		
			

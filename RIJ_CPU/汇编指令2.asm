#baseAddr 0000
main:
    add     $a0, $zero, $zero;     #$a0=0000_0000源数据区域首址
    addi	$a1,$zero,20;         #$a1=0000_0014，目的数据区域首址
    addi	$a2, $zero,10;        #$a2=0000_000a，复制的数据个数
    jal	BankMove	     #子程序调用	0c000005
    jal exit             #子程序返回后，退出		0c00000f
BankMove:
    add	$t0,    $a0, $zero; 	#$t0=源数据区域首址 00804020
    add	$t1,    $a1, $zero;		#$t1=目的数据区域首址   00a04820
    add	$t2,	$a2, $zero;	#$t2=数据块长度

Loop1:	
    lw	$t3,	0($t0);	#$t3=取出数据   8d0b0000
    sw	$t3,	0($t1); 	#存数据     ad2b0000
    add	$t0,	$t0,	 4;
    add	$t1,	$t1,	 4;
    addi	$t2,	$t2,	-1;       #计数值-1 214afff
    bne	$t2, $zero, Loop1;	  #计数值≠0，则没有复制完，转循环体首部 1540fffa
    jr	$ra	#复制完成，则子程序返回	03e00008

exit:

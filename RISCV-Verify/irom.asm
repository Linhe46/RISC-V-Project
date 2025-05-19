
irom.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	00108117          	auipc	x2,0x108
       4:	03010113          	addi	x2,x2,48 # 0x108030
       8:	5a0000ef          	jal	x1,0x5a8
       c:	534000ef          	jal	x1,0x540
      10:	0000006f          	j	0x10
      14:	ff010113          	addi	x2,x2,-16
      18:	00112623          	sw	x1,12(x2)
      1c:	00812423          	sw	x8,8(x2)
      20:	01010413          	addi	x8,x2,16
      24:	802007b7          	lui	x15,0x80200
      28:	0007a783          	lw	x15,0(x15) # 0x80200000
      2c:	00078513          	mv	x10,x15
      30:	00c12083          	lw	x1,12(x2)
      34:	00812403          	lw	x8,8(x2)
      38:	01010113          	addi	x2,x2,16
      3c:	00008067          	ret
      40:	ff010113          	addi	x2,x2,-16
      44:	00112623          	sw	x1,12(x2)
      48:	00812423          	sw	x8,8(x2)
      4c:	01010413          	addi	x8,x2,16
      50:	802007b7          	lui	x15,0x80200
      54:	00478793          	addi	x15,x15,4 # 0x80200004
      58:	0007a783          	lw	x15,0(x15)
      5c:	00078513          	mv	x10,x15
      60:	00c12083          	lw	x1,12(x2)
      64:	00812403          	lw	x8,8(x2)
      68:	01010113          	addi	x2,x2,16
      6c:	00008067          	ret
      70:	fd010113          	addi	x2,x2,-48
      74:	02112623          	sw	x1,44(x2)
      78:	02812423          	sw	x8,40(x2)
      7c:	03010413          	addi	x8,x2,48
      80:	fca42e23          	sw	x10,-36(x8)
      84:	fe042623          	sw	x0,-20(x8)
      88:	fe042423          	sw	x0,-24(x8)
      8c:	0580006f          	j	0xe4
      90:	fdc42783          	lw	x15,-36(x8)
      94:	00a00593          	li	x11,10
      98:	00078513          	mv	x10,x15
      9c:	2dc010ef          	jal	x1,0x1378
      a0:	00050793          	mv	x15,x10
      a4:	fef42223          	sw	x15,-28(x8)
      a8:	fe842783          	lw	x15,-24(x8)
      ac:	fe442703          	lw	x14,-28(x8)
      b0:	00f717b3          	sll	x15,x14,x15
      b4:	fec42703          	lw	x14,-20(x8)
      b8:	00f767b3          	or	x15,x14,x15
      bc:	fef42623          	sw	x15,-20(x8)
      c0:	fdc42783          	lw	x15,-36(x8)
      c4:	00a00593          	li	x11,10
      c8:	00078513          	mv	x10,x15
      cc:	264010ef          	jal	x1,0x1330
      d0:	00050793          	mv	x15,x10
      d4:	fcf42e23          	sw	x15,-36(x8)
      d8:	fe842783          	lw	x15,-24(x8)
      dc:	00478793          	addi	x15,x15,4
      e0:	fef42423          	sw	x15,-24(x8)
      e4:	fdc42783          	lw	x15,-36(x8)
      e8:	fa0794e3          	bnez	x15,0x90
      ec:	fec42783          	lw	x15,-20(x8)
      f0:	00078513          	mv	x10,x15
      f4:	02c12083          	lw	x1,44(x2)
      f8:	02812403          	lw	x8,40(x2)
      fc:	03010113          	addi	x2,x2,48
     100:	00008067          	ret
     104:	fe010113          	addi	x2,x2,-32
     108:	00112e23          	sw	x1,28(x2)
     10c:	00812c23          	sw	x8,24(x2)
     110:	02010413          	addi	x8,x2,32
     114:	801007b7          	lui	x15,0x80100
     118:	0007a783          	lw	x15,0(x15) # 0x80100000
     11c:	00078513          	mv	x10,x15
     120:	f51ff0ef          	jal	x1,0x70
     124:	fea42623          	sw	x10,-20(x8)
     128:	802007b7          	lui	x15,0x80200
     12c:	02078793          	addi	x15,x15,32 # 0x80200020
     130:	fec42703          	lw	x14,-20(x8)
     134:	01871713          	slli	x14,x14,0x18
     138:	00e7a023          	sw	x14,0(x15)
     13c:	00000013          	nop
     140:	01c12083          	lw	x1,28(x2)
     144:	01812403          	lw	x8,24(x2)
     148:	02010113          	addi	x2,x2,32
     14c:	00008067          	ret
     150:	fd010113          	addi	x2,x2,-48
     154:	02112623          	sw	x1,44(x2)
     158:	02812423          	sw	x8,40(x2)
     15c:	03010413          	addi	x8,x2,48
     160:	fca42e23          	sw	x10,-36(x8)
     164:	fdc42503          	lw	x10,-36(x8)
     168:	f09ff0ef          	jal	x1,0x70
     16c:	00050713          	mv	x14,x10
     170:	010007b7          	lui	x15,0x1000
     174:	fff78793          	addi	x15,x15,-1 # 0xffffff
     178:	00f777b3          	and	x15,x14,x15
     17c:	fef42623          	sw	x15,-20(x8)
     180:	802007b7          	lui	x15,0x80200
     184:	02078793          	addi	x15,x15,32 # 0x80200020
     188:	0007a683          	lw	x13,0(x15)
     18c:	802007b7          	lui	x15,0x80200
     190:	02078793          	addi	x15,x15,32 # 0x80200020
     194:	fec42703          	lw	x14,-20(x8)
     198:	00e6e733          	or	x14,x13,x14
     19c:	00e7a023          	sw	x14,0(x15)
     1a0:	00000013          	nop
     1a4:	02c12083          	lw	x1,44(x2)
     1a8:	02812403          	lw	x8,40(x2)
     1ac:	03010113          	addi	x2,x2,48
     1b0:	00008067          	ret
     1b4:	fe010113          	addi	x2,x2,-32
     1b8:	00112e23          	sw	x1,28(x2)
     1bc:	00812c23          	sw	x8,24(x2)
     1c0:	02010413          	addi	x8,x2,32
     1c4:	fea42623          	sw	x10,-20(x8)
     1c8:	802007b7          	lui	x15,0x80200
     1cc:	04078793          	addi	x15,x15,64 # 0x80200040
     1d0:	fec42703          	lw	x14,-20(x8)
     1d4:	00e7a023          	sw	x14,0(x15)
     1d8:	00000013          	nop
     1dc:	01c12083          	lw	x1,28(x2)
     1e0:	01812403          	lw	x8,24(x2)
     1e4:	02010113          	addi	x2,x2,32
     1e8:	00008067          	ret
     1ec:	fe010113          	addi	x2,x2,-32
     1f0:	00112e23          	sw	x1,28(x2)
     1f4:	00812c23          	sw	x8,24(x2)
     1f8:	02010413          	addi	x8,x2,32
     1fc:	fe042623          	sw	x0,-20(x8)
     200:	fec42703          	lw	x14,-20(x8)
     204:	010007b7          	lui	x15,0x1000
     208:	00f767b3          	or	x15,x14,x15
     20c:	fef42623          	sw	x15,-20(x8)
     210:	fec42703          	lw	x14,-20(x8)
     214:	000207b7          	lui	x15,0x20
     218:	00f767b3          	or	x15,x14,x15
     21c:	fef42623          	sw	x15,-20(x8)
     220:	fec42703          	lw	x14,-20(x8)
     224:	000017b7          	lui	x15,0x1
     228:	80078793          	addi	x15,x15,-2048 # 0x800
     22c:	00f767b3          	or	x15,x14,x15
     230:	fef42623          	sw	x15,-20(x8)
     234:	fec42783          	lw	x15,-20(x8)
     238:	4007e793          	ori	x15,x15,1024
     23c:	fef42623          	sw	x15,-20(x8)
     240:	fec42783          	lw	x15,-20(x8)
     244:	0087e793          	ori	x15,x15,8
     248:	fef42623          	sw	x15,-20(x8)
     24c:	fec42703          	lw	x14,-20(x8)
     250:	000017b7          	lui	x15,0x1
     254:	00f767b3          	or	x15,x14,x15
     258:	fef42623          	sw	x15,-20(x8)
     25c:	fec42703          	lw	x14,-20(x8)
     260:	002007b7          	lui	x15,0x200
     264:	00f767b3          	or	x15,x14,x15
     268:	fef42623          	sw	x15,-20(x8)
     26c:	fec42503          	lw	x10,-20(x8)
     270:	f45ff0ef          	jal	x1,0x1b4
     274:	00000013          	nop
     278:	01c12083          	lw	x1,28(x2)
     27c:	01812403          	lw	x8,24(x2)
     280:	02010113          	addi	x2,x2,32
     284:	00008067          	ret
     288:	fe010113          	addi	x2,x2,-32
     28c:	00112e23          	sw	x1,28(x2)
     290:	00812c23          	sw	x8,24(x2)
     294:	02010413          	addi	x8,x2,32
     298:	fe042623          	sw	x0,-20(x8)
     29c:	fec42783          	lw	x15,-20(x8)
     2a0:	0207e793          	ori	x15,x15,32
     2a4:	fef42623          	sw	x15,-20(x8)
     2a8:	fec42703          	lw	x14,-20(x8)
     2ac:	000017b7          	lui	x15,0x1
     2b0:	00f767b3          	or	x15,x14,x15
     2b4:	fef42623          	sw	x15,-20(x8)
     2b8:	fec42703          	lw	x14,-20(x8)
     2bc:	000807b7          	lui	x15,0x80
     2c0:	00f767b3          	or	x15,x14,x15
     2c4:	fef42623          	sw	x15,-20(x8)
     2c8:	fec42703          	lw	x14,-20(x8)
     2cc:	040007b7          	lui	x15,0x4000
     2d0:	00f767b3          	or	x15,x14,x15
     2d4:	fef42623          	sw	x15,-20(x8)
     2d8:	fec42783          	lw	x15,-20(x8)
     2dc:	0047e793          	ori	x15,x15,4
     2e0:	fef42623          	sw	x15,-20(x8)
     2e4:	fec42703          	lw	x14,-20(x8)
     2e8:	000017b7          	lui	x15,0x1
     2ec:	80078793          	addi	x15,x15,-2048 # 0x800
     2f0:	00f767b3          	or	x15,x14,x15
     2f4:	fef42623          	sw	x15,-20(x8)
     2f8:	fec42703          	lw	x14,-20(x8)
     2fc:	001007b7          	lui	x15,0x100
     300:	00f767b3          	or	x15,x14,x15
     304:	fef42623          	sw	x15,-20(x8)
     308:	fec42703          	lw	x14,-20(x8)
     30c:	200007b7          	lui	x15,0x20000
     310:	00f767b3          	or	x15,x14,x15
     314:	fef42623          	sw	x15,-20(x8)
     318:	fec42503          	lw	x10,-20(x8)
     31c:	e99ff0ef          	jal	x1,0x1b4
     320:	00000013          	nop
     324:	01c12083          	lw	x1,28(x2)
     328:	01812403          	lw	x8,24(x2)
     32c:	02010113          	addi	x2,x2,32
     330:	00008067          	ret
     334:	fe010113          	addi	x2,x2,-32
     338:	00112e23          	sw	x1,28(x2)
     33c:	00812c23          	sw	x8,24(x2)
     340:	02010413          	addi	x8,x2,32
     344:	fe042623          	sw	x0,-20(x8)
     348:	0200006f          	j	0x368
     34c:	802007b7          	lui	x15,0x80200
     350:	05078793          	addi	x15,x15,80 # 0x80200050
     354:	80000737          	lui	x14,0x80000
     358:	00e7a023          	sw	x14,0(x15)
     35c:	fec42783          	lw	x15,-20(x8)
     360:	00178793          	addi	x15,x15,1
     364:	fef42623          	sw	x15,-20(x8)
     368:	fec42703          	lw	x14,-20(x8)
     36c:	00900793          	li	x15,9
     370:	fce7dee3          	bge	x15,x14,0x34c
     374:	00000013          	nop
     378:	00000013          	nop
     37c:	01c12083          	lw	x1,28(x2)
     380:	01812403          	lw	x8,24(x2)
     384:	02010113          	addi	x2,x2,32
     388:	00008067          	ret
     38c:	fe010113          	addi	x2,x2,-32
     390:	00112e23          	sw	x1,28(x2)
     394:	00812c23          	sw	x8,24(x2)
     398:	02010413          	addi	x8,x2,32
     39c:	fe042623          	sw	x0,-20(x8)
     3a0:	0200006f          	j	0x3c0
     3a4:	802007b7          	lui	x15,0x80200
     3a8:	05078793          	addi	x15,x15,80 # 0x80200050
     3ac:	fff00713          	li	x14,-1
     3b0:	00e7a023          	sw	x14,0(x15)
     3b4:	fec42783          	lw	x15,-20(x8)
     3b8:	00178793          	addi	x15,x15,1
     3bc:	fef42623          	sw	x15,-20(x8)
     3c0:	fec42703          	lw	x14,-20(x8)
     3c4:	00900793          	li	x15,9
     3c8:	fce7dee3          	bge	x15,x14,0x3a4
     3cc:	00000013          	nop
     3d0:	00000013          	nop
     3d4:	01c12083          	lw	x1,28(x2)
     3d8:	01812403          	lw	x8,24(x2)
     3dc:	02010113          	addi	x2,x2,32
     3e0:	00008067          	ret
     3e4:	ff010113          	addi	x2,x2,-16
     3e8:	00112623          	sw	x1,12(x2)
     3ec:	00812423          	sw	x8,8(x2)
     3f0:	01010413          	addi	x8,x2,16
     3f4:	802007b7          	lui	x15,0x80200
     3f8:	05078793          	addi	x15,x15,80 # 0x80200050
     3fc:	0007a783          	lw	x15,0(x15)
     400:	00078513          	mv	x10,x15
     404:	00c12083          	lw	x1,12(x2)
     408:	00812403          	lw	x8,8(x2)
     40c:	01010113          	addi	x2,x2,16
     410:	00008067          	ret
     414:	ff010113          	addi	x2,x2,-16
     418:	00112623          	sw	x1,12(x2)
     41c:	00812423          	sw	x8,8(x2)
     420:	01010413          	addi	x8,x2,16
     424:	f69ff0ef          	jal	x1,0x38c
     428:	fbdff0ef          	jal	x1,0x3e4
     42c:	00050793          	mv	x15,x10
     430:	00078513          	mv	x10,x15
     434:	d1dff0ef          	jal	x1,0x150
     438:	e51ff0ef          	jal	x1,0x288
     43c:	00000f93          	li	x31,0
     440:	00000013          	nop
     444:	00c12083          	lw	x1,12(x2)
     448:	00812403          	lw	x8,8(x2)
     44c:	01010113          	addi	x2,x2,16
     450:	00008067          	ret
     454:	ff010113          	addi	x2,x2,-16
     458:	00112623          	sw	x1,12(x2)
     45c:	00812423          	sw	x8,8(x2)
     460:	01010413          	addi	x8,x2,16
     464:	f29ff0ef          	jal	x1,0x38c
     468:	f7dff0ef          	jal	x1,0x3e4
     46c:	00050793          	mv	x15,x10
     470:	00078513          	mv	x10,x15
     474:	cddff0ef          	jal	x1,0x150
     478:	d75ff0ef          	jal	x1,0x1ec
     47c:	00100f93          	li	x31,1
     480:	00000013          	nop
     484:	00c12083          	lw	x1,12(x2)
     488:	00812403          	lw	x8,8(x2)
     48c:	01010113          	addi	x2,x2,16
     490:	00008067          	ret
     494:	fd010113          	addi	x2,x2,-48
     498:	02112623          	sw	x1,44(x2)
     49c:	02812423          	sw	x8,40(x2)
     4a0:	02912223          	sw	x9,36(x2)
     4a4:	03010413          	addi	x8,x2,48
     4a8:	fca42e23          	sw	x10,-36(x8)
     4ac:	fe042623          	sw	x0,-20(x8)
     4b0:	fe042423          	sw	x0,-24(x8)
     4b4:	0640006f          	j	0x518
     4b8:	fe842703          	lw	x14,-24(x8)
     4bc:	00070793          	mv	x15,x14
     4c0:	00179793          	slli	x15,x15,0x1
     4c4:	00e787b3          	add	x15,x15,x14
     4c8:	00279793          	slli	x15,x15,0x2
     4cc:	00e784b3          	add	x9,x15,x14
     4d0:	fe842783          	lw	x15,-24(x8)
     4d4:	00700593          	li	x11,7
     4d8:	00078513          	mv	x10,x15
     4dc:	6d1000ef          	jal	x1,0x13ac
     4e0:	00050793          	mv	x15,x10
     4e4:	00f484b3          	add	x9,x9,x15
     4e8:	fe842783          	lw	x15,-24(x8)
     4ec:	ffd00593          	li	x11,-3
     4f0:	00078513          	mv	x10,x15
     4f4:	635000ef          	jal	x1,0x1328
     4f8:	00050793          	mv	x15,x10
     4fc:	00f487b3          	add	x15,x9,x15
     500:	fec42703          	lw	x14,-20(x8)
     504:	00f707b3          	add	x15,x14,x15
     508:	fef42623          	sw	x15,-20(x8)
     50c:	fe842783          	lw	x15,-24(x8)
     510:	00178793          	addi	x15,x15,1
     514:	fef42423          	sw	x15,-24(x8)
     518:	fe842703          	lw	x14,-24(x8)
     51c:	fdc42783          	lw	x15,-36(x8)
     520:	f8f74ce3          	blt	x14,x15,0x4b8
     524:	fec42783          	lw	x15,-20(x8)
     528:	00078513          	mv	x10,x15
     52c:	02c12083          	lw	x1,44(x2)
     530:	02812403          	lw	x8,40(x2)
     534:	02412483          	lw	x9,36(x2)
     538:	03010113          	addi	x2,x2,48
     53c:	00008067          	ret
     540:	fe010113          	addi	x2,x2,-32
     544:	00112e23          	sw	x1,28(x2)
     548:	00812c23          	sw	x8,24(x2)
     54c:	02010413          	addi	x8,x2,32
     550:	bb5ff0ef          	jal	x1,0x104
     554:	de1ff0ef          	jal	x1,0x334
     558:	000187b7          	lui	x15,0x18
     55c:	6a078793          	addi	x15,x15,1696 # 0x186a0
     560:	fef42623          	sw	x15,-20(x8)
     564:	fec42503          	lw	x10,-20(x8)
     568:	f2dff0ef          	jal	x1,0x494
     56c:	fea42423          	sw	x10,-24(x8)
     570:	fe842703          	lw	x14,-24(x8)
     574:	bef167b7          	lui	x15,0xbef16
     578:	57078793          	addi	x15,x15,1392 # 0xbef16570
     57c:	00f70863          	beq	x14,x15,0x58c
     580:	e95ff0ef          	jal	x1,0x414
     584:	00000793          	li	x15,0
     588:	00c0006f          	j	0x594
     58c:	ec9ff0ef          	jal	x1,0x454
     590:	00000793          	li	x15,0
     594:	00078513          	mv	x10,x15
     598:	01c12083          	lw	x1,28(x2)
     59c:	01812403          	lw	x8,24(x2)
     5a0:	02010113          	addi	x2,x2,32
     5a4:	00008067          	ret
     5a8:	00100317          	auipc	x6,0x100
     5ac:	a6030313          	addi	x6,x6,-1440 # 0x100008
     5b0:	00132c23          	sw	x1,24(x6)
     5b4:	0a4000ef          	jal	x1,0x658
     5b8:	184000ef          	jal	x1,0x73c
     5bc:	34c000ef          	jal	x1,0x908
     5c0:	468000ef          	jal	x1,0xa28
     5c4:	294000ef          	jal	x1,0x858
     5c8:	1d0000ef          	jal	x1,0x798
     5cc:	4b0000ef          	jal	x1,0xa7c
     5d0:	55c000ef          	jal	x1,0xb2c
     5d4:	600000ef          	jal	x1,0xbd4
     5d8:	6ac000ef          	jal	x1,0xc84
     5dc:	764000ef          	jal	x1,0xd40
     5e0:	79c000ef          	jal	x1,0xd7c
     5e4:	38c000ef          	jal	x1,0x970
     5e8:	108000ef          	jal	x1,0x6f0
     5ec:	218000ef          	jal	x1,0x804
     5f0:	2c4000ef          	jal	x1,0x8b4
     5f4:	3e8000ef          	jal	x1,0x9dc
     5f8:	4dc000ef          	jal	x1,0xad4
     5fc:	588000ef          	jal	x1,0xb84
     600:	630000ef          	jal	x1,0xc30
     604:	6ec000ef          	jal	x1,0xcf0
     608:	015000ef          	jal	x1,0xe1c
     60c:	7bc000ef          	jal	x1,0xdc8
     610:	151000ef          	jal	x1,0xf60
     614:	1d5000ef          	jal	x1,0xfe8
     618:	059000ef          	jal	x1,0xe70
     61c:	0a5000ef          	jal	x1,0xec0
     620:	0f9000ef          	jal	x1,0xf18
     624:	231000ef          	jal	x1,0x1054
     628:	27d000ef          	jal	x1,0x10a4
     62c:	2cd000ef          	jal	x1,0x10f8
     630:	315000ef          	jal	x1,0x1144
     634:	35d000ef          	jal	x1,0x1190
     638:	3a5000ef          	jal	x1,0x11dc
     63c:	3ed000ef          	jal	x1,0x1228
     640:	435000ef          	jal	x1,0x1274
     644:	481000ef          	jal	x1,0x12c4
     648:	00100317          	auipc	x6,0x100
     64c:	9c030313          	addi	x6,x6,-1600 # 0x100008
     650:	01832083          	lw	x1,24(x6)
     654:	00008067          	ret
     658:	800002b7          	lui	x5,0x80000
     65c:	fff28293          	addi	x5,x5,-1 # 0x7fffffff
     660:	00100313          	li	x6,1
     664:	006283b3          	add	x7,x5,x6
     668:	80000e37          	lui	x28,0x80000
     66c:	07c39663          	bne	x7,x28,0x6d8
     670:	fff00293          	li	x5,-1
     674:	00100313          	li	x6,1
     678:	006283b3          	add	x7,x5,x6
     67c:	04039e63          	bnez	x7,0x6d8
     680:	123452b7          	lui	x5,0x12345
     684:	67828293          	addi	x5,x5,1656 # 0x12345678
     688:	87654337          	lui	x6,0x87654
     68c:	32130313          	addi	x6,x6,801 # 0x87654321
     690:	006283b3          	add	x7,x5,x6
     694:	9999ae37          	lui	x28,0x9999a
     698:	999e0e13          	addi	x28,x28,-1639 # 0x99999999
     69c:	03c39e63          	bne	x7,x28,0x6d8
     6a0:	9999ae37          	lui	x28,0x9999a
     6a4:	999e0e13          	addi	x28,x28,-1639 # 0x99999999
     6a8:	9999aeb7          	lui	x29,0x9999a
     6ac:	999e8e93          	addi	x29,x29,-1639 # 0x99999999
     6b0:	01de0f33          	add	x30,x28,x29
     6b4:	33333fb7          	lui	x31,0x33333
     6b8:	332f8f93          	addi	x31,x31,818 # 0x33333332
     6bc:	01ff1e63          	bne	x30,x31,0x6d8
     6c0:	00100297          	auipc	x5,0x100
     6c4:	94028293          	addi	x5,x5,-1728 # 0x100000
     6c8:	0002a303          	lw	x6,0(x5)
     6cc:	00130313          	addi	x6,x6,1
     6d0:	0062a023          	sw	x6,0(x5)
     6d4:	00008067          	ret
     6d8:	00100297          	auipc	x5,0x100
     6dc:	92c28293          	addi	x5,x5,-1748 # 0x100004
     6e0:	0002a303          	lw	x6,0(x5)
     6e4:	00130313          	addi	x6,x6,1
     6e8:	0062a023          	sw	x6,0(x5)
     6ec:	00008067          	ret
     6f0:	00000293          	li	x5,0
     6f4:	07b28313          	addi	x6,x5,123
     6f8:	07b00393          	li	x7,123
     6fc:	02731463          	bne	x6,x7,0x724
     700:	fff00293          	li	x5,-1
     704:	00128313          	addi	x6,x5,1
     708:	00031e63          	bnez	x6,0x724
     70c:	00100297          	auipc	x5,0x100
     710:	8f428293          	addi	x5,x5,-1804 # 0x100000
     714:	0002a303          	lw	x6,0(x5)
     718:	00130313          	addi	x6,x6,1
     71c:	0062a023          	sw	x6,0(x5)
     720:	00008067          	ret
     724:	00100297          	auipc	x5,0x100
     728:	8e028293          	addi	x5,x5,-1824 # 0x100004
     72c:	0002a303          	lw	x6,0(x5)
     730:	00130313          	addi	x6,x6,1
     734:	0062a023          	sw	x6,0(x5)
     738:	00008067          	ret
     73c:	800002b7          	lui	x5,0x80000
     740:	fff28293          	addi	x5,x5,-1 # 0x7fffffff
     744:	80000337          	lui	x6,0x80000
     748:	fff30313          	addi	x6,x6,-1 # 0x7fffffff
     74c:	406283b3          	sub	x7,x5,x6
     750:	02039863          	bnez	x7,0x780
     754:	00000293          	li	x5,0
     758:	fff00313          	li	x6,-1
     75c:	406283b3          	sub	x7,x5,x6
     760:	00100e13          	li	x28,1
     764:	01c39e63          	bne	x7,x28,0x780
     768:	00100297          	auipc	x5,0x100
     76c:	89828293          	addi	x5,x5,-1896 # 0x100000
     770:	0002a303          	lw	x6,0(x5)
     774:	00130313          	addi	x6,x6,1
     778:	0062a023          	sw	x6,0(x5)
     77c:	00008067          	ret
     780:	00100297          	auipc	x5,0x100
     784:	88428293          	addi	x5,x5,-1916 # 0x100004
     788:	0002a303          	lw	x6,0(x5)
     78c:	00130313          	addi	x6,x6,1
     790:	0062a023          	sw	x6,0(x5)
     794:	00008067          	ret
     798:	aaaab2b7          	lui	x5,0xaaaab
     79c:	aaa28293          	addi	x5,x5,-1366 # 0xaaaaaaaa
     7a0:	55555337          	lui	x6,0x55555
     7a4:	55530313          	addi	x6,x6,1365 # 0x55555555
     7a8:	0062f3b3          	and	x7,x5,x6
     7ac:	04039063          	bnez	x7,0x7ec
     7b0:	fff00293          	li	x5,-1
     7b4:	00000313          	li	x6,0
     7b8:	0062f3b3          	and	x7,x5,x6
     7bc:	02039863          	bnez	x7,0x7ec
     7c0:	123452b7          	lui	x5,0x12345
     7c4:	67828293          	addi	x5,x5,1656 # 0x12345678
     7c8:	fff00313          	li	x6,-1
     7cc:	0062f3b3          	and	x7,x5,x6
     7d0:	00539e63          	bne	x7,x5,0x7ec
     7d4:	00100297          	auipc	x5,0x100
     7d8:	82c28293          	addi	x5,x5,-2004 # 0x100000
     7dc:	0002a303          	lw	x6,0(x5)
     7e0:	00130313          	addi	x6,x6,1
     7e4:	0062a023          	sw	x6,0(x5)
     7e8:	00008067          	ret
     7ec:	00100297          	auipc	x5,0x100
     7f0:	81828293          	addi	x5,x5,-2024 # 0x100004
     7f4:	0002a303          	lw	x6,0(x5)
     7f8:	00130313          	addi	x6,x6,1
     7fc:	0062a023          	sw	x6,0(x5)
     800:	00008067          	ret
     804:	fff00293          	li	x5,-1
     808:	70f2f313          	andi	x6,x5,1807
     80c:	70f00393          	li	x7,1807
     810:	02731863          	bne	x6,x7,0x840
     814:	1234b2b7          	lui	x5,0x1234b
     818:	bcd28293          	addi	x5,x5,-1075 # 0x1234abcd
     81c:	5cb2f313          	andi	x6,x5,1483
     820:	1c900393          	li	x7,457
     824:	00731e63          	bne	x6,x7,0x840
     828:	000ff297          	auipc	x5,0xff
     82c:	7d828293          	addi	x5,x5,2008 # 0x100000
     830:	0002a303          	lw	x6,0(x5)
     834:	00130313          	addi	x6,x6,1
     838:	0062a023          	sw	x6,0(x5)
     83c:	00008067          	ret
     840:	000ff297          	auipc	x5,0xff
     844:	7c428293          	addi	x5,x5,1988 # 0x100004
     848:	0002a303          	lw	x6,0(x5)
     84c:	00130313          	addi	x6,x6,1
     850:	0062a023          	sw	x6,0(x5)
     854:	00008067          	ret
     858:	aaaab2b7          	lui	x5,0xaaaab
     85c:	aaa28293          	addi	x5,x5,-1366 # 0xaaaaaaaa
     860:	55555337          	lui	x6,0x55555
     864:	55530313          	addi	x6,x6,1365 # 0x55555555
     868:	0062e3b3          	or	x7,x5,x6
     86c:	fff00e13          	li	x28,-1
     870:	03c39663          	bne	x7,x28,0x89c
     874:	00000293          	li	x5,0
     878:	00000313          	li	x6,0
     87c:	0062e3b3          	or	x7,x5,x6
     880:	00039e63          	bnez	x7,0x89c
     884:	000ff297          	auipc	x5,0xff
     888:	77c28293          	addi	x5,x5,1916 # 0x100000
     88c:	0002a303          	lw	x6,0(x5)
     890:	00130313          	addi	x6,x6,1
     894:	0062a023          	sw	x6,0(x5)
     898:	00008067          	ret
     89c:	000ff297          	auipc	x5,0xff
     8a0:	76828293          	addi	x5,x5,1896 # 0x100004
     8a4:	0002a303          	lw	x6,0(x5)
     8a8:	00130313          	addi	x6,x6,1
     8ac:	0062a023          	sw	x6,0(x5)
     8b0:	00008067          	ret
     8b4:	00000293          	li	x5,0
     8b8:	7f02e313          	ori	x6,x5,2032
     8bc:	7f000393          	li	x7,2032
     8c0:	02731863          	bne	x6,x7,0x8f0
     8c4:	aaaa02b7          	lui	x5,0xaaaa0
     8c8:	7ff2e313          	ori	x6,x5,2047
     8cc:	aaaa03b7          	lui	x7,0xaaaa0
     8d0:	7ff38393          	addi	x7,x7,2047 # 0xaaaa07ff
     8d4:	00731e63          	bne	x6,x7,0x8f0
     8d8:	000ff297          	auipc	x5,0xff
     8dc:	72828293          	addi	x5,x5,1832 # 0x100000
     8e0:	0002a303          	lw	x6,0(x5)
     8e4:	00130313          	addi	x6,x6,1
     8e8:	0062a023          	sw	x6,0(x5)
     8ec:	00008067          	ret
     8f0:	000ff297          	auipc	x5,0xff
     8f4:	71428293          	addi	x5,x5,1812 # 0x100004
     8f8:	0002a303          	lw	x6,0(x5)
     8fc:	00130313          	addi	x6,x6,1
     900:	0062a023          	sw	x6,0(x5)
     904:	00008067          	ret
     908:	fff00293          	li	x5,-1
     90c:	00000313          	li	x6,0
     910:	0062a3b3          	slt	x7,x5,x6
     914:	00100e13          	li	x28,1
     918:	05c39063          	bne	x7,x28,0x958
     91c:	07b00293          	li	x5,123
     920:	07b00313          	li	x6,123
     924:	0062a3b3          	slt	x7,x5,x6
     928:	02039863          	bnez	x7,0x958
     92c:	800002b7          	lui	x5,0x80000
     930:	fff28293          	addi	x5,x5,-1 # 0x7fffffff
     934:	fff00313          	li	x6,-1
     938:	0062a3b3          	slt	x7,x5,x6
     93c:	00039e63          	bnez	x7,0x958
     940:	000ff297          	auipc	x5,0xff
     944:	6c028293          	addi	x5,x5,1728 # 0x100000
     948:	0002a303          	lw	x6,0(x5)
     94c:	00130313          	addi	x6,x6,1
     950:	0062a023          	sw	x6,0(x5)
     954:	00008067          	ret
     958:	000ff297          	auipc	x5,0xff
     95c:	6ac28293          	addi	x5,x5,1708 # 0x100004
     960:	0002a303          	lw	x6,0(x5)
     964:	00130313          	addi	x6,x6,1
     968:	0062a023          	sw	x6,0(x5)
     96c:	00008067          	ret
     970:	fff00293          	li	x5,-1
     974:	0002a313          	slti	x6,x5,0
     978:	00100393          	li	x7,1
     97c:	04731663          	bne	x6,x7,0x9c8
     980:	00500293          	li	x5,5
     984:	00a2a313          	slti	x6,x5,10
     988:	00100393          	li	x7,1
     98c:	02731e63          	bne	x6,x7,0x9c8
     990:	00500293          	li	x5,5
     994:	0052a313          	slti	x6,x5,5
     998:	00000393          	li	x7,0
     99c:	02731663          	bne	x6,x7,0x9c8
     9a0:	00a00293          	li	x5,10
     9a4:	0052a313          	slti	x6,x5,5
     9a8:	00000393          	li	x7,0
     9ac:	00731e63          	bne	x6,x7,0x9c8
     9b0:	000ff297          	auipc	x5,0xff
     9b4:	65028293          	addi	x5,x5,1616 # 0x100000
     9b8:	0002a303          	lw	x6,0(x5)
     9bc:	00130313          	addi	x6,x6,1
     9c0:	0062a023          	sw	x6,0(x5)
     9c4:	00008067          	ret
     9c8:	000ff297          	auipc	x5,0xff
     9cc:	63c28293          	addi	x5,x5,1596 # 0x100004
     9d0:	0002a303          	lw	x6,0(x5)
     9d4:	00130313          	addi	x6,x6,1
     9d8:	0062a023          	sw	x6,0(x5)
     9dc:	00000293          	li	x5,0
     9e0:	0012b313          	seqz	x6,x5
     9e4:	00100393          	li	x7,1
     9e8:	02731463          	bne	x6,x7,0xa10
     9ec:	fff00293          	li	x5,-1
     9f0:	fff2b313          	sltiu	x6,x5,-1
     9f4:	00031e63          	bnez	x6,0xa10
     9f8:	000ff297          	auipc	x5,0xff
     9fc:	60828293          	addi	x5,x5,1544 # 0x100000
     a00:	0002a303          	lw	x6,0(x5)
     a04:	00130313          	addi	x6,x6,1
     a08:	0062a023          	sw	x6,0(x5)
     a0c:	00008067          	ret
     a10:	000ff297          	auipc	x5,0xff
     a14:	5f428293          	addi	x5,x5,1524 # 0x100004
     a18:	0002a303          	lw	x6,0(x5)
     a1c:	00130313          	addi	x6,x6,1
     a20:	0062a023          	sw	x6,0(x5)
     a24:	00008067          	ret
     a28:	fff00293          	li	x5,-1
     a2c:	00000313          	li	x6,0
     a30:	0062b3b3          	sltu	x7,x5,x6
     a34:	02039863          	bnez	x7,0xa64
     a38:	00000293          	li	x5,0
     a3c:	00100313          	li	x6,1
     a40:	0062b3b3          	sltu	x7,x5,x6
     a44:	00100e13          	li	x28,1
     a48:	01c39e63          	bne	x7,x28,0xa64
     a4c:	000ff297          	auipc	x5,0xff
     a50:	5b428293          	addi	x5,x5,1460 # 0x100000
     a54:	0002a303          	lw	x6,0(x5)
     a58:	00130313          	addi	x6,x6,1
     a5c:	0062a023          	sw	x6,0(x5)
     a60:	00008067          	ret
     a64:	000ff297          	auipc	x5,0xff
     a68:	5a028293          	addi	x5,x5,1440 # 0x100004
     a6c:	0002a303          	lw	x6,0(x5)
     a70:	00130313          	addi	x6,x6,1
     a74:	0062a023          	sw	x6,0(x5)
     a78:	00008067          	ret
     a7c:	ffff02b7          	lui	x5,0xffff0
     a80:	00010337          	lui	x6,0x10
     a84:	fff30313          	addi	x6,x6,-1 # 0xffff
     a88:	0062c3b3          	xor	x7,x5,x6
     a8c:	fff00e13          	li	x28,-1
     a90:	03c39663          	bne	x7,x28,0xabc
     a94:	aaaab2b7          	lui	x5,0xaaaab
     a98:	aaa28293          	addi	x5,x5,-1366 # 0xaaaaaaaa
     a9c:	0052c3b3          	xor	x7,x5,x5
     aa0:	00039e63          	bnez	x7,0xabc
     aa4:	000ff297          	auipc	x5,0xff
     aa8:	55c28293          	addi	x5,x5,1372 # 0x100000
     aac:	0002a303          	lw	x6,0(x5)
     ab0:	00130313          	addi	x6,x6,1
     ab4:	0062a023          	sw	x6,0(x5)
     ab8:	00008067          	ret
     abc:	000ff297          	auipc	x5,0xff
     ac0:	54828293          	addi	x5,x5,1352 # 0x100004
     ac4:	0002a303          	lw	x6,0(x5)
     ac8:	00130313          	addi	x6,x6,1
     acc:	0062a023          	sw	x6,0(x5)
     ad0:	00008067          	ret
     ad4:	0000b2b7          	lui	x5,0xb
     ad8:	aaa28293          	addi	x5,x5,-1366 # 0xaaaa
     adc:	5552c313          	xori	x6,x5,1365
     ae0:	0000b3b7          	lui	x7,0xb
     ae4:	fff38393          	addi	x7,x7,-1 # 0xafff
     ae8:	02731663          	bne	x6,x7,0xb14
     aec:	00400293          	li	x5,4
     af0:	2342c313          	xori	x6,x5,564
     af4:	23000393          	li	x7,560
     af8:	00731e63          	bne	x6,x7,0xb14
     afc:	000ff297          	auipc	x5,0xff
     b00:	50428293          	addi	x5,x5,1284 # 0x100000
     b04:	0002a303          	lw	x6,0(x5)
     b08:	00130313          	addi	x6,x6,1
     b0c:	0062a023          	sw	x6,0(x5)
     b10:	00008067          	ret
     b14:	000ff297          	auipc	x5,0xff
     b18:	4f028293          	addi	x5,x5,1264 # 0x100004
     b1c:	0002a303          	lw	x6,0(x5)
     b20:	00130313          	addi	x6,x6,1
     b24:	0062a023          	sw	x6,0(x5)
     b28:	00008067          	ret
     b2c:	00100293          	li	x5,1
     b30:	00300313          	li	x6,3
     b34:	006293b3          	sll	x7,x5,x6
     b38:	00800e13          	li	x28,8
     b3c:	03c39863          	bne	x7,x28,0xb6c
     b40:	00100293          	li	x5,1
     b44:	01f00313          	li	x6,31
     b48:	006293b3          	sll	x7,x5,x6
     b4c:	80000e37          	lui	x28,0x80000
     b50:	01c39e63          	bne	x7,x28,0xb6c
     b54:	000ff297          	auipc	x5,0xff
     b58:	4ac28293          	addi	x5,x5,1196 # 0x100000
     b5c:	0002a303          	lw	x6,0(x5)
     b60:	00130313          	addi	x6,x6,1
     b64:	0062a023          	sw	x6,0(x5)
     b68:	00008067          	ret
     b6c:	000ff297          	auipc	x5,0xff
     b70:	49828293          	addi	x5,x5,1176 # 0x100004
     b74:	0002a303          	lw	x6,0(x5)
     b78:	00130313          	addi	x6,x6,1
     b7c:	0062a023          	sw	x6,0(x5)
     b80:	00008067          	ret
     b84:	00100293          	li	x5,1
     b88:	00429313          	slli	x6,x5,0x4
     b8c:	01000393          	li	x7,16
     b90:	02731663          	bne	x6,x7,0xbbc
     b94:	00100293          	li	x5,1
     b98:	01f29313          	slli	x6,x5,0x1f
     b9c:	800003b7          	lui	x7,0x80000
     ba0:	00731e63          	bne	x6,x7,0xbbc
     ba4:	000ff297          	auipc	x5,0xff
     ba8:	45c28293          	addi	x5,x5,1116 # 0x100000
     bac:	0002a303          	lw	x6,0(x5)
     bb0:	00130313          	addi	x6,x6,1
     bb4:	0062a023          	sw	x6,0(x5)
     bb8:	00008067          	ret
     bbc:	000ff297          	auipc	x5,0xff
     bc0:	44828293          	addi	x5,x5,1096 # 0x100004
     bc4:	0002a303          	lw	x6,0(x5)
     bc8:	00130313          	addi	x6,x6,1
     bcc:	0062a023          	sw	x6,0(x5)
     bd0:	00008067          	ret
     bd4:	800002b7          	lui	x5,0x80000
     bd8:	01f00313          	li	x6,31
     bdc:	0062d3b3          	srl	x7,x5,x6
     be0:	00100e13          	li	x28,1
     be4:	03c39a63          	bne	x7,x28,0xc18
     be8:	fff00293          	li	x5,-1
     bec:	00400313          	li	x6,4
     bf0:	0062d3b3          	srl	x7,x5,x6
     bf4:	10000e37          	lui	x28,0x10000
     bf8:	fffe0e13          	addi	x28,x28,-1 # 0xfffffff
     bfc:	01c39e63          	bne	x7,x28,0xc18
     c00:	000ff297          	auipc	x5,0xff
     c04:	40028293          	addi	x5,x5,1024 # 0x100000
     c08:	0002a303          	lw	x6,0(x5)
     c0c:	00130313          	addi	x6,x6,1
     c10:	0062a023          	sw	x6,0(x5)
     c14:	00008067          	ret
     c18:	000ff297          	auipc	x5,0xff
     c1c:	3ec28293          	addi	x5,x5,1004 # 0x100004
     c20:	0002a303          	lw	x6,0(x5)
     c24:	00130313          	addi	x6,x6,1
     c28:	0062a023          	sw	x6,0(x5)
     c2c:	00008067          	ret
     c30:	800002b7          	lui	x5,0x80000
     c34:	01f2d313          	srli	x6,x5,0x1f
     c38:	00100393          	li	x7,1
     c3c:	02731863          	bne	x6,x7,0xc6c
     c40:	fff00293          	li	x5,-1
     c44:	0042d313          	srli	x6,x5,0x4
     c48:	100003b7          	lui	x7,0x10000
     c4c:	fff38393          	addi	x7,x7,-1 # 0xfffffff
     c50:	00731e63          	bne	x6,x7,0xc6c
     c54:	000ff297          	auipc	x5,0xff
     c58:	3ac28293          	addi	x5,x5,940 # 0x100000
     c5c:	0002a303          	lw	x6,0(x5)
     c60:	00130313          	addi	x6,x6,1
     c64:	0062a023          	sw	x6,0(x5)
     c68:	00008067          	ret
     c6c:	000ff297          	auipc	x5,0xff
     c70:	39828293          	addi	x5,x5,920 # 0x100004
     c74:	0002a303          	lw	x6,0(x5)
     c78:	00130313          	addi	x6,x6,1
     c7c:	0062a023          	sw	x6,0(x5)
     c80:	00008067          	ret
     c84:	fff00293          	li	x5,-1
     c88:	01f00313          	li	x6,31
     c8c:	4062d3b3          	sra	x7,x5,x6
     c90:	fff00e13          	li	x28,-1
     c94:	05c39263          	bne	x7,x28,0xcd8
     c98:	800002b7          	lui	x5,0x80000
     c9c:	01f00313          	li	x6,31
     ca0:	4062d3b3          	sra	x7,x5,x6
     ca4:	fff00e13          	li	x28,-1
     ca8:	03c39863          	bne	x7,x28,0xcd8
     cac:	010002b7          	lui	x5,0x1000
     cb0:	00400313          	li	x6,4
     cb4:	4062d3b3          	sra	x7,x5,x6
     cb8:	00100e37          	lui	x28,0x100
     cbc:	01c39e63          	bne	x7,x28,0xcd8
     cc0:	000ff297          	auipc	x5,0xff
     cc4:	34028293          	addi	x5,x5,832 # 0x100000
     cc8:	0002a303          	lw	x6,0(x5)
     ccc:	00130313          	addi	x6,x6,1
     cd0:	0062a023          	sw	x6,0(x5)
     cd4:	00008067          	ret
     cd8:	000ff297          	auipc	x5,0xff
     cdc:	32c28293          	addi	x5,x5,812 # 0x100004
     ce0:	0002a303          	lw	x6,0(x5)
     ce4:	00130313          	addi	x6,x6,1
     ce8:	0062a023          	sw	x6,0(x5)
     cec:	00008067          	ret
     cf0:	fff00293          	li	x5,-1
     cf4:	41f2d313          	srai	x6,x5,0x1f
     cf8:	fff00393          	li	x7,-1
     cfc:	02731663          	bne	x6,x7,0xd28
     d00:	800002b7          	lui	x5,0x80000
     d04:	41f2d313          	srai	x6,x5,0x1f
     d08:	fff00393          	li	x7,-1
     d0c:	00731e63          	bne	x6,x7,0xd28
     d10:	000ff297          	auipc	x5,0xff
     d14:	2f028293          	addi	x5,x5,752 # 0x100000
     d18:	0002a303          	lw	x6,0(x5)
     d1c:	00130313          	addi	x6,x6,1
     d20:	0062a023          	sw	x6,0(x5)
     d24:	00008067          	ret
     d28:	000ff297          	auipc	x5,0xff
     d2c:	2dc28293          	addi	x5,x5,732 # 0x100004
     d30:	0002a303          	lw	x6,0(x5)
     d34:	00130313          	addi	x6,x6,1
     d38:	0062a023          	sw	x6,0(x5)
     d3c:	00008067          	ret
     d40:	123452b7          	lui	x5,0x12345
     d44:	12345337          	lui	x6,0x12345
     d48:	00629e63          	bne	x5,x6,0xd64
     d4c:	000ff297          	auipc	x5,0xff
     d50:	2b428293          	addi	x5,x5,692 # 0x100000
     d54:	0002a303          	lw	x6,0(x5)
     d58:	00130313          	addi	x6,x6,1 # 0x12345001
     d5c:	0062a023          	sw	x6,0(x5)
     d60:	00008067          	ret
     d64:	000ff297          	auipc	x5,0xff
     d68:	2a028293          	addi	x5,x5,672 # 0x100004
     d6c:	0002a303          	lw	x6,0(x5)
     d70:	00130313          	addi	x6,x6,1
     d74:	0062a023          	sw	x6,0(x5)
     d78:	00008067          	ret
     d7c:	00000297          	auipc	x5,0x0
     d80:	00028293          	mv	x5,x5
     d84:	00000013          	nop
     d88:	00000013          	nop
     d8c:	00000317          	auipc	x6,0x0
     d90:	ff030313          	addi	x6,x6,-16 # 0xd7c
     d94:	00629e63          	bne	x5,x6,0xdb0
     d98:	000ff297          	auipc	x5,0xff
     d9c:	26828293          	addi	x5,x5,616 # 0x100000
     da0:	0002a303          	lw	x6,0(x5)
     da4:	00130313          	addi	x6,x6,1
     da8:	0062a023          	sw	x6,0(x5)
     dac:	00008067          	ret
     db0:	000ff297          	auipc	x5,0xff
     db4:	25428293          	addi	x5,x5,596 # 0x100004
     db8:	0002a303          	lw	x6,0(x5)
     dbc:	00130313          	addi	x6,x6,1
     dc0:	0062a023          	sw	x6,0(x5)
     dc4:	00008067          	ret
     dc8:	123452b7          	lui	x5,0x12345
     dcc:	68828293          	addi	x5,x5,1672 # 0x12345688
     dd0:	000ff317          	auipc	x6,0xff
     dd4:	23830313          	addi	x6,x6,568 # 0x100008
     dd8:	00532023          	sw	x5,0(x6)
     ddc:	00032383          	lw	x7,0(x6)
     de0:	12345e37          	lui	x28,0x12345
     de4:	688e0e13          	addi	x28,x28,1672 # 0x12345688
     de8:	01c39e63          	bne	x7,x28,0xe04
     dec:	000ff297          	auipc	x5,0xff
     df0:	21428293          	addi	x5,x5,532 # 0x100000
     df4:	0002a303          	lw	x6,0(x5)
     df8:	00130313          	addi	x6,x6,1
     dfc:	0062a023          	sw	x6,0(x5)
     e00:	00008067          	ret
     e04:	000ff297          	auipc	x5,0xff
     e08:	20028293          	addi	x5,x5,512 # 0x100004
     e0c:	0002a303          	lw	x6,0(x5)
     e10:	00130313          	addi	x6,x6,1
     e14:	0062a023          	sw	x6,0(x5)
     e18:	00008067          	ret
     e1c:	00008413          	mv	x8,x1
     e20:	010000ef          	jal	x1,0xe30
     e24:	00000297          	auipc	x5,0x0
     e28:	00509863          	bne	x1,x5,0xe38
     e2c:	0280006f          	j	0xe54
     e30:	00400313          	li	x6,4
     e34:	00008067          	ret
     e38:	000ff297          	auipc	x5,0xff
     e3c:	1cc28293          	addi	x5,x5,460 # 0x100004
     e40:	0002a303          	lw	x6,0(x5)
     e44:	00130313          	addi	x6,x6,1
     e48:	0062a023          	sw	x6,0(x5)
     e4c:	00040093          	mv	x1,x8
     e50:	00008067          	ret
     e54:	000ff297          	auipc	x5,0xff
     e58:	1ac28293          	addi	x5,x5,428 # 0x100000
     e5c:	0002a303          	lw	x6,0(x5)
     e60:	00130313          	addi	x6,x6,1
     e64:	0062a023          	sw	x6,0(x5)
     e68:	00040093          	mv	x1,x8
     e6c:	00008067          	ret
     e70:	000ff297          	auipc	x5,0xff
     e74:	19828293          	addi	x5,x5,408 # 0x100008
     e78:	00228303          	lb	x6,2(x5)
     e7c:	03400393          	li	x7,52
     e80:	02731463          	bne	x6,x7,0xea8
     e84:	00028303          	lb	x6,0(x5)
     e88:	f8800393          	li	x7,-120
     e8c:	00731e63          	bne	x6,x7,0xea8
     e90:	000ff297          	auipc	x5,0xff
     e94:	17028293          	addi	x5,x5,368 # 0x100000
     e98:	0002a303          	lw	x6,0(x5)
     e9c:	00130313          	addi	x6,x6,1
     ea0:	0062a023          	sw	x6,0(x5)
     ea4:	00008067          	ret
     ea8:	000ff297          	auipc	x5,0xff
     eac:	15c28293          	addi	x5,x5,348 # 0x100004
     eb0:	0002a303          	lw	x6,0(x5)
     eb4:	00130313          	addi	x6,x6,1
     eb8:	0062a023          	sw	x6,0(x5)
     ebc:	00008067          	ret
     ec0:	000ff297          	auipc	x5,0xff
     ec4:	14828293          	addi	x5,x5,328 # 0x100008
     ec8:	00429303          	lh	x6,4(x5)
     ecc:	ffffb3b7          	lui	x7,0xffffb
     ed0:	bcd38393          	addi	x7,x7,-1075 # 0xffffabcd
     ed4:	02731663          	bne	x6,x7,0xf00
     ed8:	00629303          	lh	x6,6(x5)
     edc:	000013b7          	lui	x7,0x1
     ee0:	23438393          	addi	x7,x7,564 # 0x1234
     ee4:	00731e63          	bne	x6,x7,0xf00
     ee8:	000ff297          	auipc	x5,0xff
     eec:	11828293          	addi	x5,x5,280 # 0x100000
     ef0:	0002a303          	lw	x6,0(x5)
     ef4:	00130313          	addi	x6,x6,1
     ef8:	0062a023          	sw	x6,0(x5)
     efc:	00008067          	ret
     f00:	000ff297          	auipc	x5,0xff
     f04:	10428293          	addi	x5,x5,260 # 0x100004
     f08:	0002a303          	lw	x6,0(x5)
     f0c:	00130313          	addi	x6,x6,1
     f10:	0062a023          	sw	x6,0(x5)
     f14:	00008067          	ret
     f18:	000ff297          	auipc	x5,0xff
     f1c:	0f028293          	addi	x5,x5,240 # 0x100008
     f20:	0082a303          	lw	x6,8(x5)
     f24:	556673b7          	lui	x7,0x55667
     f28:	78838393          	addi	x7,x7,1928 # 0x55667788
     f2c:	00731e63          	bne	x6,x7,0xf48
     f30:	000ff297          	auipc	x5,0xff
     f34:	0d028293          	addi	x5,x5,208 # 0x100000
     f38:	0002a303          	lw	x6,0(x5)
     f3c:	00130313          	addi	x6,x6,1
     f40:	0062a023          	sw	x6,0(x5)
     f44:	00008067          	ret
     f48:	000ff297          	auipc	x5,0xff
     f4c:	0bc28293          	addi	x5,x5,188 # 0x100004
     f50:	0002a303          	lw	x6,0(x5)
     f54:	00130313          	addi	x6,x6,1
     f58:	0062a023          	sw	x6,0(x5)
     f5c:	00008067          	ret
     f60:	000ff297          	auipc	x5,0xff
     f64:	0a828293          	addi	x5,x5,168 # 0x100008
     f68:	07f00313          	li	x6,127
     f6c:	00628623          	sb	x6,12(x5)
     f70:	00c28383          	lb	x7,12(x5)
     f74:	07f00e13          	li	x28,127
     f78:	05c39c63          	bne	x7,x28,0xfd0
     f7c:	07f00313          	li	x6,127
     f80:	006286a3          	sb	x6,13(x5)
     f84:	00d28383          	lb	x7,13(x5)
     f88:	07f00e13          	li	x28,127
     f8c:	05c39263          	bne	x7,x28,0xfd0
     f90:	07f00313          	li	x6,127
     f94:	00628723          	sb	x6,14(x5)
     f98:	00e28383          	lb	x7,14(x5)
     f9c:	07f00e13          	li	x28,127
     fa0:	03c39863          	bne	x7,x28,0xfd0
     fa4:	07f00313          	li	x6,127
     fa8:	006287a3          	sb	x6,15(x5)
     fac:	00f28383          	lb	x7,15(x5)
     fb0:	07f00e13          	li	x28,127
     fb4:	01c39e63          	bne	x7,x28,0xfd0
     fb8:	000ff297          	auipc	x5,0xff
     fbc:	04828293          	addi	x5,x5,72 # 0x100000
     fc0:	0002a303          	lw	x6,0(x5)
     fc4:	00130313          	addi	x6,x6,1
     fc8:	0062a023          	sw	x6,0(x5)
     fcc:	00008067          	ret
     fd0:	000ff297          	auipc	x5,0xff
     fd4:	03428293          	addi	x5,x5,52 # 0x100004
     fd8:	0002a303          	lw	x6,0(x5)
     fdc:	00130313          	addi	x6,x6,1
     fe0:	0062a023          	sw	x6,0(x5)
     fe4:	00008067          	ret
     fe8:	000ff297          	auipc	x5,0xff
     fec:	02028293          	addi	x5,x5,32 # 0x100008
     ff0:	00008337          	lui	x6,0x8
     ff4:	00130313          	addi	x6,x6,1 # 0x8001
     ff8:	00629823          	sh	x6,16(x5)
     ffc:	01029383          	lh	x7,16(x5)
    1000:	ffff8e37          	lui	x28,0xffff8
    1004:	001e0e13          	addi	x28,x28,1 # 0xffff8001
    1008:	03c39a63          	bne	x7,x28,0x103c
    100c:	10100313          	li	x6,257
    1010:	00629923          	sh	x6,18(x5)
    1014:	0102a383          	lw	x7,16(x5)
    1018:	01018e37          	lui	x28,0x1018
    101c:	001e0e13          	addi	x28,x28,1 # 0x1018001
    1020:	01c39e63          	bne	x7,x28,0x103c
    1024:	000ff297          	auipc	x5,0xff
    1028:	fdc28293          	addi	x5,x5,-36 # 0x100000
    102c:	0002a303          	lw	x6,0(x5)
    1030:	00130313          	addi	x6,x6,1
    1034:	0062a023          	sw	x6,0(x5)
    1038:	00008067          	ret
    103c:	000ff297          	auipc	x5,0xff
    1040:	fc828293          	addi	x5,x5,-56 # 0x100004
    1044:	0002a303          	lw	x6,0(x5)
    1048:	00130313          	addi	x6,x6,1
    104c:	0062a023          	sw	x6,0(x5)
    1050:	00008067          	ret
    1054:	000ff297          	auipc	x5,0xff
    1058:	fb428293          	addi	x5,x5,-76 # 0x100008
    105c:	0142c303          	lbu	x6,20(x5)
    1060:	0ff00393          	li	x7,255
    1064:	02731463          	bne	x6,x7,0x108c
    1068:	0152c303          	lbu	x6,21(x5)
    106c:	00000393          	li	x7,0
    1070:	00731e63          	bne	x6,x7,0x108c
    1074:	000ff297          	auipc	x5,0xff
    1078:	f8c28293          	addi	x5,x5,-116 # 0x100000
    107c:	0002a303          	lw	x6,0(x5)
    1080:	00130313          	addi	x6,x6,1
    1084:	0062a023          	sw	x6,0(x5)
    1088:	00008067          	ret
    108c:	000ff297          	auipc	x5,0xff
    1090:	f7828293          	addi	x5,x5,-136 # 0x100004
    1094:	0002a303          	lw	x6,0(x5)
    1098:	00130313          	addi	x6,x6,1
    109c:	0062a023          	sw	x6,0(x5)
    10a0:	00008067          	ret
    10a4:	000ff297          	auipc	x5,0xff
    10a8:	f6428293          	addi	x5,x5,-156 # 0x100008
    10ac:	0142d303          	lhu	x6,20(x5)
    10b0:	0ff00393          	li	x7,255
    10b4:	02731663          	bne	x6,x7,0x10e0
    10b8:	0162d303          	lhu	x6,22(x5)
    10bc:	000103b7          	lui	x7,0x10
    10c0:	f0038393          	addi	x7,x7,-256 # 0xff00
    10c4:	00731e63          	bne	x6,x7,0x10e0
    10c8:	000ff297          	auipc	x5,0xff
    10cc:	f3828293          	addi	x5,x5,-200 # 0x100000
    10d0:	0002a303          	lw	x6,0(x5)
    10d4:	00130313          	addi	x6,x6,1
    10d8:	0062a023          	sw	x6,0(x5)
    10dc:	00008067          	ret
    10e0:	000ff297          	auipc	x5,0xff
    10e4:	f2428293          	addi	x5,x5,-220 # 0x100004
    10e8:	0002a303          	lw	x6,0(x5)
    10ec:	00130313          	addi	x6,x6,1
    10f0:	0062a023          	sw	x6,0(x5)
    10f4:	00008067          	ret
    10f8:	00500293          	li	x5,5
    10fc:	00500313          	li	x6,5
    1100:	00628463          	beq	x5,x6,0x1108
    1104:	0280006f          	j	0x112c
    1108:	00100293          	li	x5,1
    110c:	00200313          	li	x6,2
    1110:	00628e63          	beq	x5,x6,0x112c
    1114:	000ff297          	auipc	x5,0xff
    1118:	eec28293          	addi	x5,x5,-276 # 0x100000
    111c:	0002a303          	lw	x6,0(x5)
    1120:	00130313          	addi	x6,x6,1
    1124:	0062a023          	sw	x6,0(x5)
    1128:	00008067          	ret
    112c:	000ff297          	auipc	x5,0xff
    1130:	ed828293          	addi	x5,x5,-296 # 0x100004
    1134:	0002a303          	lw	x6,0(x5)
    1138:	00130313          	addi	x6,x6,1
    113c:	0062a023          	sw	x6,0(x5)
    1140:	00008067          	ret
    1144:	00100293          	li	x5,1
    1148:	00200313          	li	x6,2
    114c:	00629463          	bne	x5,x6,0x1154
    1150:	0280006f          	j	0x1178
    1154:	00500293          	li	x5,5
    1158:	00500313          	li	x6,5
    115c:	00629e63          	bne	x5,x6,0x1178
    1160:	000ff297          	auipc	x5,0xff
    1164:	ea028293          	addi	x5,x5,-352 # 0x100000
    1168:	0002a303          	lw	x6,0(x5)
    116c:	00130313          	addi	x6,x6,1
    1170:	0062a023          	sw	x6,0(x5)
    1174:	00008067          	ret
    1178:	000ff297          	auipc	x5,0xff
    117c:	e8c28293          	addi	x5,x5,-372 # 0x100004
    1180:	0002a303          	lw	x6,0(x5)
    1184:	00130313          	addi	x6,x6,1
    1188:	0062a023          	sw	x6,0(x5)
    118c:	00008067          	ret
    1190:	fff00293          	li	x5,-1
    1194:	00000313          	li	x6,0
    1198:	0062c463          	blt	x5,x6,0x11a0
    119c:	0280006f          	j	0x11c4
    11a0:	00500293          	li	x5,5
    11a4:	00500313          	li	x6,5
    11a8:	0062ce63          	blt	x5,x6,0x11c4
    11ac:	000ff297          	auipc	x5,0xff
    11b0:	e5428293          	addi	x5,x5,-428 # 0x100000
    11b4:	0002a303          	lw	x6,0(x5)
    11b8:	00130313          	addi	x6,x6,1
    11bc:	0062a023          	sw	x6,0(x5)
    11c0:	00008067          	ret
    11c4:	000ff297          	auipc	x5,0xff
    11c8:	e4028293          	addi	x5,x5,-448 # 0x100004
    11cc:	0002a303          	lw	x6,0(x5)
    11d0:	00130313          	addi	x6,x6,1
    11d4:	0062a023          	sw	x6,0(x5)
    11d8:	00008067          	ret
    11dc:	00100293          	li	x5,1
    11e0:	fff00313          	li	x6,-1
    11e4:	0062d463          	bge	x5,x6,0x11ec
    11e8:	0280006f          	j	0x1210
    11ec:	00100293          	li	x5,1
    11f0:	00500313          	li	x6,5
    11f4:	0062de63          	bge	x5,x6,0x1210
    11f8:	000ff297          	auipc	x5,0xff
    11fc:	e0828293          	addi	x5,x5,-504 # 0x100000
    1200:	0002a303          	lw	x6,0(x5)
    1204:	00130313          	addi	x6,x6,1
    1208:	0062a023          	sw	x6,0(x5)
    120c:	00008067          	ret
    1210:	000ff297          	auipc	x5,0xff
    1214:	df428293          	addi	x5,x5,-524 # 0x100004
    1218:	0002a303          	lw	x6,0(x5)
    121c:	00130313          	addi	x6,x6,1
    1220:	0062a023          	sw	x6,0(x5)
    1224:	00008067          	ret
    1228:	fff00293          	li	x5,-1
    122c:	00500313          	li	x6,5
    1230:	00536463          	bltu	x6,x5,0x1238
    1234:	0280006f          	j	0x125c
    1238:	00500293          	li	x5,5
    123c:	00500313          	li	x6,5
    1240:	0062ee63          	bltu	x5,x6,0x125c
    1244:	000ff297          	auipc	x5,0xff
    1248:	dbc28293          	addi	x5,x5,-580 # 0x100000
    124c:	0002a303          	lw	x6,0(x5)
    1250:	00130313          	addi	x6,x6,1
    1254:	0062a023          	sw	x6,0(x5)
    1258:	00008067          	ret
    125c:	000ff297          	auipc	x5,0xff
    1260:	da828293          	addi	x5,x5,-600 # 0x100004
    1264:	0002a303          	lw	x6,0(x5)
    1268:	00130313          	addi	x6,x6,1
    126c:	0062a023          	sw	x6,0(x5)
    1270:	00008067          	ret
    1274:	00500293          	li	x5,5
    1278:	fff00313          	li	x6,-1
    127c:	00537c63          	bgeu	x6,x5,0x1294
    1280:	02c0006f          	j	0x12ac
    1284:	00500293          	li	x5,5
    1288:	00500313          	li	x6,5
    128c:	0062f463          	bgeu	x5,x6,0x1294
    1290:	01c0006f          	j	0x12ac
    1294:	000ff297          	auipc	x5,0xff
    1298:	d6c28293          	addi	x5,x5,-660 # 0x100000
    129c:	0002a303          	lw	x6,0(x5)
    12a0:	00130313          	addi	x6,x6,1
    12a4:	0062a023          	sw	x6,0(x5)
    12a8:	00008067          	ret
    12ac:	000ff297          	auipc	x5,0xff
    12b0:	d5828293          	addi	x5,x5,-680 # 0x100004
    12b4:	0002a303          	lw	x6,0(x5)
    12b8:	00130313          	addi	x6,x6,1
    12bc:	0062a023          	sw	x6,0(x5)
    12c0:	00008067          	ret
    12c4:	00008413          	mv	x8,x1
    12c8:	00000297          	auipc	x5,0x0
    12cc:	02028293          	addi	x5,x5,32 # 0x12e8
    12d0:	000280e7          	jalr	x5
    12d4:	00000e17          	auipc	x28,0x0
    12d8:	00800313          	li	x6,8
    12dc:	00639a63          	bne	x7,x6,0x12f0
    12e0:	01c09863          	bne	x1,x28,0x12f0
    12e4:	0280006f          	j	0x130c
    12e8:	00800393          	li	x7,8
    12ec:	00008067          	ret
    12f0:	000ff297          	auipc	x5,0xff
    12f4:	d1428293          	addi	x5,x5,-748 # 0x100004
    12f8:	0002a303          	lw	x6,0(x5)
    12fc:	00130313          	addi	x6,x6,1
    1300:	0062a023          	sw	x6,0(x5)
    1304:	00040093          	mv	x1,x8
    1308:	00008067          	ret
    130c:	000ff297          	auipc	x5,0xff
    1310:	cf428293          	addi	x5,x5,-780 # 0x100000
    1314:	0002a303          	lw	x6,0(x5)
    1318:	00130313          	addi	x6,x6,1
    131c:	0062a023          	sw	x6,0(x5)
    1320:	00040093          	mv	x1,x8
    1324:	00008067          	ret
    1328:	06054063          	bltz	x10,0x1388
    132c:	0605c663          	bltz	x11,0x1398
    1330:	00058613          	mv	x12,x11
    1334:	00050593          	mv	x11,x10
    1338:	fff00513          	li	x10,-1
    133c:	02060c63          	beqz	x12,0x1374
    1340:	00100693          	li	x13,1
    1344:	00b67a63          	bgeu	x12,x11,0x1358
    1348:	00c05863          	blez	x12,0x1358
    134c:	00161613          	slli	x12,x12,0x1
    1350:	00169693          	slli	x13,x13,0x1
    1354:	feb66ae3          	bltu	x12,x11,0x1348
    1358:	00000513          	li	x10,0
    135c:	00c5e663          	bltu	x11,x12,0x1368
    1360:	40c585b3          	sub	x11,x11,x12
    1364:	00d56533          	or	x10,x10,x13
    1368:	0016d693          	srli	x13,x13,0x1
    136c:	00165613          	srli	x12,x12,0x1
    1370:	fe0696e3          	bnez	x13,0x135c
    1374:	00008067          	ret
    1378:	00008293          	mv	x5,x1
    137c:	fb5ff0ef          	jal	x1,0x1330
    1380:	00058513          	mv	x10,x11
    1384:	00028067          	jr	x5
    1388:	40a00533          	neg	x10,x10
    138c:	00b04863          	bgtz	x11,0x139c
    1390:	40b005b3          	neg	x11,x11
    1394:	f9dff06f          	j	0x1330
    1398:	40b005b3          	neg	x11,x11
    139c:	00008293          	mv	x5,x1
    13a0:	f91ff0ef          	jal	x1,0x1330
    13a4:	40a00533          	neg	x10,x10
    13a8:	00028067          	jr	x5
    13ac:	00008293          	mv	x5,x1
    13b0:	0005ca63          	bltz	x11,0x13c4
    13b4:	00054c63          	bltz	x10,0x13cc
    13b8:	f79ff0ef          	jal	x1,0x1330
    13bc:	00058513          	mv	x10,x11
    13c0:	00028067          	jr	x5
    13c4:	40b005b3          	neg	x11,x11
    13c8:	fe0558e3          	bgez	x10,0x13b8
    13cc:	40a00533          	neg	x10,x10
    13d0:	f61ff0ef          	jal	x1,0x1330
    13d4:	40b00533          	neg	x10,x11
    13d8:	00028067          	jr	x5

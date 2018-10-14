0 rem !to "out/snek.prg"
10 gosub 10000
20 down=40:up=(-1)*down:right=1:left=(-1)*right:rem directions
23 hunger=0
24 df=25
25 rem 'hp'=head position, 'd'=direction, 'td'=tail direction
26 rem 'rg'=remaining growth, 'tp'=tail position
30 hp=500:tp=hp:d=left:dim td(1000):rg=4:sc=0
35 gosub 40000: gosub 50000
40 poke 1024+hp, 230 :rem draw head
45 if hp=tp and rg<1 then goto 55020
50 gosub 60000:gosub 60000
70 get k$ : if k$<>"" then gosub 20000
80 td(hp)=d
90 hp=hp+d : rem new head position
93 hunger=hunger+1
95 if peek(1024+hp)=42 then rg=rg+1: sc=sc+1: hunger=0: df=df-1: gosub 40000: gosub 50000
100 if rg=0 then gosub 30000
103 if hunger>df then gosub 30000: hunger=0
105 if rg>0 then rg=rg-1
110 if peek(1024+hp)=32 or peek (1024+hp)=42 goto 40

9000 bg=peek(53280)
9010 poke 53280, 2: gosub 60000
9020 poke 53280, 7: gosub 60000
9030 poke 53280, 2: gosub 60000
9040 poke 53280, bg
9050 goto 55020
9999 end
10000 rem *** clear screen, draw border ***
10005 print "{clr}{home}"
10010 ch=90
10015 for x=0 to 39
10020     poke 1024+x, ch
10025     poke 2023-x, ch
10030     gosub 60000
10035 next
10040 for x=1 to 23
10045     xx=40*x
10050     poke 1063+xx, ch
10055     poke 1984-xx, ch
10060     gosub 60000
10065 next
10070 return
20000 rem *** keyboard control ***
20010 if k$="a" or k$=chr$(157) then d=left
20020 if k$="w" or k$=chr$(145) then d=up
20030 if k$="s" or k$=chr$(17) then d=down
20040 if k$="d" or k$=chr$(29) then d=right
20050 return
30000 rem *** erase tail ***
30010 poke 1024+tp, 32 : rem erase tail
30020 tp=tp+td(tp)
30030 return
40000 rem *** add food ***
40010 fp=int(rnd(0)*1000)
40020 if peek(1024+fp)<>32 goto 40010
40030 poke 1024+fp,42
40040 return
50000 rem *** score ***
50010 poke 780,0: poke 781,0: poke 782,0: sys 65520
50020 print sc: poke 1024, ch
50025 if sc>869 goto 55000
50030 return
55000 rem *** game over! ***
55010 print "you win!"
55020 print "game over"
55020 end
60000 rem *** sleep ***
60010 for s=0 to 10:next
60020 return
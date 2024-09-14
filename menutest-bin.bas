#RetroDevStudio.MetaData.BASIC:7169,BASIC V7.0,uppercase,10,10
1 REM MENUTEST

# DISK-DRIVE
10 BANK15:DD=PEEK(186)


#11 BLOAD"VDCBASIC2D.0AC6",U(DD),B0:SYS DEC("AC6")
12 PRINT "FREEING UP BASIC RAM":GRAPHIC 1:GRAPHIC 0:GRAPHIC 5:PRINT ""CHR$(14);
13 COLOR6,16

# BASIC-END ADDRESS
14 BE=PEEK(4624)+PEEK(4625)*256

15 POKE 251,PEEK(4624):POKE 252,PEEK(4625)

17 BLOAD "VISUAL.BIN",B0

#18 RTV BE,12288,2048

# SET NR OF SCANLINES PER CHARACTER TO 10 AND ADJUST OTHER VALUES ACCORDINGLY (TO 320 SCANLINES TOTAL)
#19 RGW7,28:RGW4,31:RGW36,0:RGW9,9:RGW23,10:RGW11,15:RGW5,0:RGW29,8


21 FI$="MENU.DATA,P"

22 BLOAD (FI$),U(DD),P(BE+2),B0
23 BANK0:POKEBE,118:POKEBE+1,109:BANK15


#  RUN ML PROGRAMM FOR MENU
24 SYS DEC("1300"),PEEK(4624),PEEK(4625)
#25 PRINT "CHARSET LOCATION:"PEEK(DEC("02A1"))

39 GOTO 100



90 PRINT "NOT A VALID VM FILE":BANK15:END

99 BANK15:END

100 SYS DEC("1300"):GRAPHIC5:WINDOW 1,2,78,23,0

101 BANK0

105 REM PRINT "";
106 GOTO 154
#110 FOR I=DEC("84") TO DEC("89")
#120  PRINT HEX$(I)":"PEEK(I)
#129 NEXT


131 PRINT "MENUDATA-LENGTH $0312/$0313:"PEEK(DEC("312"))+PEEK(DEC("313"))*256
132 PRINT "TOPMENU-LENGTH $03E4:"PEEK(DEC("3E4"))
133 PRINT "TOPMENU-ENTRIES $03E5:"PEEK(DEC("3E5"))
134 PRINT "MENUSPEC $03E6/$03E7:"PEEK(DEC("3E6"))+PEEK(DEC("3E7"))*256
135 PRINT "TOPMENU SELECTED $03E8:"PEEK(DEC("3E8")):PRINT
136 PRINT "MENUENTRY SELECTED: $03E9"PEEK(DEC("3E9"))
137 PRINT "MENU ENTRIES: $03EA"PEEK(DEC("3EA"))
138 PRINT "MENU ENTRYLENGTH: $03EB"PEEK(DEC("3EB"))

139 PRINT "SAVERAM $03EC/$03ED:"PEEK(DEC("3EC"))+PEEK(DEC("3ED"))*256
140 PRINT "ATTRIBUTE-VRAM $03EE/$03EF:"PEEK(DEC("3EE"))+PEEK(DEC("3EF"))*256

141 PRINT "TEMP $FD:"PEEK(DEC("FD"))
142 PRINT "TEMP+1 $FE:"PEEK(DEC("FE"))
143 PRINT "MYSTACK $FA:"PEEK(DEC("FA"))
144 PRINT "MYSTACK2 $8F:"PEEK(DEC("8F"))
148 PRINT "ARG1="PEEK(DEC("84"))+PEEK(DEC("85"))*256
149 PRINT "ARG2="PEEK(DEC("86"))+PEEK(DEC("87"))*256
150 PRINT "ARG3="PEEK(DEC("88"))+PEEK(DEC("89"))*256
151 PRINT "ARG4="PEEK(DEC("8A"))
152 PRINT "ARG5="PEEK(DEC("8B"))
153 PRINT "ARG6="PEEK(DEC("8E"))

154 BANK 15

155 GETKEY I$

#156 SYS DEC("1303")
#157 GETKEY I$
#158 SYS DEC("1306")
#159 TS=TS+1:IF TS>2 THEN TS=0
#160 POKE 1000,TS
#161 GOTO 155

156 MS = PEEK(1000)<>255:REM PRINT "MENU-SHOWN:"MS

# MS=255 MEANS: NO MENU VISIBLE
157 IF MS THEN BEGIN

# 145=UP
#  17=DOWN
# 157=LEFT
#  29=RIGHT

160  IF ASC(I$)=157 THEN SYS DEC("1309")
161  IF ASC(I$)=29 THEN SYS DEC("130C")

162  IF ASC(I$)=17 THEN SYS DEC("130F")
163  IF ASC(I$)=145 THEN SYS DEC("1312")

164  IF I$=" " THEN SYS DEC("1306")

165  IF ASC(I$)=13 THEN GOTO 200

166 BEND
167 IF NOT MS THEN IF I$=" " THEN POKE1000,0:POKE1001,0:SYS DEC("1303")

174 GOTO 155


175 BANK15
179 PRINT "OOD YE!"
180 END


# HANDLE RETURN KEY ON OPEN MENU
#   TM:TOP-MENU   ME:MENU ENTRY
200 TM=PEEK(1000):ME=PEEK(1001)
205 SYSDEC("1306")
210 PRINT "TOP:"TM",ENTRY:"ME

212 IF TM=0 AND ME=0 THEN SYS DEC("1315")
214 IF TM=0 AND ME=1 THEN V1=PEEK(DEC("3FD")):V2=PEEK(DEC("3FE")):PRINT "3FD+="V1","V2":"V1+V2*256
216 IF TM=0 AND ME=2 THEN GOTO 105
220 IF TM=0 AND ME=5 THEN GOTO 175

222 IF TM=2 AND ME=0 THEN FAST
224 IF TM=2 AND ME=1 THEN SLOW

290 GOTO 155



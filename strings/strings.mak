CFG_DEPENDENCIES = strings.mak

!include "..\config.mak"

all : strings.h strings.err strings.lib

MMODEL = c

strings.h : default.lng fixstrs.exe
	fixstrs.exe /lib $(LNG)
	copy strings.h ..

strings.err : default.err critstrs.exe
	critstrs.exe $(LNG)

strings.lib: strings.h strings.err
	cd strings
	echo Making STRINGS library
	..\..\scripts\rmfiles $(CFG)
	$(CC) -c *.c
	..\..\scripts\rmfiles strings.lib
	$(AR) strings.lib /c @strings.rsp, strings.lst
	copy strings.lib ..
	copy strings.lst ..
	echo Purging temporary directory of strings library
	..\..\scripts\rmfiles strings.*	makefile errlist *.obj *.c
	cd ..
	rmdir strings

fixstrs.exe: $(CFG) fixstrs.c
	$(CC) -efixstrs.exe -m$(MMODEL) fixstrs.c

critstrs.exe: $(CFG) critstrs.c
	$(CC) -ecritstrs.exe -m$(MMODEL) critstrs.c

#		*Individual File Dependencies*
fixstrs.obj: $(CFG) fixstrs.c

critstrs.obj: $(CFG) critstrs.c

#///////////////////////////////////////////////////////////////////////////////
#//
#//  Makefile for the common libraries
#//
#///////////////////////////////////////////////////////////////////////////////

# primary dependencies

NAME       	 = Common
VERSION    	 = 1.0
PLATFORM  	:= $(shell uname -s)
PLMACH  	:= $(shell uname -m)
HERE      	:= $(shell /bin/pwd)
BINDIR    	:= ../bin/
LIBDIR    	:= ../lib/
INCDIR    	:= ../include/


# includes, flags and libraries
CINCS  	  	= -I$(INCDIR) -I./
ifeq ($(PLATFORM),Darwin)
    ifeq  ($(PLATFORM),x86_64)
        CARCH	= -m64 -mmacosx-version-min=10.5
    else
        CARCH	= -mmacosx-version-min=10.5
    endif
    LIBS	= -lm -lc
else
    CARCH	= 
    LIBS	= -lm -lc -lpthread
endif


all::	expat cfitsio curl

libs::
	(/bin/csh -f mklibs)
	(cd expat ; ./configure --prefix=${HERE}/.. ; $(MAKE) ; $(MAKE) installlib)

curl::
	(/bin/csh -f mklibs)

expat::
	(cd expat ; ./configure --prefix=${HERE}/.. ; $(MAKE) ; $(MAKE) installlib)

cfitsio::
	(cd cfitsio ; /bin/csh -f mklibs)

apps:

install:
ifndef HOST_CURL
	(if [ "${PLATFORM}" != "Darwin" ]; then (cd curl ; make install); fi)
endif
ifndef HOST_EXPAT
	(cd expat ; make install)
endif
	(/bin/rm -rf ../man ../share)

clean:
ifndef HOST_CURL
	(if [ "${PLATFORM}" != "Darwin" ]; then (cd curl ; make clean); fi)
endif
ifndef HOST_EXPAT
	(cd expat     	; make clean)
endif
ifndef HOST_CFITSIO
	(cd cfitsio   	; make clean)
endif

distclean:
ifndef HOST_CURL
	(if [ "${PLATFORM}" != "Darwin" ]; then (cd curl ; make distclean); fi)
endif
ifndef HOST_EXPAT
	(cd expat     	; make distclean)
endif
ifndef HOST_CFITSIO
	(cd cfitsio   	; make distclean)
endif


###############################################################################
# Leave this stuff alone.
###############################################################################

$(STATICLIB): $(SRCS:%.c=Static/%.o)
	/usr/bin/ar rv $@ $?
Static/%.o: %.c $(INCS)
	$(CC) $(CINCS) $(CFLAGS) -c $< -o $@
Static:
	/bin/mkdir $@
	chmod 777 $@

$(SHAREDLIB): $(SRCS:%.c=Shared/%.o)
	/usr/bin/ld -shared -o $@ $? -lc -ldl
Shared/%.o: %.c $(INCS)
	$(CC) $(CINCS) $(CFLAGS) -fpic -shared -c $< -o $@
Shared:
	/bin/mkdir $@
	chmod 777 $@

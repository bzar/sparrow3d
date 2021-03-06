#==Use if to slow!==
# -DFAST_BUT_UGLY <- could crash, uses possibly memory (just reading) Try always to have some border pixels to your textures if using!
# -DFAST_MULTIPLICATION <- looks good at small resolutions
# -DFAST_DIVISION <- looks good at small resolutions
#==stuff linked to
DYNAMIC = -lSDL_ttf -lSDL_image -lSDL -lm
#==global Flags. Even on the gp2x with 16 kb Cache, -O3 is much better then -Os
CFLAGS = -O3 -fsingle-precision-constant -fPIC 
CFLAGS_ASM = -O2 -fsingle-precision-constant -fPIC
GENERAL_TWEAKS = -ffast-math -fgcse-sm -fsched-spec-load -fmodulo-sched -fgcse-las -ftracer -funsafe-loop-optimizations -Wunsafe-loop-optimizations -fvariable-expansion-in-unroller
SMALL_RESOLUTION_DEVICES = -DFAST_MULTIPLICATION -DFAST_DIVISION
# some FPS values from my netbook @ 360 Mhz
# nothing special avg 46.0 peak 46.9
#-fgcse-las avg 46.0 peak 46.7
#-fgcse-sm avg 46.0 peak 46.3
#-fsched-spec-load avg 46.1 peak 46.6
#-fmodulo-sched avg 46.1 peak 46.6
#-funsafe-loop-optimizations -Wunsafe-loop-optimizations avg 46.0 peak 47.1
#-fvariable-expansion-in-unroller avg 46.5 peak 46.2
#-ftracer avg 47.2 peak 46.1
# all avg 46.7 peak 47.8
#==PC==
CPP = gcc -g -march=native -DX86CPU $(GENERAL_TWEAKS)
SDL = `sdl-config --cflags`
#==Consoles==
#==GP2X/WIZ==
ifeq ($(TARGET),open2x)
CPP = /opt/open2x/gcc-4.1.1-glibc-2.3.6/bin/arm-open2x-linux-gcc -DMOBILE_DEVICE -DARMCPU -DGP2X -DF100 $(GENERAL_TWEAKS) $(SMALL_RESOLUTION_DEVICES)
SDL = `/opt/open2x/gcc-4.1.1-glibc-2.3.6/bin/sdl-config --cflags` 
INCLUDE = -I/opt/open2x/gcc-4.1.1-glibc-2.3.6/include
LIB = -L/opt/open2x/gcc-4.1.1-glibc-2.3.6/lib -Wl,-rpath=/opt/open2x/gcc-4.1.1-glibc-2.3.6/lib
endif
ifeq ($(TARGET),gp2x)
CPP = /opt/open2x/gcc-4.1.1-glibc-2.3.6/bin/arm-open2x-linux-gcc -DMOBILE_DEVICE -DARMCPU -DGP2X -DF100 $(GENERAL_TWEAKS) $(SMALL_RESOLUTION_DEVICES)
STATIC = -Wl,-Bstatic -lSDL -lm -Wl,-Bdynamic
DYNAMIC = -lSDL_image -lSDL_ttf -lfreetype -lpng -lz -ljpeg
SDL = `/opt/open2x/gcc-4.1.1-glibc-2.3.6/bin/sdl-config --cflags`
INCLUDE = -I/opt/open2x/gcc-4.1.1-glibc-2.3.6/include
LIB = -L/opt/open2x/gcc-4.1.1-glibc-2.3.6/lib -Wl,-rpath=/opt/open2x/gcc-4.1.1-glibc-2.3.6/lib
endif
ifeq ($(TARGET),wiz)
CPP = /opt/open2x/gcc-4.1.1-glibc-2.3.6/bin/arm-open2x-linux-gcc -DMOBILE_DEVICE -DARMCPU -DGP2X -DWIZ $(GENERAL_TWEAKS) $(SMALL_RESOLUTION_DEVICES)
STATIC = -Wl,-Bstatic -lpng -Wl,-Bdynamic
DYNAMIC = -lSDL_ttf -lSDL_image -lSDL -lm
SDL = `/opt/open2x/gcc-4.1.1-glibc-2.3.6/bin/sdl-config --cflags`
INCLUDE = -I/opt/open2x/gcc-4.1.1-glibc-2.3.6/include
LIB = -L/opt/open2x/gcc-4.1.1-glibc-2.3.6/lib -Wl,-rpath=/opt/open2x/gcc-4.1.1-glibc-2.3.6/lib
endif
#==Caanoo==
ifeq ($(TARGET),caanoo)
CPP = /opt/caanoo/gcc-4.2.4-glibc-2.7-eabi/bin/arm-gph-linux-gnueabi-gcc -DMOBILE_DEVICE -DARMCPU -DCAANOO $(GENERAL_TWEAKS) $(SMALL_RESOLUTION_DEVICES)
SDL = -I/opt/caanoo/gcc-4.2.4-glibc-2.7-eabi/arm-gph-linux-gnueabi/sys-root/usr/include/SDL -D_GNU_SOURCE=1 -D_REENTRANT
INCLUDE = -I/opt/caanoo/gcc-4.2.4-glibc-2.7-eabi/arm-gph-linux-gnueabi/sys-root/usr/include
LIB = -L/opt/caanoo/gcc-4.2.4-glibc-2.7-eabi/arm-gph-linux-gnueabi/sys-root/usr/lib -Wl,-rpath=/opt/caanoo/gcc-4.2.4-glibc-2.7-eabi/arm-gph-linux-gnueabi/sys-root/usr/lib
endif
#==Dingux==
ifeq ($(TARGET),dingux)
CPP = /opt/opendingux-toolchain/usr/bin/mipsel-linux-gcc -DMOBILE_DEVICE -DDINGUX $(GENERAL_TWEAKS) $(SMALL_RESOLUTION_DEVICES)
SDL = -I/opt/opendingux-toolchain/usr/mipsel-unknown-linux-uclibc/sys-include/SDL -D_GNU_SOURCE=1 -D_REENTRANT
INCLUDE = -I/opt/opendingux-toolchain/usr/mipsel-unknown-linux-uclibc/sys-include
LIB = -L/opt/opendingux-toolchain/usr/lib -Wl,-rpath=/opt/opendingux-toolchain/usr/lib
endif
#==Pandora==
ifeq ($(TARGET),pandora)
#CPP = /opt/pandora/bin/arm-angstrom-linux-gnueabi-gcc -DARMCPU -DPANDORA $(GENERAL_TWEAKS)
#SDL = `/opt/pandora/bin/sdl-config --cflags`
#INCLUDE = -I/opt/pandora/arm-angstrom-linux-gnueabi/usr/include -I/opt/pandora/arm-angstrom-linux-gnueabi/usr/include/SDL
#LIB = -L/opt/pandora/arm-angstrom-linux-gnueabi/usr/lib -Wl,-rpath=/opt/pandora/arm-angstrom-linux-gnueabi/usr/lib
CPP = /opt/pandora/arm-2011.03/bin/arm-none-linux-gnueabi-gcc -DMOBILE_DEVICE -DARMCPU -DPANDORA $(GENERAL_TWEAKS)
SDL = `/opt/pandora/arm-2011.03/usr/bin/sdl-config --cflags`
INCLUDE = -I/opt/pandora/arm-2011.03/usr/include
LIB = -L/opt/pandora/arm-2011.03/usr/lib -Wl,-rpath=/opt/pandora/arm-2011.03/usr/lib
endif
#==Maemo 5==
ifeq ($(TARGET),maemo5)
CPP = gcc -DARMCPU -DMAEMO -DMAEMO5 $(GENERAL_TWEAKS)
SDL = `sdl-config --cflags`
endif
#==Maemo 6==
ifeq ($(TARGET),maemo6)
CPP = gcc -DARMCPU -DMAEMO -DMAEMO6 $(GENERAL_TWEAKS)
SDL = `sdl-config --cflags`
endif


all: sparrow3d testsparrow testsprite testmesh testtarget testtext

targets:
	@echo "gp2x, open2x (like gp2x, but dynamic compiled => smaller), wiz caanoo, dingux, pandora, maemo5, maemo6"

testsparrow: testsparrow.c sparrow3d
	$(CPP) $(CFLAGS) testsparrow.c $(SDL) $(INCLUDE) -L. $(LIB) $(STATIC) $(DYNAMIC) -lsparrow3d -o testsparrow

testsprite: testsprite.c sparrow3d
	$(CPP) $(CFLAGS) testsprite.c $(SDL) $(INCLUDE) -L. $(LIB) $(STATIC) $(DYNAMIC) -lsparrow3d -o testsprite

testmesh: testmesh.c sparrow3d
	$(CPP) $(CFLAGS) testmesh.c $(SDL) $(INCLUDE) -L. $(LIB) $(STATIC) $(DYNAMIC) -lsparrow3d -o testmesh

testtarget: testtarget.c sparrow3d
	$(CPP) $(CFLAGS) testtarget.c $(SDL) $(INCLUDE) -L. $(LIB) $(STATIC) $(DYNAMIC) -lsparrow3d -o testtarget

testtext: testtext.c sparrow3d
	$(CPP) $(CFLAGS) testtext.c $(SDL) $(INCLUDE) -L. $(LIB) $(STATIC) $(DYNAMIC) -lsparrow3d -o testtext

sparrow3d: sparrowCore.o sparrowMath.o sparrowPrimitives.o sparrowPrimitivesAsm.o sparrowRenderer.o sparrowFont.o sparrowMesh.o sparrowSprite.o sparrowText.o
	$(CPP) $(CFLAGS) -shared -Wl,-soname,libsparrow3d.so -rdynamic -o libsparrow3d.so sparrowFont.o sparrowCore.o sparrowMath.o sparrowPrimitives.o sparrowMesh.o sparrowSprite.o sparrowPrimitivesAsm.o sparrowRenderer.o sparrowText.o $(SDL) $(INCLUDE) $(LIB) $(STATIC) $(DYNAMIC)

sparrowCore.o: sparrowCore.c sparrowCore.h
	$(CPP) $(CFLAGS) -fPIC -c sparrowCore.c $(SDL) $(INCLUDE)

sparrowPrimitives.o: sparrowPrimitives.c sparrowPrimitives.h
	$(CPP) $(CFLAGS) -fPIC -c sparrowPrimitives.c $(SDL) $(INCLUDE)

sparrowPrimitivesAsm.o: sparrowPrimitivesAsm.c sparrowPrimitives.h
	$(CPP) $(CFLAGS) -fsingle-precision-constant -fPIC -c sparrowPrimitivesAsm.c $(SDL) $(INCLUDE)

sparrowRenderer.o: sparrowRenderer.c sparrowRenderer.h
	$(CPP) $(CFLAGS) -fPIC -c sparrowRenderer.c $(SDL) $(INCLUDE)

sparrowMath.o: sparrowMath.c sparrowMath.h
	$(CPP) $(CFLAGS) -fPIC -c sparrowMath.c $(SDL) $(INCLUDE)

sparrowFont.o: sparrowFont.c sparrowFont.h
	$(CPP) $(CFLAGS) -fPIC -c sparrowFont.c $(SDL) $(INCLUDE)

sparrowMesh.o: sparrowMesh.c sparrowMesh.h
	$(CPP) $(CFLAGS) -fPIC -c sparrowMesh.c $(SDL) $(INCLUDE)

sparrowSprite.o: sparrowSprite.c sparrowSprite.h
	$(CPP) $(CFLAGS) -fPIC -c sparrowSprite.c $(SDL) $(INCLUDE)

sparrowText.o: sparrowText.c sparrowText.h
	$(CPP) $(CFLAGS) -fPIC -c sparrowText.c $(SDL) $(INCLUDE)

clean:
	rm -f *.o
	rm -f libsparrow3d.so
	rm -f testsparrow
	rm -f testsprite
	rm -f testmesh

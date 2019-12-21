
ifeq '$(findstring ;,$(PATH))' ';'
    detected_OS := Windows
else
    detected_OS := $(shell uname 2>/dev/null || echo Unknown)
    detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
    detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
    detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif
CPPFLAGS = -DUNIX
ifeq ($(detected_OS),Windows)
    CPPFLAGS += -DCYGWIN
endif

all:

	mkdir -p tmp
	cp src/* tmp
	mkdir -p bin
	mkdir -p bin/gcc
	# g++ -Wall -std=c++0x -o bin/gcc/UCC $(CPPFLAGS) tmp/*.cpp
	g++ -Wall -std=c++11 -o bin/gcc/UCC $(CPPFLAGS) tmp/*.cpp
	rm -rf tmp

release:
	make all
	strip bin/gcc/UCC

install:
	cp bin/gcc/UCC /usr/bin
	chmod 755 /usr/bin/UCC


clean:
	-rm -rf bin/gcc
	-rm -rf tmp
	


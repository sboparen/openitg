#!/bin/bash
set -e
export CFLAGS="-m32"
export CXXFLAGS="-m32"
export CPPFLAGS="-m32 -fpermissive"
linux32 ./autogen.sh
linux32 ./configure --with-x --with-gnu-ld
sed -i src/Makefile -e 's$LUA_CFLAGS = .*$LUA_CFLAGS = -I/usr/include/lua5.1/$'
sed -i src/Makefile -e 's$LUA_LIBS = .*$LUA_LIBS = -llua5.1$'
sed -i src/Makefile -e 's/-Wl,-Bstatic $(LUA_LIBS) -Wl,-Bdynamic/$(LUA_LIBS)/'
linux32 make "$@"

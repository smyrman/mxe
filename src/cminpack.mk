# This file is part of MXE.
# See index.html for further information.

PKG             := cminpack
$(PKG)_IGNORE   :=
$(PKG)_CHECKSUM := 7a89a0c5c09585823ca4b11bc3eddb13df3fd0c3
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_FILE     := $(PKG)-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := http://devernay.free.fr/hacks/cminpack/$($(PKG)_FILE)
$(PKG)_DEPS     := gcc

define $(PKG)_UPDATE
    wget -q -O- 'http://devernay.free.fr/hacks/cminpack/cminpack.html' | \
    $(SED) -n 's,.*cminpack-\([0-9.]*\)\.tar.*,\1,p' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(1)' && cmake \
        -DCMAKE_TOOLCHAIN_FILE='$(CMAKE_TOOLCHAIN_FILE)'
    $(MAKE) -C '$(1)' -j $(JOBS)

    $(INSTALL) -d                         '$(PREFIX)/$(TARGET)/lib'
    $(INSTALL) -m644 '$(1)/libcminpack.a' '$(PREFIX)/$(TARGET)/lib/'
    $(INSTALL) -d                         '$(PREFIX)/$(TARGET)/include'
    $(INSTALL) -m644 '$(1)/cminpack.h'    '$(PREFIX)/$(TARGET)/include/'
endef
# sysroot changes for local development. Not used by Yocto.
include(../local_conf.pri): {
QMAKE_CFLAGS -= --sysroot=$$[QT_SYSROOT]
QMAKE_CFLAGS += --sysroot=$${YOCTO_BUILD_DIR}/tmp/sysroots/apalis-imx6
QMAKE_CXXFLAGS -= --sysroot=$$[QT_SYSROOT]
QMAKE_CXXFLAGS += --sysroot=$${YOCTO_BUILD_DIR}/tmp/sysroots/apalis-imx6
QMAKE_LFLAGS -= --sysroot=$$[QT_SYSROOT]
QMAKE_LFLAGS += --sysroot=$${YOCTO_BUILD_DIR}/tmp/sysroots/apalis-imx6
INCLUDEPATH += $${YOCTO_BUILD_DIR}/tmp/sysroots/apalis-imx6/usr/include
}

QT += network
QT -= gui

include(version.pri)

TARGET = pubnubhandler

pkgconfig.path = $$[QT_INSTALL_LIBS]/pubnubhandler

TEMPLATE = lib

DEFINES += PUBNUBHANDLER_LIBRARY

isEmpty(PREFIX) {
    PREFIX=/usr
}

OTHER_FILES += \
    version.pri \
    src/pubnubhandler.prf

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

INCLUDEPATH += \
    include \
    src \
    src/c-core/core \
    src/c-core/qt

#DEPENDPATH += \
#    src/c-core/core

# Public headers
PUBLIC_HEADERS += \
    include/pubnubhandler.h \
    include/pubnubhandler_global.h \
    include/pubnubsubscriber.h


# Spiri PubNub handling
SPIRI_SOURCES += \
    src/pubnubchannel.cpp \
    src/pubnubhandler.cpp

SPIRI_HEADERS += \
    src/pubnubchannel.h


# PubNub Qt wrapper
PN_SOURCES +=  \
    src/c-core/qt/pubnub_qt.cpp \
    src/c-core/core/pubnub_ccore.c \
    src/c-core/core/pubnub_assert_std.c \
    src/c-core/core/pubnub_json_parse.c \
    src/c-core/core/pubnub_helper.c

PN_HEADERS += \
    src/c-core/qt/pubnub_config.h \
    src/c-core/qt/pubnub_internal.h \
    src/c-core/qt/pubnub_qt.h

SOURCES += \
    $$SPIRI_SOURCES \
    $$PN_SOURCES

HEADERS += \
    $$PUBLIC_HEADERS \
    $$SPIRI_HEADERS \
    $$PN_HEADERS

headers.path = $$INSTALL_ROOT$$PREFIX/include/pubnubhandler
qtconfig.path = $$[QT_INSTALL_PREFIX]/share/qt5/mkspecs/features
qtconfig.files = pubnubhandler.prf
pkgconfig.files = pubnubhandler.pc

target.path = $$[QT_INSTALL_LIBS]
headers.files = $$PUBLIC_HEADERS

CONFIG += create_pc create_prl link_pkgconfig

QMAKE_PKGCONFIG_DESTDIR = pkgconfig
QMAKE_PKGCONFIG_INCDIR = $$headers.path

INSTALLS += target headers qtconfig pkgconfig

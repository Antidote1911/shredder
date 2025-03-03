QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

CONFIG += c++20

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    Config.cpp \
    PasswordGenerator.cpp \
    PasswordHealth.cpp \
    Random.cpp \
    main.cpp \
    widget.cpp \
    Clipboard.cpp \
    zxcvbn/zxcvbn.cpp

HEADERS += \
    Config.h \
    Global.h \
    PasswordGenerator.h \
    PasswordHealth.h \
    Random.h \
    widget.h \
    Clipboard.h \
    zxcvbn/dict-src.h \
    zxcvbn/zxcvbn.h

FORMS += \
    widget.ui
    
RESOURCES += \
    rsc.qrc

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

LIBS += -lbotan-3
INCLUDEPATH += "/usr/include/botan-3"

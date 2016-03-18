
TEMPLATE = app

QT += qml quick widgets  sensors svg xml  gui multimedia concurrent declarative

SOURCES += main.cpp \
    DBMeter.cpp

RESOURCES += qml.qrc


#ios: {
#    QMAKE_INFO_PLIST = $$PWD/hitokoto-Info.plist
#    QTPLUGIN +=  qsvg
#    OTHER_FILES += hitokoto-Info.plist
#    icons.files += gfx/btn.png
#    QMAKE_BUNDLE_DATA += icons
#}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \
    qml/hitokoto/main.js \
    qml/hitokoto/fontawesome.js \
    qml/hitokoto/main.qml \
    qml/hitokoto/Signalcenter.qml \
    qml/hitokoto/DBMeterController.qml \
    qml/hitokoto/gfx.jpg \
    qml/hitokoto/fontawesome-webfont.ttf \
    qml/hitokoto/Themex.qml

HEADERS += \
    DBMeter.hpp


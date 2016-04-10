TEMPLATE = app

QT += qml quick widgets  sensors svg xml  gui multimedia concurrent declarative

CONFIG += c++11

SOURCES += main.cpp 

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


DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/res/values/strings.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    qml/DBMeterController.qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

HEADERS += \
    DBMeter.hpp

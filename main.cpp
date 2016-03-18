#include <QApplication>
#include <QQmlApplicationEngine>
#include "DBMeter.hpp"
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeItem>
#include <QtDeclarative/qdeclarative.h>
int main(int argc, char *argv[])
{
    qmlRegisterType<DBMeter>("harbour.saildbmeter.dbmeter", 1, 0, "DBMeter");
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///qml/hitokoto/main.qml")));

    return app.exec();
}

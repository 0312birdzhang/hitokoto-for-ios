#include <QApplication>
#include <QQmlApplicationEngine>
#include "DBMeter.hpp"
//#include <QtDeclarative>
#include <QQuickItem>
int main(int argc, char *argv[])
{

    QApplication app(argc, argv);
    qmlRegisterType<DBMeter>("harbour.saildbmeter.dbmeter", 1, 0, "DBMeter");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:///qml/hitokoto/main.qml")));
    return app.exec();
}

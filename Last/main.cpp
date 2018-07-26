#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "colorcontroller.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QScopedPointer<ColorController> ptr(new ColorController());
    engine.rootContext()->setContextProperty("ColorController",ptr.data());

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

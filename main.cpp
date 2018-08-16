#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <utils.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling, true);
    QCoreApplication::setAttribute(Qt::AA_UseHighDpiPixmaps, true);

    QGuiApplication app(argc, argv);
    QGuiApplication::setApplicationName("Photon");
    QGuiApplication::setApplicationVersion("0.1.0");
    QGuiApplication::setOrganizationName("Enclave Software");

    qmlRegisterType<Utils>("com.benstein.utils", 1, 0, "Utils");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}

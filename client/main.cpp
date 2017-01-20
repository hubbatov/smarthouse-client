#include <QGuiApplication>
#include <QCommandLineOption>
#include <QCommandLineParser>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;

	QCommandLineParser parser;
	parser.setApplicationDescription("Smarthouse client");

	QCommandLineOption testingOption(QStringList() << "testing", "Run programm in testing mode");
	parser.addOption(testingOption);

	parser.process(app);

	if(parser.isSet(testingOption))
		engine.load(QUrl(QStringLiteral("qrc:/qml/test.qml")));
	else
		engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

	return app.exec();
}

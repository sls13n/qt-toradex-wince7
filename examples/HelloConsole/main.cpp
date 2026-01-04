#include <QCoreApplication>
#include <QTextStream>

int main(int argc, char *argv[])
{
    QCoreApplication app(argc, argv);
    
    QTextStream out(stdout);
    out << "Hello World" << endl;
    
    return 0;
}

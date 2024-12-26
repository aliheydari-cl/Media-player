#include "database.h"

database::database(QObject *parent)
    : QObject{parent}
{
    db = QSqlDatabase::addDatabase("QSQLITE");

    QString fileName = QCoreApplication::applicationDirPath() + "/mediaPlayer.db";
    db.setDatabaseName(fileName);
    db.open();

    QSqlQuery query;

    query.exec("CREATE TABLE playList (path TEXT)");
}

database::~database()
{
    db.close();
}

void database::addToDatabase(QString path)
{
    QSqlQuery q;
    q.prepare("INSERT INTO playList (path) VALUES (:path)");
    q.bindValue(":path", path);

    q.exec();
}

void database::getDatabase()
{
    QStringList temp;
    QSqlQuery q;

    q.exec("SELECT path FROM playList");

    while(q.next())
        temp.append(q.value(0).toString());

    if(cppPlaylist != temp)
        setCppPlaylist(temp);
}

QStringList database::getCppPlaylist() const
{
    return cppPlaylist;
}

void database::setCppPlaylist(const QStringList &newCppPlaylist)
{
    cppPlaylist = newCppPlaylist;
}

void database::deleteFromDatabase(QString path)
{
    QSqlQuery q;
    q.prepare("DELETE FROM playList WHERE path = :path");
    q.bindValue(":path", path);

    q.exec();
}

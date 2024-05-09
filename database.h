#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QtCore>


class database : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList playlist READ getCppPlaylist WRITE setCppPlaylist NOTIFY playlistChanged)

public:
    explicit database(QObject *parent = nullptr);
    ~database();

public slots:

    void addToDatabase(QString);
    void deleteFromDatabase(QString);
    void getDatabase();

    QStringList getCppPlaylist() const;
    void setCppPlaylist(const QStringList &newCppPlaylist);

signals:
    void playlistChanged();

private:
    QSqlDatabase db;
    QStringList cppPlaylist;
};

#endif

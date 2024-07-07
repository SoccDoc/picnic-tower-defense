#ifndef FROGTOWER_H
#define FROGTOWER_H

#include <QObject>
#include <QtQuick>

class FrogTower
{
    Q_OBJECT
    Q_PROPERTY(int x READ X WRITE setX NOTIFY xChanged)
    Q_PROPERTY(int y READ Y WRITE setY NOTIFY yChanged)

public:
    FrogTower();

    void setX(const int newX);
    void setY(const int newY);

    QColor X() const;
    QColor Y() const;

signals:
    void xChanged();
    void yChanged();

public slots:
    void moveImage(QMouseEvent mouse);
    void setImage(QMouseEvent mouse);

private:
    int x, y;
};

#endif // FROGTOWER_H

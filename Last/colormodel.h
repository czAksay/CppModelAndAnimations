#ifndef COLORMODEL_H
#define COLORMODEL_H

#include <QObject>
#include <QColor>
#include <QAbstractListModel>

struct MyColor {
    QString name;
    QColor color;
};

class ColorModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles {
        TextRole = Qt::UserRole + 1,
        ColorRole
    };

    ColorModel(QObject *parent = Q_NULLPTR);

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual QModelIndex index(int row, int column, const QModelIndex &parent) const;
    virtual int columnCount(const QModelIndex &parent) const;
    QHash<int, QByteArray> roleNames() const;

    void add(MyColor color);
    void add(QString name, QColor color);
    void add(QString name, int r, int g, int b, int a);
    void remove(int index);
    void move(int old_index, int new_index);

    Q_INVOKABLE int getA() {return 11;}
private:
    QList<MyColor> m_colors;
};

#endif // COLORMODEL_H

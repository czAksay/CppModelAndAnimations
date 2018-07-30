#include "colormodel.h"
#include <QDebug>

ColorModel::ColorModel(QObject *parent) : QAbstractListModel(parent)
{
    add("Синий", QColor(0,0,255));
    add("Красный", QColor(255,0,0));
    add("Зеленый", QColor(0,255,0));
    add("Желтый", QColor(255,255,0));
    add("Фиолетовый", QColor(139,0,105));
    add("Черный", QColor(0,0,0));
    add("Белый", QColor(255,255,255));
    add("Серый", QColor(128,128,128));
    add("Оранжевый", QColor(255,165,0));
    m_colors.move(0,1);
}

void ColorModel::add(MyColor color)
{
    beginInsertRows(QModelIndex(), m_colors.size(), m_colors.size());
    m_colors.append(color);
    endInsertRows();
}

void ColorModel::add(QString name, QColor color)
{
    MyColor adding = {name, color};
    add(adding);
}

void ColorModel::add(QString name, int r, int g, int b, int a)
{
    MyColor adding = {name, QColor(r,g,b,a)};
    add(adding);
}

void ColorModel::remove(int index)
{
    if(!hasIndex(index,0))
    {
        return;
    }
    beginRemoveRows(QModelIndex(),index, index);
    m_colors.removeAt(index);
    endRemoveRows();
}

void ColorModel::move(int old_index, int new_index)
{
    if(hasIndex(old_index, 0) && hasIndex(new_index, 0) && (old_index != new_index))
    {
        QModelIndex parent;
        //если это предпоследний элемент, перемещаемый на 1 вниз
        if (new_index == rowCount() - 1 && new_index == old_index + 1)
        {
            int tmp = new_index;
            new_index = old_index;
            old_index = tmp;
        }
        //при перемещении вниз
        if (new_index > old_index)
            new_index ++;
        if(beginMoveRows(parent, old_index, old_index, parent, new_index))
        {
            m_colors.move(old_index, new_index);
            endMoveRows();
        }
    }
}

QHash<int, QByteArray> ColorModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[ColorRole] = "mColor";
    roles[TextRole] = "mText";

    return roles;
}

int ColorModel::rowCount(const QModelIndex &parent) const
{
    return m_colors.size();
}

QVariant ColorModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case TextRole:
        return m_colors.at(index.row()).name;
        break;
    case ColorRole:
        return m_colors.at(index.row()).color;
        break;
    default:
        break;
    }
    return QVariant();
}

QModelIndex ColorModel::index(int row, int column, const QModelIndex &parent) const
{
    return createIndex(row, column);
}

int ColorModel::columnCount(const QModelIndex &parent) const
{
    return 1;
}

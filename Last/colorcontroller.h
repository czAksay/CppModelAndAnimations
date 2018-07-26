#ifndef COLORCONTROLLER_H
#define COLORCONTROLLER_H

#include <QObject>
#include <QDebug>
#include "colormodel.h"

class ColorController : public QObject
{
    Q_OBJECT
public:
    ColorController(QObject *parent = Q_NULLPTR);
    ~ColorController();

    Q_PROPERTY(ColorModel* model READ model WRITE setModel NOTIFY modelChanged)

    Q_INVOKABLE void remove(int index);
    Q_INVOKABLE void add(QString name, QColor color);
    Q_INVOKABLE void move(int index, int new_index);

    Q_INVOKABLE int getR(QColor color);
    Q_INVOKABLE int getG(QColor color);
    Q_INVOKABLE int getB(QColor color);
    Q_INVOKABLE int getA(QColor color);
    Q_INVOKABLE int getColorChannel(QColor color, int channelNumber);

    ColorModel* model() const
    {
        return m_model;
    }

public slots:

    void setModel(ColorModel* model)
    {
        if (m_model == model)
            return;
        m_model = model;
        emit modelChanged(m_model);
    }

signals:
    void modelChanged(ColorModel* model);

private:
    ColorModel* m_model;
};

#endif // COLORCONTROLLER_H

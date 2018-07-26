#include "colorcontroller.h"

ColorController::ColorController(QObject *parent) : QObject(parent)//, m_model(new ColorModel())
{
    m_model = new ColorModel();
}

ColorController::~ColorController()
{
    delete m_model;
}

void ColorController::remove(int index)
{
    m_model->remove(index);
}

void ColorController::add(QString name, QColor color)
{
    m_model->add(name, color);
}

void ColorController::move(int index, int new_index)
{
    m_model->move(index, new_index);
}

int ColorController::getR(QColor color)
{
    return color.red();
}

int ColorController::getG(QColor color)
{
    return color.green();
}

int ColorController::getB(QColor color)
{
    return color.blue();
}

int ColorController::getA(QColor color)
{
    return color.alpha();
}

int ColorController::getColorChannel(QColor color, int channelNumber)
{
    switch(channelNumber)
    {
        case 0: return getR(color); break;
        case 1: return getG(color); break;
        case 2: return getB(color); break;
        case 3: return getA(color); break;
        default: return -1; break;
    }
}

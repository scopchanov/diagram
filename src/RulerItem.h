/**
MIT License

Copyright (c) 2020 Michael Scopchanov

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#ifndef RULERITEM_H
#define RULERITEM_H

#include <QQuickItem>

class RulerItemPrivate;
class RulerMark;

class RulerItem : public QQuickItem
{
	Q_OBJECT
	Q_PROPERTY(Qt::Orientation orientation READ orientation WRITE setOrientation
			   NOTIFY orientationChanged)
	Q_PROPERTY(qreal headroom READ headroom WRITE setHeadroom
			   NOTIFY headroomChanged)
	Q_PROPERTY(qreal implicitLength READ implicitLength WRITE setImplicitLength
			   NOTIFY implicitLengthChanged)
	Q_PROPERTY(qreal markInterval READ markInterval WRITE setMarkInterval
			   NOTIFY markIntervalChanged)
	Q_PROPERTY(qreal markOffset READ markOffset WRITE setMarkOffset
			   NOTIFY markOffsetChanged)
	Q_PROPERTY(qreal scrollPosition READ scrollPosition WRITE setScrollPosition
			   NOTIFY scrollPositionChanged)
	Q_PROPERTY(QVector<qreal> marks READ marks NOTIFY marksChanged)
	QML_ELEMENT
public:
	explicit RulerItem(QQuickItem *parent = nullptr);

	Qt::Orientation orientation() const;
	void setOrientation(Qt::Orientation orientation);
	qreal headroom() const;
	void setHeadroom(const qreal &headroom);
	qreal implicitLength() const;
	void setImplicitLength(qreal length);
	qreal markInterval() const;
	void setMarkInterval(qreal interval);
	qreal markOffset() const;
	void setMarkOffset(qreal offset);
	qreal scrollPosition() const;
	void setScrollPosition(qreal position);
	QVector<qreal> marks();

private:
	RulerItemPrivate *m_ptr;

signals:
	void orientationChanged();
	void headroomChanged();
	void implicitLengthChanged();
	void markIntervalChanged();
	void markOffsetChanged();
	void scrollPositionChanged();
	void marksChanged();
};

#endif // RULERITEM_H

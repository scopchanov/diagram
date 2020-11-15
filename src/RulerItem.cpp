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

#include "RulerItem.h"
#include "RulerItem_p.h"

RulerItem::RulerItem(QQuickItem *parent) :
	QQuickItem(parent),
	m_ptr(new RulerItemPrivate(this))
{

}

RulerItem::~RulerItem()
{
	delete m_ptr;
}

Qt::Orientation RulerItem::orientation() const
{
	return m_ptr->orientation;
}

void RulerItem::setOrientation(Qt::Orientation orientation)
{
	if (m_ptr->orientation == orientation)
		return;

	m_ptr->orientation = orientation;

	emit orientationChanged();
}

qreal RulerItem::headroom() const
{
	return m_ptr->headroom;
}

void RulerItem::setHeadroom(const qreal &headroom)
{
	if (m_ptr->headroom == headroom)
		return;

	m_ptr->headroom = headroom;

	emit headroomChanged();
}

qreal RulerItem::implicitLength() const
{
	return m_ptr->implicitLength;
}

void RulerItem::setImplicitLength(qreal length)
{
	if (m_ptr->implicitLength == length)
		return;

	m_ptr->implicitLength = length;

	emit implicitLengthChanged();

	m_ptr->updateMarks();
}

qreal RulerItem::markInterval() const
{
	return m_ptr->markInterval;
}

void RulerItem::setMarkInterval(qreal interval)
{
	Q_ASSERT(interval > 0);

	if (m_ptr->markInterval == interval)
		return;

	m_ptr->markInterval = interval;

	emit markIntervalChanged();

	m_ptr->updateMarks();
}

qreal RulerItem::markOffset() const
{
	return m_ptr->markOffset;
}

void RulerItem::setMarkOffset(qreal offset)
{
	if (m_ptr->markOffset == offset)
		return;

	m_ptr->markOffset = offset;

	emit markOffsetChanged();
}

qreal RulerItem::scrollPosition() const
{
	return m_ptr->scrollPosition;
}

void RulerItem::setScrollPosition(qreal position)
{
	if (m_ptr->scrollPosition == position)
		return;

	m_ptr->scrollPosition = position;

	emit scrollPositionChanged();
}

QVector<qreal> RulerItem::marks()
{
	return m_ptr->marks;
}

RulerItemPrivate::RulerItemPrivate(RulerItem *parent) :
    p_ptr(parent),
    orientation(Qt::Horizontal),
	headroom(0),
    implicitLength(0),
    markInterval(50),
	markOffset(0),
	scrollPosition(0)
{

}

void RulerItemPrivate::updateMarks()
{
	marks.clear();

	int N = calculateMarkCount();

	for (int n = 0; n < N; n++)
		marks.append(calculateMarkPosition(n));

	emit p_ptr->marksChanged();
}

qreal RulerItemPrivate::calculateMarkCount() const
{
	if (markInterval <= 0)
		return 0;

	return ceil(implicitLength/markInterval);
}

qreal RulerItemPrivate::calculateMarkPosition(qreal n) const
{
	return markInterval*n + markOffset;
}

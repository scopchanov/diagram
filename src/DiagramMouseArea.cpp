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

#include "DiagramMouseArea.h"
#include "DiagramMouseArea_p.h"
#include <QItemSelectionModel>
#include <QGuiApplication>
#include <QStyleHints>
#include <QCursor>

/*!
	\class DiagramMouseArea
	\inmodule Diagram
 */

DiagramMouseArea::DiagramMouseArea(QQuickItem *parent) :
	QQuickItem(parent),
	m_ptr(new DiagramMouseAreaPrivate(this))
{
	setAcceptedMouseButtons(Qt::LeftButton);
	setAcceptTouchEvents(false);
	setFiltersChildMouseEvents(true);
}

/*!
	\property DiagramMouseArea::scene
	\brief The scene which contains the diagram items.

	This property's default is nullptr.
*/

QQuickItem *DiagramMouseArea::scene() const
{
	return m_ptr->scene;
}

void DiagramMouseArea::setScene(QQuickItem *scene)
{
	if (m_ptr->scene == scene)
		return;

	m_ptr->scene = scene;

	emit sceneChanged();
}

/*!
	\property DiagramMouseArea::selectionModel
	\brief The model which contains the currenly selected diagram items.

	This property's default is nullptr.

	\sa selectionMode, selecting, selectionRectangle
*/

QItemSelectionModel *DiagramMouseArea::selectionModel() const
{
	return m_ptr->selectionModel;
}

void DiagramMouseArea::setSelectionModel(QItemSelectionModel *sm)
{
	if (m_ptr->selectionModel == sm)
		return;

	m_ptr->selectionModel = sm;

	emit selectionModelChanged();
}

/*!
	\property DiagramMouseArea::selectionMode
	\brief The selection mode of the rubber band when the user drags to select.

	This property's default is nullptr.

	\sa selectionModel, selecting, selectionRectangle
*/

Diagram::RubberBandSelectionMode DiagramMouseArea::selectionMode() const
{
	return m_ptr->selectionMode;
}

void DiagramMouseArea::setSelectionMode(Diagram::RubberBandSelectionMode mode)
{
	if (m_ptr->selectionMode == mode)
		return;

	m_ptr->selectionMode = mode;

	emit selectionModeChanged();
}

/*!
	\property DiagramMouseArea::selecting
	\brief Whether the user drags to select.

	This property's default is a nullptr.

	\sa selectionModel, selectionMode, selectionRectangle
*/

bool DiagramMouseArea::isSelecting() const
{
	return m_ptr->selecting;
}

/*!
	\property DiagramMouseArea::selectionRectangle
	\brief The selection rectangle when the user drags to select.

	This property's default is an empty rectangle.

	\sa selectionModel, selectionMode, selecting
*/

QRectF DiagramMouseArea::selectionRectangle() const
{
	return m_ptr->selectionRectangle;
}

/*!
	\property DiagramMouseArea::cursorShape
	\brief The shape of the cursor when it is over the mouse area.

	This property's default is Qt::ArrowCursor.
*/

Qt::CursorShape DiagramMouseArea::cursorShape() const
{
	return cursor().shape();
}

void DiagramMouseArea::setCursorShape(Qt::CursorShape shape)
{
	if (cursor().shape() == shape)
		return;

	QCursor newCursor(cursor());

	newCursor.setShape(static_cast<Qt::CursorShape>(shape));

	setCursor(newCursor);

	emit cursorShapeChanged();
}

/*!
	\property DiagramMouseArea::interactive
	\brief Whether the user can interact with the diagram with the mouse.

	This property's default is true.
*/

bool DiagramMouseArea::isInteractive() const
{
	return m_ptr->interactive;
}

void DiagramMouseArea::setInteractive(bool interactive)
{
	if (m_ptr->interactive == interactive)
		return;

	m_ptr->interactive = interactive;

	emit interactiveChanged();
}

/*!
	\reimp
 */

void DiagramMouseArea::mousePressEvent(QMouseEvent *event)
{
	QQuickItem::mousePressEvent(event);

	m_ptr->handlePressEvent(event);
}

/*!
	\reimp
 */

void DiagramMouseArea::mouseMoveEvent(QMouseEvent *event)
{
	QQuickItem::mouseMoveEvent(event);

	m_ptr->handleMoveEvent(event);
}

/*!
	\reimp
 */

void DiagramMouseArea::mouseReleaseEvent(QMouseEvent *event)
{
	QQuickItem::mouseReleaseEvent(event);

	m_ptr->handleReleaseEvent();
}

DiagramMouseAreaPrivate::DiagramMouseAreaPrivate(DiagramMouseArea *parent) :
	p_ptr(parent),
	scene(nullptr),
	selectionModel(nullptr),
	selectionMode(Diagram::SM_Contain),
	selecting(false),
	interactive(true)
{

}

void DiagramMouseAreaPrivate::handlePressEvent(QMouseEvent *event)
{
	if (!interactive || !scene || !selectionModel)
		return;

	const QPointF &scenePos(p_ptr->mapToItem(scene, event->pos()));
	auto *item = scene->childAt(scenePos.x(), scenePos.y());

	event->setAccepted(!item);

	if (item)
		selectItem(item, isShiftPressed(event));
	else
		dragOrigin = event->pos();
}

void DiagramMouseAreaPrivate::handleMoveEvent(QMouseEvent *event)
{
	if (!interactive || !scene || !selectionModel)
		return;

	if (!selecting && checkDragDistance(event->pos()))
		setSelecting(true);

	updateSelectionRectangle(event->pos());
	selectItems(isShiftPressed(event));
}

void DiagramMouseAreaPrivate::handleReleaseEvent()
{
	if (!interactive || !scene || !selectionModel)
		return;

	if (selecting)
		setSelecting(false);
	else
		clearSelection();
}

void DiagramMouseAreaPrivate::setSelecting(bool value)
{
	if (selecting == value)
		return;

	selecting = value;

	emit p_ptr->selectingChanged();
}

void DiagramMouseAreaPrivate::updateSelectionRectangle(const QPointF &dragPos)
{
	qreal x = qMin(dragOrigin.x(), dragPos.x());
	qreal y = qMin(dragOrigin.y(), dragPos.y());
	qreal width = qMax(dragOrigin.x(), dragPos.x()) - x;
	qreal height = qMax(dragOrigin.y(), dragPos.y()) - y;

	setSelectionRectangle(QRectF(x, y, width, height));
}

void DiagramMouseAreaPrivate::setSelectionRectangle(const QRectF &rect)
{
	if (selectionRectangle == rect)
		return;

	selectionRectangle = rect;

	emit p_ptr->selectionRectangleChanged();
}

void DiagramMouseAreaPrivate::selectItem(QQuickItem *item, bool append)
{
	if (!selectionModel)
		return;

	selectionModel->select(itemIndex(item), append
						   ? QItemSelectionModel::Toggle
						   : QItemSelectionModel::ClearAndSelect);
}

void DiagramMouseAreaPrivate::selectItems(bool append)
{
	if (!selectionModel)
		return;

	selectionModel->select(composeSelection(), append
						   ? QItemSelectionModel::Select
						   : QItemSelectionModel::ClearAndSelect);
}

void DiagramMouseAreaPrivate::clearSelection()
{
	if (!selectionModel)
		return;

	selectionModel->clearSelection();
}

QItemSelection DiagramMouseAreaPrivate::composeSelection()
{
	const QList<QQuickItem *> &diagramItems(scene->childItems());
	QItemSelection selection;

	for (auto *item : diagramItems)
		if (isInSelectionArea(item))
			selection.append(QItemSelectionRange(itemIndex(item)));

	return selection;
}

bool DiagramMouseAreaPrivate::isInSelectionArea(QQuickItem *item)
{
	const QRectF &selectionArea(p_ptr->mapRectToItem(scene, selectionRectangle));
	QRectF itemRect(item->position(), item->size());

	switch (selectionMode) {
	case Diagram::SM_Contain:
		return selectionArea.contains(itemRect);
		break;
	case Diagram::SM_Touch:
		return selectionArea.intersects(itemRect);
		break;
	default:
		return false;
	}
}

bool DiagramMouseAreaPrivate::checkDragDistance(const QPointF &dragPosition)
{
	return (dragOrigin - dragPosition).manhattanLength()
			>= QGuiApplication::styleHints()->startDragDistance();
}

QModelIndex DiagramMouseAreaPrivate::itemIndex(QQuickItem *item)
{
	return item->property("itemIndex").toModelIndex();
}

bool DiagramMouseAreaPrivate::isShiftPressed(QMouseEvent *event)
{
	return event->modifiers() & Qt::ShiftModifier;
}

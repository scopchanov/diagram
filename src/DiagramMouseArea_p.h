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

#ifndef DIAGRAMMOUSEAREA_P_H
#define DIAGRAMMOUSEAREA_P_H

#include "DiagramGlobal.h"
#include <QRectF>

class DiagramMouseArea;
class QQuickItem;
class QItemSelection;
class QItemSelectionModel;
class QMouseEvent;

class DiagramMouseAreaPrivate {

	Q_DISABLE_COPY(DiagramMouseAreaPrivate)

	explicit DiagramMouseAreaPrivate(DiagramMouseArea *parent);

	void handlePressEvent(QMouseEvent *event);
	void handleMoveEvent(QMouseEvent *event);
	void handleReleaseEvent();

	void setSelecting(bool value);
	void updateSelectionRectangle(const QPointF &dragPos);
	void setSelectionRectangle(const QRectF &rect);

	void selectItem(QQuickItem *item, bool append);
	void selectItems(bool append);
	void clearSelection();

	QItemSelection composeSelection();
	bool isInSelectionArea(QQuickItem *item);

	inline bool checkDragDistance(const QPointF &dragPosition);
	inline QModelIndex itemIndex(QQuickItem *item);
	inline bool isShiftPressed(QMouseEvent *event);

	DiagramMouseArea *p_ptr;
	QQuickItem *scene;
	QItemSelectionModel *selectionModel;
	Diagram::RubberBandSelectionMode selectionMode;
	QPointF dragOrigin;
	QRectF selectionRectangle;
	bool selecting;
	bool interactive;

	friend class DiagramMouseArea;
};

#endif // DIAGRAMMOUSEAREA_P_H

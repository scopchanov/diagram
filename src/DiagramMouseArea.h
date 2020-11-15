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

#ifndef DIAGRAMMOUSEAREA_H
#define DIAGRAMMOUSEAREA_H

#include <QQuickItem>
#include "DiagramGlobal.h"

class QItemSelectionModel;
class DiagramMouseAreaPrivate;

class DiagramMouseArea : public QQuickItem
{
	Q_OBJECT
	Q_PROPERTY(QQuickItem *scene READ scene WRITE setScene NOTIFY sceneChanged)
	Q_PROPERTY(QItemSelectionModel *selectionModel READ selectionModel
			   WRITE setSelectionModel NOTIFY selectionModelChanged)
	Q_PROPERTY(Diagram::RubberBandSelectionMode selectionMode READ selectionMode
			   WRITE setSelectionMode NOTIFY selectionModeChanged)
	Q_PROPERTY(bool selecting READ isSelecting NOTIFY selectingChanged)
	Q_PROPERTY(QRectF selectionRectangle READ selectionRectangle
			   NOTIFY selectionRectangleChanged)
	Q_PROPERTY(Qt::CursorShape cursorShape READ cursorShape WRITE setCursorShape
			   NOTIFY cursorShapeChanged)
	Q_PROPERTY(bool interactive READ isInteractive WRITE setInteractive
			   NOTIFY interactiveChanged)
	QML_ELEMENT
public:
	explicit DiagramMouseArea(QQuickItem *parent = nullptr);
	~DiagramMouseArea();

	QQuickItem *scene() const;
	void setScene(QQuickItem *scene);
	QItemSelectionModel *selectionModel() const;
	void setSelectionModel(QItemSelectionModel *sm);
	Diagram::RubberBandSelectionMode selectionMode() const;
	void setSelectionMode(Diagram::RubberBandSelectionMode mode);
	bool isSelecting() const;
	QRectF selectionRectangle() const;
	Qt::CursorShape cursorShape() const;
	void setCursorShape(Qt::CursorShape shape);
	bool isInteractive() const;
	void setInteractive(bool interactive);

protected:
	void mousePressEvent(QMouseEvent *event) override;
	void mouseMoveEvent(QMouseEvent *event) override;
	void mouseReleaseEvent(QMouseEvent *event) override;

private:
	DiagramMouseAreaPrivate *m_ptr;

signals:
	void sceneChanged();
	void selectionModelChanged();
	void selectionModeChanged();
	void selectingChanged();
	void selectionRectangleChanged();
	void cursorShapeChanged();
	void interactiveChanged();
};

#endif // DIAGRAMMOUSEAREA_H

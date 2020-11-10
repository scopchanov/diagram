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

#include "PixmapBuilder.h"
#include <QPainter>

PixmapBuilder::PixmapBuilder() :
	QQuickImageProvider(QQuickImageProvider::Pixmap)
{

}

QPixmap PixmapBuilder::requestPixmap(const QString &id, QSize *size,
									 const QSize &requestedSize)
{
	int width = 16;
	int height = 16;

	if (size)
		*size = QSize(width, height);

	const QStringList &source(id.split('/'));
	const QColor &color(source.last());
	QPixmap pixmap(requestedSize.width() > 0 ? requestedSize.width() : width,
				   requestedSize.height() > 0 ? requestedSize.height() : height);
	QPainter painter;
	QHash<QString, int> hash;
	int pixmapWidth = pixmap.width() - 1;
	int pixmapHeight = pixmap.height() - 1;

	pixmap.fill(Qt::transparent);

	painter.begin(&pixmap);

	hash.insert("hrule", PT_HRuler);
	hash.insert("vrule", PT_VRuler);
	hash.insert("dottedGrid", PT_DottedGrid);
	hash.insert("crossedGrid", PT_CrossedGrid);
	hash.insert("boxedGrid", PT_BoxedGrid);
	hash.insert("fancyGrid", PT_FancyGrid);

	switch (hash.value(source.first())) {
	case PT_HRuler:
		drawHRuler(&painter, color, pixmapWidth);
		break;
	case PT_VRuler:
		drawVRuler(&painter, color, pixmapHeight);
		break;
	case PT_DottedGrid:
		drawDottedGrid(&painter, color);
		break;
	case PT_CrossedGrid:
		drawCrossedGrid(&painter, color, pixmapWidth);
		break;
	case PT_BoxedGrid:
		drawBoxedGrid(&painter, color, pixmapWidth);
		break;
	case PT_FancyGrid:
		drawFancyGrid(&painter, color, pixmapWidth);
		break;
	}

	return pixmap;
}

void PixmapBuilder::drawHRuler(QPainter *painter, const QColor &color,
							   int width)
{
	int halfWidth = 0.5*width + 0.5;


	painter->setPen(QPen(color.lighter(135)));
	painter->drawLine(halfWidth, 14, halfWidth, width);
	painter->setPen(QPen(color));
	painter->drawLine(0, 14, width, 14);
	painter->drawLine(0, 14, 0, width);
}

void PixmapBuilder::drawVRuler(QPainter *painter, const QColor &color,
							   int height)
{
	int halfHeight = 0.5*height + 0.5;

	painter->setPen(QPen(color.lighter(135)));
	painter->drawLine(14, halfHeight, height, halfHeight);
	painter->setPen(color);
	painter->drawLine(14, 0, height, 0);
	painter->drawLine(14, 0, 14, height);
}

void PixmapBuilder::drawDottedGrid(QPainter *painter, const QColor &color)
{
	painter->setPen(color.darker(160));
	painter->drawPoint(0, 0);
}

void PixmapBuilder::drawCrossedGrid(QPainter *painter, const QColor &color,
									int width)
{
	painter->setPen(color);
	painter->drawLine(0, 0, 0.25*width, 0);
	painter->drawLine(0, 0, 0, 0.25*width);
	painter->drawLine(0, 0.75*width + 2, 0, width);
	painter->drawLine(0.75*width + 2, 0, width, 0);
}

void PixmapBuilder::drawBoxedGrid(QPainter *painter, const QColor &color,
								int width)
{
	painter->setPen(color);
	painter->drawLine(0, 0, width, 0);
	painter->drawLine(0, 0, 0, width);
}

void PixmapBuilder::drawFancyGrid(QPainter *painter, const QColor &color,
								  int width)
{
	int halfWidth = 0.5*width + 0.5;

	painter->setPen(QPen(color));
	painter->drawLine(0, halfWidth, width, halfWidth);
	painter->drawLine(halfWidth, 0, halfWidth, width);
	painter->setPen(QPen(color));
	painter->drawLine(0, 0, width, 0);
	painter->drawLine(0, 0, 0, width);
	painter->setPen(QPen(color));
	painter->drawPoint(halfWidth, halfWidth);
	painter->setPen(QPen(color));
	painter->drawPoint(0, 0);
}

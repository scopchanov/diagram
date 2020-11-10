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

#include "Backend.h"
#include <QStandardItemModel>

Backend::Backend(QObject *parent) :
	QObject(parent),
	m_model(new QStandardItemModel(this))
{
	m_model->appendRow(createItem(tr("Foo"), QSize(120, 90), QPointF(100, 140)));
	m_model->appendRow(createItem(tr("Bar"), QSize(80, 70), QPointF(360, 230)));
	m_model->appendRow(createItem(tr("Baz"), QSize(60, 110), QPointF(260, 260)));
}

QStandardItemModel *Backend::model() const
{
	return m_model;
}

QStandardItem *Backend::createItem(const QString &name, const QSize &size,
								   const QPointF &position)
{
	auto *item = new QStandardItem(name);

	item->setSizeHint(size);
	item->setData(position, Qt::UserRole);

	return item;
}

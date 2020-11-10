# MIT License

# Copyright (c) 2020 Michael Scopchanov

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

include(../../../autoversion.pri)

VERSION = $$PROJECT_VERSION

QT += qml quick

CONFIG += qt plugin c++11
CONFIG += skip_target_version_ext
DEFINES += QT_DEPRECATED_WARNINGS

TEMPLATE = lib
TARGET = $$qtLibraryTarget(Diagram)
DESTDIR = ../bin
DLLDESTDIR  = "../import/Scopchanov/Diagram"

uri = Scopchanov.Diagram

# Input
SOURCES += \
    DiagramMouseArea.cpp \
    Diagram_plugin.cpp \
    RulerItem.cpp

HEADERS += \
    DiagramGlobal.h \
    DiagramMouseArea.h \
    DiagramMouseArea_p.h \
    Diagram_plugin.h \
    RulerItem.h \
    RulerItem_p.h

RESOURCES += \
    diagramqml.qrc

DISTFILES += \
    diagram.qdocconf \
    plugins.qmltypes \
    qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) "$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)" "$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

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

import QtQuick 2.15
import QtQuick.Controls 2.15
import Scopchanov.Diagram 1.0
import "cdk"

/*!
	\qmltype AbstractDiagramView
	\inqmlmodule Diagram
*/

Item {
	id: root

	property bool interactive: true
	property bool panActive: false
	default property alias sceneComponent: sceneLoader.sourceComponent
	property alias background: backgroundLoader.sourceComponent
	property alias foreground: foregroundLoader.sourceComponent
	property alias selectionModel: mouseArea.selectionModel
	property alias selectionMode: mouseArea.selectionMode
	readonly property alias scrollX: flickable.contentX
	readonly property alias scrollY: flickable.contentY

	implicitWidth: flickable.contentWidth
	implicitHeight: flickable.contentHeight

	Flickable {
		id: flickable

		anchors.fill: parent
		contentWidth: content.width
		contentHeight: content.height
		boundsMovement: Flickable.StopAtBounds
		boundsBehavior: Flickable.StopAtBounds
		interactive: root.interactive && panActive
		clip: true

		ScrollBar.horizontal: ScrollBar { visible: panActive }
		ScrollBar.vertical: ScrollBar { visible: panActive }

		Item {
			id: content

			width: sceneLoader.width
			height: sceneLoader.height

			Loader {
				id: backgroundLoader

				anchors.fill: parent
			}

			Loader {
				id: sceneLoader

				width: item.width
				height: item.height
			}

			DropArea {
				id: dropArea

				anchors.fill: parent

				onDropped: {
					console.log("dropped")
				}
			}

			Loader {
				id: foregroundLoader

				anchors.fill: parent
			}
		}
	}

	RubberBand {
		id: rubberBand

		color: palette.highlight
		active: mouseArea.selecting
		rectangle: mouseArea.selectionRectangle
	}

	FocusFrame {
		id: frame

		anchors.fill: parent
		active: panActive
	}

	DiagramMouseArea {
		id: mouseArea

		anchors.fill: parent
		scene: sceneLoader.item
		interactive: root.interactive && !panActive
		cursorShape: panActive ? Qt.OpenHandCursor : Qt.ArrowCursor
	}
}

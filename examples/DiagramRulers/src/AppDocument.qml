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
import Scopchanov.Diagram 1.0

AbstractDiagramView {
	id: root

	property size gridSize
	property real gridOffset

	background: Rectangle {
		Image {
			id: grid

			anchors.fill: parent
			anchors.topMargin: gridOffset - gridSize.width
			anchors.leftMargin: gridOffset - gridSize.height
			horizontalAlignment: Image.AlignLeft
			verticalAlignment: Image.AlignTop
			fillMode: Image.Tile
			sourceSize: gridSize
			source: "image://icons/boxedGrid/" + palette.midlight
		}
	}

	foreground: DocumentFrame {
		anchors.fill: parent
		anchors.margins: gridOffset
	}

	Item {
		id: scene

		width: 1291
		height: 841

		Rectangle {
			x: 220; y: 170
			width: text.implicitWidth + 48
			height: text.implicitHeight + 48
			color: Qt.rgba(1, 0, 1, 0.5)
			border.width: 1.5
			border.color: palette.dark
			radius: 4

			Text {
				id: text

				font.pointSize: 12
				font.weight: Font.Medium
				anchors.centerIn: parent
				text: qsTr("Item at (200, 150)")
			}
		}
	}
}

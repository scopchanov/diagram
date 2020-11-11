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

Item {
	id: root

	property alias labelName: txtName.text
	property alias labelIndex: txtIndex.text
	property bool selected: false
	property alias movable: mouseArea.enabled

	function snapToGrid(n, gridSize) {
		return Math.round(n/gridSize)*gridSize;
	}

	implicitWidth: childrenRect.width
	implicitHeight: childrenRect.height

	onXChanged: x = snapToGrid(x, 10)
	onYChanged: y = snapToGrid(y, 10)

	Rectangle {
		id: selectionIndicator

		width: 44; height: 44
		color: "#42A5F5"
		radius: 22
		opacity: 0.5
	}

	Rectangle {
		id: circle

		width: 40; height: 40
		anchors.centerIn: selectionIndicator
		color: "#FFD740"
		border.color: "#424242"
		border.width: 1.5
		radius: 20

		Text {
			id: txtIndex

			anchors.centerIn: parent
			horizontalAlignment: Qt.AlignHCenter
			verticalAlignment: Qt.AlignVCenter
			font.pointSize: 10
		}
	}

	Label {
		id: txtName

		anchors.top: circle.bottom
		anchors.horizontalCenter: circle.horizontalCenter
		anchors.topMargin: 5
		padding: 5

		background: Rectangle {
			color: palette.base
		}
	}

	MouseArea {
		id: mouseArea

		anchors.fill: circle
		drag.target: parent
	}

	state: selected ? "selected" : "normal"

	states: [
		State {
			name: "normal"
			PropertyChanges { target: selectionIndicator; visible: false}
			PropertyChanges { target: circle; scale: 1.0 }
		},
		State {
			name: "selected"
			PropertyChanges { target: selectionIndicator; visible: true}
		}
	]

	transitions: [
		Transition {
			to: "normal"

			SequentialAnimation {
				PropertyAnimation { properties: "scale"; to: 0.95;
					duration: 100 }
				PropertyAnimation { properties: "scale"; duration: 100 }
			}
		},
		Transition {
			to: "selected"

			SequentialAnimation {
				PropertyAnimation { properties: "scale"; to: 1.05;
					duration: 100 }
				PropertyAnimation { properties: "scale"; duration: 100 }
			}
		}
	]
}

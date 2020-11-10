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

	property var itemIndex
	property bool highlighted: false
	property alias text: label.text

	signal clicked(var mouse)

	implicitHeight: 40

	Rectangle {
		id: background

		anchors.fill: parent
		anchors.bottomMargin: 1

		Label {
			id: label

			anchors.fill: parent
			verticalAlignment: Qt.AlignVCenter
			leftPadding: 10
			rightPadding: 10
		}
	}

	MouseArea {
		id: mouseArea

		anchors.fill: parent
		acceptedButtons: Qt.LeftButton
		hoverEnabled: true

		onClicked: root.clicked(mouse)
	}

	states: [
		State {
			name: "highlighted"
			when: highlighted

			PropertyChanges {
				target: background
				color: palette.highlight
			}

			PropertyChanges {
				target: label
				color: palette.highlightedText
			}
		},
		State {
			name: "hovered"
			when: mouseArea.containsMouse

			PropertyChanges {
				target: background
				color: palette.light
			}
		}
	]
}

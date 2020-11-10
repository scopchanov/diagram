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

Item {
	id: root

	property int orientation: Qt.Vertical
	property bool isVertical: orientation === Qt.Vertical
	property bool pressed: false

	clip: true

	Rectangle {
		anchors.fill: parent
		opacity: pressed ? 0.75 : 1

		Rectangle {
			width: 1
			height: parent.height
			anchors.left: parent.left
			color: palette.mid
		}

		Rectangle {
			width: 1
			height: parent.height
			anchors.right: parent.right
			color: palette.mid
		}

		Rectangle {
			anchors.centerIn: parent
			width: isVertical ? 2 : 20
			height: isVertical ? 20 : 2
			color: palette.highlight
			radius: 10
		}
	}

	Binding on implicitWidth {
		when: isVertical
		value: 8
	}

	Binding on implicitHeight {
		when: !isVertical
		value: 8
	}
}

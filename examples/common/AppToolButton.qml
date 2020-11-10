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
import QtQuick.Layouts 1.12

ToolButton {
	id: root

	property alias toolTipText: toolTip.text

	implicitWidth: 40
	implicitHeight: 40
	checkable: true
	clip: true
	opacity: down ? 0.9 : 1
	scale: down ? 0.92 : 1

	Behavior on opacity { NumberAnimation { duration: 75 } }
	Behavior on scale { NumberAnimation { duration: 75 } }

	contentItem: Image {
		source: icon.source
		sourceSize: Qt.size(16, 16)
		opacity: enabled ? 1.0 : 0.25
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		fillMode: Image.Pad
	}

	background: Rectangle {
		color: "transparent"
		Rectangle {
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			width: parent.width - 4; height: 2
			color: palette.highlight
			visible: checked
			radius: 1
		}
	}

	AppToolTip {
		id: toolTip

		visible: root.hovered
	}
}

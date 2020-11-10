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

Slider {
	id: slider

	background: Rectangle {
		anchors.centerIn: parent
		width: slider.availableWidth - slider.leftPadding
			   - slider.rightPadding
		height: 2
		radius: 1
		color: "#BDBDBD"
	}

	handle: Rectangle {
		x: slider.leftPadding + slider.visualPosition*(slider.availableWidth
													   - width)
		anchors.verticalCenter: slider.verticalCenter
		implicitWidth: 16
		implicitHeight: 16
		radius: 8
		border.color: palette.mid
		color: palette.base
		scale: slider.pressed ? 0.95 : 1
		opacity: slider.pressed ? 0.75 : 1

		Behavior on opacity { NumberAnimation { duration: 75 } }
		Behavior on scale { NumberAnimation { duration: 75 } }

		Rectangle {
			anchors.centerIn: parent
			implicitWidth: 6
			implicitHeight: 6
			radius: 3
			color: palette.highlight
			scale: slider.pressed ? 0.75 : 1

			Behavior on scale { NumberAnimation { duration: 75 } }
		}
	}
}

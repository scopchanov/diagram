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
import QtQuick.Layouts 1.12
import Scopchanov.Diagram 1.0

RulerItem {
	id: root

	property alias background: backgroundLoader.sourceComponent
	property alias foreground: foregroundLoader.sourceComponent
	property alias marksDelegate: repeaterMarks.delegate
	readonly property bool isHorizontal: orientation === Qt.Horizontal

	implicitWidth: flickable.contentWidth
	implicitHeight: flickable.contentHeight

	Flickable {
		id: flickable

		anchors.fill: parent
		contentWidth: slidingArea.width
		contentHeight: slidingArea.height
		boundsMovement: Flickable.StopAtBounds
		boundsBehavior: Flickable.StopAtBounds
		interactive: false
		clip: true

		Binding on contentX {
			when: isHorizontal
			value: scrollPosition
		}

		Binding on contentY {
			when: !isHorizontal
			value: scrollPosition
		}

		Item {
			id: slidingArea

			width: isHorizontal ? implicitLength : headroom
			height: isHorizontal ? headroom : implicitLength

			Loader {
				id: backgroundLoader

				anchors.fill: parent
			}

			Repeater {
				id: repeaterMarks

				model: marks.length
			}
		}
	}

	Loader {
		id: foregroundLoader

		anchors.fill: parent
	}
}

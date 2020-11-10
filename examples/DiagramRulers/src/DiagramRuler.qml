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

Item {
	property int orientation: Qt.Horizontal
	readonly property bool isHorizontal: orientation === Qt.Horizontal
	property color outlineColor
	property color fillColor
	property color markColor
	property size sceneSize
	property real rulerScrollX
	property real rulerScrollY

	implicitWidth: ruler.width
	implicitHeight: ruler.height

	Flickable {
		anchors.fill: parent
		contentWidth: ruler.width
		contentHeight: ruler.height
		boundsBehavior: Flickable.StopAtBounds
		interactive: false
		clip: true

		Binding on contentX {
			when: isHorizontal
			value: rulerScrollX
		}

		Binding on contentY {
			when: !isHorizontal
			value: rulerScrollY
		}

		Rectangle {
			id: ruler
			width: isHorizontal ? sceneSize.width : 20
			height: isHorizontal ? 20 : sceneSize.height
			color: fillColor

			Image {
				id: grid
				anchors.fill: parent
				horizontalAlignment: Image.AlignLeft
				verticalAlignment: Image.AlignTop
				fillMode: Image.Tile
				sourceSize: Qt.size(20, 20)
				source: "image://icons/" + (isHorizontal ? "hrule" : "vrule")
			}

			Repeater {
				model: isHorizontal ? 26 : 17
				Rectangle {
					x: isHorizontal ? 50*index + 10 : 0
					y: isHorizontal ? 0 : 50*index + 10
					width: isHorizontal ? 20 : 16
					height: isHorizontal ? 16 : 20
					color: "transparent"

					Binding on transform {
						when: !isHorizontal
						value: Rotation {
							angle: -90
							origin.x: width / 2.0
							origin.y: height / 2.0
						}
					}

					Text {
						anchors.centerIn: parent
						padding: 0
						font.pointSize: 7
						text: 50*index
						color: markColor
					}
				}
			}
		}
	}

	Rectangle {
		anchors.fill: parent
		color: "transparent";
		border.color: outlineColor
	}
}

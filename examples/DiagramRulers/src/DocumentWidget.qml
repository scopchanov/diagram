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
	id: root

	property color rulerOutlineColor
	property color rulerFillColor
	property color rulerMarkColor
	property real rulerMarkInterval
	property alias panActive: documentArea.panActive

	implicitWidth: documentArea.implicitWidth + 20
	implicitHeight: documentArea.implicitHeight + 20

	GridLayout {
		anchors.fill: parent
		rows: 2
		columns: 2
		rowSpacing: 0
		columnSpacing: 0

		Item {
			width: 20; height: 20

			Rectangle {
				width: 16; height: 16
				border.color: palette.mid
				color: rulerFillColor

				Image {
					anchors.centerIn: parent
					width: 16; height: 16

					source: "qrc:/pix/images/icons/16/main.png"
					Layout.alignment: Qt.AlignTop | Qt.AlignLeft
				}
			}
		}

		AppRuler {
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth: implicitWidth
			Layout.maximumHeight: implicitHeight

			orientation: Qt.Horizontal
			implicitLength: documentArea.implicitWidth
			scrollPosition: documentArea.scrollX
			fillColor: rulerFillColor
			outlineColor: rulerOutlineColor
			markColor: rulerMarkColor
			markInterval: rulerMarkInterval
		}

		AppRuler {
			id: vruler

			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth: implicitWidth
			Layout.maximumHeight: implicitHeight

			orientation: Qt.Vertical
			implicitLength: documentArea.implicitHeight
			scrollPosition: documentArea.scrollY
			fillColor: rulerFillColor
			outlineColor: rulerOutlineColor
			markColor: rulerMarkColor
			markInterval: rulerMarkInterval
		}

		AppDocument {
			id: documentArea

			Layout.fillWidth: true
			Layout.fillHeight: true
			gridSize: Qt.size(rulerMarkInterval, rulerMarkInterval)
			gridOffset: vruler.markOffset
		}
	}
}

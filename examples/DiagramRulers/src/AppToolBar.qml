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
import Scopchanov.Diagram 1.0
import common 1.0

Item {
	id: root

	readonly property alias markInterval: cmbInterval.currentValue
	readonly property alias panEnabled: btnPan.checked

	implicitWidth: toolBar.implicitWidth
	implicitHeight: toolBar.implicitHeight

	Elevation {
		source: toolBar
		distance: 4
	}

	ToolBar {
		id: toolBar

		anchors.fill: parent

		RowLayout {
			anchors.fill: parent
			spacing: 0

			Label {
				Layout.leftMargin: 10
				text: qsTr("Mark interval:")
				font.pointSize: 10
			}

			ComboBox {
				id: cmbInterval

				implicitWidth: 80
				model: [25, 50, 100, 150]
				currentIndex: 1
			}

			ToolSeparator {}

			AppToolButton {
				id: btnPan

				checked: true
				icon.source: "pix/images/icons/16/move.png"
				toolTipText: qsTr("Toggle the pan mode on/off")
			}

			Item {
				Layout.fillWidth: true
			}

			SiteLink {
				Layout.rightMargin: 11
			}
		}

		Component.onCompleted: { palette.highlightedText = palette.windowText }
	}
}

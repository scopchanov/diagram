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
import "ThemeModel.js" as ThemeModel
import common 1.0

Item {
	id: root

	readonly property string gridPattern: cmbPattern.currentValue
	readonly property int gridSize: cmbSize.currentValue
	readonly property color gridColor: __hasCustomTheme
									   ? btnGridColor.color
									   : cmbTheme.currentValue.grid
	readonly property color backgroundColor: __hasCustomTheme
											 ? btnBackgroundColor.color
											 : cmbTheme.currentValue.background
	readonly property bool __hasCustomTheme: cmbTheme.currentIndex === 0
	readonly property alias hasGrid: btnGrid.checked
	readonly property alias hasBackground: btnBackground.checked

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

			AppToolButton {
				id: btnGrid

				checked: true
				icon.source: "pix/images/icons/16/grid.png"
				toolTipText: qsTr("Toggle the grid on/off")
			}

			AppToolButton {
				id: btnBackground

				checked: true
				icon.source: "pix/images/icons/16/background.png"
				toolTipText: qsTr("Toggle the background on/off")
			}

			ToolSeparator {}

			Label {
				Layout.leftMargin: 9
				Layout.rightMargin: 9
				horizontalAlignment: Text.AlignRight
				text: qsTr("Grid pattern") + ":";
			}

			ComboBox {
				id: cmbPattern

				implicitWidth: 100
				model: ["Dotted", "Crossed", "Boxed", "Fancy"]
				currentIndex: 2
			}

			Label {
				Layout.leftMargin: 9
				Layout.rightMargin: 9
				horizontalAlignment: Text.AlignRight
				text: qsTr("Grid size") + ":";
			}

			ComboBox {
				id: cmbSize

				implicitWidth: 80
				model: [10, 20, 40, 100]
				currentIndex: 1
			}

			ToolSeparator {}

			Label {
				Layout.leftMargin: 9
				Layout.rightMargin: 9
				horizontalAlignment: Text.AlignRight
				text: qsTr("Color theme") + ":";
			}

			ComboBox {
				id: cmbTheme

				implicitWidth: 130
				textRole: "text"
				valueRole: "value"
				model: ThemeModel.model
			}

			ColorButton {
				id: btnGridColor

				Layout.fillHeight: true
				Layout.leftMargin: 9
				Layout.rightMargin: 9
				initialColor: Qt.hsla(0.7059, 0.5804, 0.7569, 1.0)
				enabled: __hasCustomTheme
				toolTipText: qsTr("Set the grid color")
				text: qsTr("Grid")
			}

			ColorButton {
				id: btnBackgroundColor

				Layout.fillHeight: true
				Layout.leftMargin: 9
				Layout.rightMargin: 9
				initialColor: Qt.hsla(0.7373, 0.5882, 0.8039, 1.0)
				enabled: __hasCustomTheme
				toolTipText: qsTr("Set the background color")
				text: qsTr("Background")
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

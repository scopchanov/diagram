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
import QtQml.Models 2.15
import common 1.0

ApplicationWindow {
	id: mainWindow

	width: 1040; height: 840
	title: qsTr("Diagram Selection Example")
	visible: true

	FontLoader { id: regular; source: "qrc:/bin/fonts/roboto/Roboto-Regular.ttf" }
	FontLoader { id: medium; source: "qrc:/bin/fonts/roboto/Roboto-Medium.ttf" }
	FontLoader { id: bold; source: "qrc:/bin/fonts/roboto/Roboto-Bold.ttf" }

	header: AppToolBar {
		id: toolBar
	}

	SplitView {
		anchors.fill: parent

		handle: AppSplitHandle {
			pressed: SplitHandle.pressed
		}

		RowLayout {
			SplitView.fillWidth: true

			AppDocument {
				id: documentArea

				Layout.alignment: Qt.AlignCenter
				Layout.margins: 20
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.maximumWidth: implicitWidth
				Layout.maximumHeight: implicitHeight

				panActive: toolBar.panEnabled
				selectionMode: toolBar.currentSelectionMode
				selectionModel: itemSelectionModel
			}
		}

		ItemList {
			SplitView.preferredWidth: 250

			model: backend.model
			selectionModel: itemSelectionModel
		}
	}

	ItemSelectionModel {
		id: itemSelectionModel

		model: backend.model
	}
}

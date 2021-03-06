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

Text {
	id: root

	x: isHorizontal ? marks[index] - 0.5*implicitWidth
					: 0.5*(headroom - implicitWidth) - 2
	y: isHorizontal ? 2 : marks[index] - 0.5*implicitHeight
	color: index % 2 == 0 ? markColor : Qt.lighter(markColor, 2.5)
	font.pointSize: 7
	text: markInterval*index

	Binding on transform {
		when: orientation === Qt.Vertical
		value: Rotation {
			angle: -90
			origin.x: 0.5*width
			origin.y: 0.5*height
		}
	}
}

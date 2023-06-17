import QtQuick 2.15
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.5
Dialog{
	width:900
	height:600
	padding:0
	anchors.centerIn:parent
	id:inputDlg
	property alias text:title.text
	Rectangle{
		id:header
		anchors{
			top:inputDlg.top
		}
		width:inputDlg.width
		height:70
		color:"#246EE9"
		Text{
			id:title
			anchors.centerIn:parent
			text:"Codeur en ligne"
			font.pixelSize:30
			font.bold:true
			color:"white"
		}
	}
}

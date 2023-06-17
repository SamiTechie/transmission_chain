import QtQuick 2.15

Rectangle{
	id:root
	property  alias text:label.text;
	property string hoveredColor:"#E30B5C";
	property alias textColor:label.color;
	property alias pixelSize:label.font.pixelSize;
	color:"#00A36C"
	signal clicked()
	signal hovered()
	width:60;height:40;
	Text{
		id:label
		text:"Button"
		anchors.centerIn:root
		horizontalAlignment:Text.AlignHCenter
		color:"white"
		font.bold:true
		font.pixelSize:20
	}
	MouseArea{
		property string color:root.color;
		hoverEnabled:true
		anchors.fill:parent
		onClicked:{root.clicked()}
		onEntered:{root.hovered();color=root.color;root.color=root.hoveredColor}
		onExited:{root.color=color;}
	}
}

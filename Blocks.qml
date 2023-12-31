import QtQuick 2.15
import QtQuick.Shapes 1.15

Item {
	width:1070
	height:640
	property int rectangleWidth:160
	property int rectangleHeight:70
	id:root
	signal codeEnligne()
	signal input()
	signal modulation()
	signal filter()
	signal bruit()
	signal filtreRec()
	signal demo()
	signal horloge()
	signal decision()
	signal output()
	Text{
		id:input
		text:"Sequence\nBinaire\nemise"
		anchors.left:parent.left
		anchors.leftMargin:10
		color:"#00A36C"
		anchors.verticalCenter:code.verticalCenter
		font.pixelSize:20
		horizontalAlignment:Text.AlignHCenter
		font.bold:true
		MouseArea{
			anchors.fill:parent
			hoverEnabled:true
			onEntered:{
				input.color = "#E30B5C"
			}
			onExited:{
				input.color = "#00A36C"
			}
			onClicked:{
				root.input()
			}
		}
	}
	Rectangle{
		id:line0
		width:rectangleWidth
		height:3
		color:"black"
		anchors.left:input.right
		anchors.verticalCenter:code.verticalCenter
	}
	Buttons{
		id:code
		width:rectangleWidth
		height:rectangleHeight
		anchors.left:line0.right
		radius:10
		text:"Code\nen ligne"
		onClicked:{
			root.codeEnligne()
		}
	}
	Rectangle{
		id:line1
		width:rectangleWidth
		height:3
		color:"black"
		anchors.left:code.right
		anchors.verticalCenter:code.verticalCenter
	}
	Buttons{
		id:filter
		radius:10
		width:rectangleWidth
		height:rectangleHeight
		anchors.left:line1.right
		anchors.verticalCenter:code.verticalCenter
		text:"Filter\nd'emission"
		onClicked:{
			root.filter()
		}
	}
	Rectangle{
		id:line2
		width:rectangleWidth
		height:2
		color:"black"
		anchors.left:filter.right
		anchors.verticalCenter:code.verticalCenter
	}
	Buttons{
		id:mod
		width:rectangleWidth
		height:rectangleHeight
		anchors.left:line2.right
		anchors.verticalCenter:code.verticalCenter
		radius:10
		text:"Modulation"
		onClicked:{
			root.modulation()
		}
	}
	Rectangle{
		id:line3
		width:2
		height:rectangleWidth
		color:"black"
		anchors.top:mod.bottom
		anchors.horizontalCenter:mod.horizontalCenter
	}
	Buttons{
		id:canal
		width:rectangleWidth+20
		height:rectangleHeight+20
		anchors.top:line3.bottom
		anchors.horizontalCenter:line3.horizontalCenter
		radius:10
		text:"Canal de\npropagation\n(avec bruit)"
		onClicked:{
			root.bruit()
		}
	}
	Rectangle{
		id:line4
		width:2
		height:rectangleWidth
		color:"black"
		anchors.top:canal.bottom
		anchors.horizontalCenter:canal.horizontalCenter
	}
	Rectangle{
		id:line5
		width:rectangleHeight
		height:2
		color:"black"
		anchors.right:line4.left
		anchors.verticalCenter:line4.bottom
	}
	Buttons{
		id:demod
		width:rectangleWidth
		height:rectangleHeight
		anchors.right:line5.left
		anchors.verticalCenter:line5.verticalCenter
		radius:10
		text:"Demodulation"
		onClicked:{
			root.demo()
		}
	}
	Rectangle{
		id:line6
		width:rectangleHeight
		height:2
		color:"black"
		anchors.right:demod.left
		anchors.verticalCenter:demod.verticalCenter
	}
	Buttons{
		id:filterRec
		width:rectangleWidth
		height:rectangleHeight
		anchors.right:line6.left
		anchors.verticalCenter:line6.verticalCenter
		text:"Filter de\nreception"
		radius:10
		onClicked:{
			root.filtreRec()
		}
	}
	Shape{
		id:shape
		anchors.right:filterRec.left
		anchors.verticalCenter:filterRec.verticalCenter
		width:rectangleWidth
		height:rectangleWidth
		ShapePath{
			strokeWidth:2
			strokeColor:"black"
			startX:-15;startY:60;
			PathLine{x:20;y:75}
		}
		ShapePath{
			strokeWidth:2
			strokeColor:"black"
			startX:20;startY:75;
			PathLine{x:rectangleWidth;y:75}
		}
		ShapePath{
			strokeWidth:2
			strokeColor:"black"
			startX:rectangleWidth-10;startY:75;
			PathLine{x:rectangleWidth-10;y:rectangleWidth+30}
		}
		ShapePath{
			strokeWidth:2
			strokeColor:"black"
			startX:rectangleWidth-10;startY:rectangleWidth+30;
			PathLine{x:0;y:rectangleWidth+30}
		}
	}
	Buttons{
		id:horloge
		width:rectangleWidth+10
		height:rectangleHeight
		anchors.right:shape.left
		anchors.top:shape.bottom
		anchors.topMargin:5
		text:"Recuperation de\nl'horloge binaire"
		radius:10
		onClicked:{
			root.horloge()
		}
	}
	Rectangle{
		id:line7
		width:2
		height:rectangleHeight + 15
		anchors.bottom:horloge.top
		anchors.left:horloge.right
		anchors.leftMargin:-10
		border.color:"black"
		border.width:2
	}
	Rectangle{
		id:line8
		width:rectangleHeight
		height:2
		color:"black"
		anchors.rightMargin:25
		anchors.right:shape.left
		anchors.verticalCenter:shape.verticalCenter
	}
	Buttons{
		id:dec
		width:rectangleWidth/1.2
		height:rectangleHeight/1.2
		anchors.right:line8.left
		anchors.verticalCenter:line8.verticalCenter
		text:"Decision"
		radius:10
		onClicked:root.decision()
	}
	Rectangle{
		id:line9
		width:rectangleHeight
		height:2
		color:"black"
		anchors.right:dec.left
		anchors.verticalCenter:dec.verticalCenter
	}
	Text{
		id:output
		text:"Sequence\nBinaire\nRecu"
		anchors.right:line9.left
		anchors.verticalCenter:line9.verticalCenter
		horizontalAlignment:Text.AlignHCenter
		color:"#00A36C"
		font.pixelSize:20
		font.bold:true
		MouseArea{
			anchors.fill:parent
			hoverEnabled:true
			onEntered:{
				output.color = "#E30B5C"
			}
			onExited:{
				output.color = "#00A36C"
			}
			onClicked:{
				root.output()
			}
		}
	}
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15
Window {
	width:1200
	height:768
	visible:true
	id:root
	Rectangle{
		id:header
		color:"#246EE9"
		height:80
		width:root.width
		Text{
			anchors.centerIn:parent
			text:"Chaine de transmission numerique"
			font.pixelSize:30
			font.bold:true
			color:"white"
		}
	}
	
	CodeDlg{id:codeDlg}
	FilterDlg{id:filterDlg}
	ModulationDlg{id:modulationDlg}
	BruitDlg{id:bruitDlg}
	DemoDlg{id:demodulationDlg}
	FiltreRecDlg{id:filtreRecDlg}
	InputDlg{id:inputDlg}
	HorlogeDlg{id:horlogeDlg}
	DecisionDlg{id:decisionDlg}
	OutputDlg{id:outputDlg}
	Item{
		anchors{
			top:header.bottom
			bottom:parent.bottom
			left:parent.left
			right:parent.right
		}
		Blocks{
			id:chaine
			anchors.centerIn:parent
			onInput:inputDlg.open()
			onCodeEnligne:codeDlg.open()
			onFilter:filterDlg.open()
			onModulation:modulationDlg.open()
			onBruit:bruitDlg.open()
			onDemo:demodulationDlg.open()
			onFiltreRec:filtreRecDlg.open()
			onHorloge:horlogeDlg.open()
			onDecision:decisionDlg.open()
			onOutput:outputDlg.open()
		}
	}
}

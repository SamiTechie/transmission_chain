import QtQuick 2.15
import "function.js" as Base
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.10
Dialogs{
	function setUpCode(currentText){
		var bits = lineCode.bits
		plt.draw(bits,1,"Enter",1)
		if (currentText == "RZ"){
			lineCode.setCodage("RZ")
			decision.setCodage("RZ")
		}else if(currentText == "NRZ"){
			lineCode.setCodage("NRZ")
			decision.setCodage("NRZ")
		}else if(currentText == "Miller"){
			lineCode.setCodage("Miller")
			decision.setCodage("Miller")
			lineCode.miller()
		}else if(currentText == "Manchester"){
			lineCode.setCodage("Manchester")
			decision.setCodage("Manchester")
		}
		lineCode.applyCodage()
		plt.draw(lineCode.bits,1,"Enter",1)
		plt.draw(lineCode.out,lineCode.tm,"Sorti",2)
		Base.reload(outload)
		Base.reload(dspload)
		//SetUP Filtre D'emission
		filtre.setCode(lineCode.out) // Set Up the input
		filtre.setDspCode(lineCode.dsp) // Calculate the Spectre
		filtre.setTm(lineCode.tm) // Set The period
		filtre.setBits(lineCode.bits) // Set up the bits
		filtre.filreCosin(0)
		//SetUP Modulation
		modulation.setTm(filtre.tm)
		modulation.setCode(filtre.out)
		modulation.setBits(lineCode.bits)
		modulation.setTm(lineCode.tm)
		modulation.applyMod()
		//SetUP Bruit
		bruit.setMod(modulation.out)
		bruit.setBits(lineCode.bits)
		bruit.bruitGaussien()
		// Set Demodulation
		demodulation.setBruit(bruit.bruit)
		demodulation.setSignal(filtre.out)
		demodulation.demodulator()
		// Set Up Filtre Reception
		filtreReception.setBits(lineCode.bits)
		filtreReception.setCode(lineCode.out)
		filtreReception.setTm(lineCode.tm)
		filtreReception.setInp(demodulation.out)
		filtreReception.filreCosin()
		// Set Up Horloge
		horloge.setTm(lineCode.tm)
		horloge.setCode(lineCode.out)
		//set Up Decision
		decision.setCode(lineCode.out)
		decision.setTm(lineCode.tm)
		decision.setInp(filtreReception.out)
		decision.decision()
		//set Up Decision
		output.setBits(lineCode.bits)
		output.setInp(decision.out)
		output.tauxError()
	}
	id:root
	text:"Code en Ligne"
	onOpened:{
		plt.draw(lineCode.bits,1,"Enter",1)
		plt.draw(lineCode.out,lineCode.tm,"Sorti",2)
		Base.reload(outload)
		Base.reload(dspload)
	}
	Item{
		anchors.top:parent.top
		anchors.bottom:parent.bottom
		anchors.topMargin:70
		width:parent.width
		ComboBox{
			id:choise
			anchors{
				top:parent.top
				topMargin:50
				horizontalCenter:parent.horizontalCenter
			}
			model:ListModel{
				ListElement{key :"RZ"}
				ListElement{key :"NRZ"}
				ListElement{key :"Manchester"}
			}
			width:200
			onActivated:{
				root.setUpCode(currentText)
				var inp = []
				if(dsp.state == 1){
					dsp.toggle()
					dsp.state = 0
				}
			}
		}
		ColumnLayout{
			spacing:0
			anchors{
				top:choise.bottom
				topMargin:10
				left:parent.left
				right:parent.right
				bottom:parent.bottom
				leftMargin:10
				rightMargin:10
			}
			width:root.width 
		RowLayout{
			Item{
				Layout.fillWidth:true
			}
			Item{
				Layout.fillWidth:true
			Switch{
				property int state: 0
				id:dsp
				anchors{
					horizontalCenter:parent.horizontalCenter
				}
				Layout.preferredHeight : 30
				text:'Spectre'
				onToggled:{
					if (state == 0){
						plt.dsp(lineCode.dsp,lineCode.f,"Spectre",2)
						plt.stem(lineCode.f,lineCode.imp,2)
						state = 1
					}else{
						plt.draw(lineCode.out,lineCode.tm,"Sorti",2)
						state = 0
					}
					Base.reload(outload)
					Base.reload(dspload)
				}
			}
			}
		}
		RowLayout{
		Loader{
			id:outload
			Layout.fillWidth:true
			Layout.preferredHeight : 350
			sourceComponent:Image{
				id:img
				source:"image://perflog/1"
				cache:false
			}
		}
		Loader{
			id:dspload
			Layout.fillWidth:true
			Layout.preferredHeight : 350
			sourceComponent:Image{
				id:img
				source:"image://perflog/2"
				cache:false
			}
		}
		}
	}
	}
}

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.10
import "function.js" as Base
Dialogs{
	id:root
	text:"Modulation"
	function initMod(){
				/*
				var inp = []
				if(dsp.state == 1){
					dsp.toggle()
					dsp.state = 0
				}
				*/
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
		Base.reload(dspload)
	}
	onOpened:{
		/*
		root.initMod(mod.currentText)
		*/
		plt.dsp(modulation.out,modulation.t,"Sorti",2)
		plt.dsp(filtre.out,filtre.t,"Entrer",1)
		Base.reload(outload)
		Base.reload(dspload)
	}
	Item{
		anchors.top:parent.top
		anchors.bottom:parent.bottom
		anchors.topMargin:70
		width:parent.width
		RowLayout{
			id:choise
			width:parent.width
			anchors{
				top:parent.top
				topMargin:50
			}
		ComboBox{
				function setModulation(currentText){
				}
			id:mod
			Layout.alignment:Qt.AlignHCenter
			Layout.leftMargin:100
			Layout.preferredWidth:240
			model:ListModel{
				ListElement{key :"ASK"}
				ListElement{key :"BPSK"}
				ListElement{key :"BFSK"}
			}
			Component.onCompleted:{
				plt.draw([],1,"Bits",2)
				Base.reload(outload)
				Base.reload(dspload)
			}
			width:200
			onActivated:{
				var bits = lineCode.bits
				plt.draw(bits,1,"Enter",1)
				if (currentText == "ASK"){
					amplitude.visible = true
					modulation.setPhi(0)
					phase.text = 0
					fp.visible = true
					phase.visible = false
					modulation.setMod("ASK")
				}else if(currentText == "BPSK"){
					amplitude.visible = false
					amplitude.text = 1
					phase.text = 0
					modulation.setA(1)
					modulation.setPhi(0)
					phase.visible = true
					fp.visible = true
					modulation.setMod("BPSK")
				}else if(currentText == "BFSK"){
					modulation.setA(1)
					modulation.setPhi(0)
					phase.text = 0
					amplitude.visible = false
					phase.visible = false
					fp.visible = true
					modulation.setMod("BFSK")
				}
				modulation.applyMod()
				root.initMod()
			}
		}
		TextField{
			id:fp
			Layout.column:1
			visible:true
			Layout.alignment:Qt.AlignHCenter
			placeholderText:"fp"
			Layout.preferredWidth:90
			Keys.onReleased:{
					modulation.setFp(parseFloat(text))
					modulation.applyMod()
					if (dsp.state == 1){
						plt.dsp(modulation.out,modulation.t,"Sorti",2)
					}else{
						plt.dsp(modulation.out,modulation.t,"Sorti",2)
					}
					root.initMod()
			}
		}
		TextField{
			id:amplitude
			Layout.column:1
			visible:true
			Layout.alignment:Qt.AlignHCenter
			placeholderText:"A"
			Layout.preferredWidth:90
			Layout.rightMargin:100
			Keys.onReleased:{
					modulation.setA(parseFloat(text))
					modulation.applyMod()
					if (dsp.state == 1){
						plt.dsp(modulation.out,modulation.t,"Sorti",2)
					}else{
						plt.dsp(modulation.out,modulation.t,"Sorti",2)
					}
					root.initMod()
			}
		}
		TextField{
			id:phase
			Layout.column:1
			visible:false
			Layout.alignment:Qt.AlignHCenter
			placeholderText:"phase"
			Layout.preferredWidth:90
			Layout.rightMargin:100
			Keys.onReleased:{
					modulation.setPhi(parseFloat(text))
					modulation.applyMod()
					if (dsp.state == 1){
						plt.dsp(modulation.out,modulation.t,"Sorti",2)
					}else{
						plt.dsp(modulation.out,modulation.t,"Sorti",2)
					}
					root.initMod()
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
				visible:false
				id:dsp
				anchors{
					horizontalCenter:parent.horizontalCenter
				}
				Layout.preferredHeight : 30
				text:'Spectre'
				onToggled:{
					if (state == 0){
						plt.dsp(lineCode.dsp,lineCode.f,"Spectre",2)
						state = 1
					}else{
						plt.draw(lineCode.out,lineCode.tm,"Sorti",2)
						state = 0
					}
            				dspload.active = !dspload.active
            				dspload.active = !dspload.active
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

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.10
import "function.js" as Base
Dialogs{
	id:root
	text:"Filtre D'emission"
	function initFilter(currentText,alphaCoe){
				var code = filtre.code
				modulation.setTm(filtre.tm)
				plt.draw(filtre.code,filtre.tm,"Enter",1)
				var inp = []
				if (currentText == "Filter Cosine surleve"){
					filtre.setAlpha(alphaCoe)
					alpha.visible = true
					b.visible = false
				}else if(currentText == "Filter Nyquist"){
					filtre.filtreNyquist(0.5)
					alpha.visible = false
					b.visible = true
				}
				filtre.applyFiltre()
				if(dsp.state == 0){
					plt.dsp(filtre.out,filtre.t,"Sorti",2)
				}else{
					plt.dsp(filtre.dsp,filtre.f,"Sorti",2)
				}
            			dspload.active = !dspload.active
            			dspload.active = !dspload.active
				outload.active = !outload.active
				outload.active = !outload.active

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
				filtreReception.setInp(demodulation.out)
				filtreReception.filreCosin()
				//set Up Decision
				decision.setInp(filtreReception.out)
				decision.decision()
				//set Up Decision
				output.setBits(lineCode.bits)
				output.setInp(decision.out)
				output.tauxError()




	}
	onOpened:{
		root.initFilter(choiseFilter.currentText,filtre.alpha)
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
			id:choiseFilter
			Layout.alignment:Qt.AlignHCenter
			Layout.leftMargin:100
			Layout.preferredWidth:240
			model:ListModel{
				ListElement{key :"Filter Cosine surleve"}
			}
			Component.onCompleted:{
				var code = filtre.code
				plt.draw(code,0.5,"Enter",1)
				plt.dsp([],[],"Sorti",2)
			}
			width:200
			onActivated:{
				root.initFilter(currentText,alpha.text)
			}
		}
		TextField{
			id:alpha
			Layout.column:1
			visible:true
			Layout.alignment:Qt.AlignHCenter
			placeholderText:"alpha"
			Layout.preferredWidth:160
			Layout.rightMargin:100
			Keys.onReleased:{
					filtreReception.setAlpha(text)
					root.initFilter(choiseFilter.currentText,alpha.text)
					//filtre.filreCosin(text)
					//filtreReception.setBits(lineCode.bits)
					if (dsp.state == 1){
						plt.dsp(filtre.dsp,filtre.f,"Spectre",2)
					}else{
						plt.dsp(filtre.out,filtre.t,"Sorti",2)
					}
            				dspload.active = !dspload.active
            				dspload.active = !dspload.active
			}
		}
		ComboBox{
			id:b
			Layout.column:1
			visible:false
			Layout.alignment:Qt.AlignHCenter
			Layout.preferredWidth:160
			Layout.rightMargin:100
			model:ListModel{
				ListElement{key :"Band = 1/Ts"}
				ListElement{key :"Band = 1/2Ts"}
			}
			Component.onCompleted:{
				if(dsp.state == 1){
					dsp.toggle()
					dsp.state = 0
				}
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
				Layout.alignment:Qt.AlignHCenter
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
						plt.dsp(filtre.dsp,filtre.f,"Spectre",2)
						state = 1
					}else{
						plt.dsp(filtre.out,filtre.t,"Sorti",2)
						plt.draw(filtre.code,filtre.tm,"Enter",1)
						state = 0
					}
            				dspload.active = !dspload.active
            				dspload.active = !dspload.active
					outload.active = !outload.active
					outload.active = !outload.active
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

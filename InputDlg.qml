import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.10
Dialogs{
	id:root
	text:"L'entrer"
	Item{
		anchors.top:parent.top
		anchors.bottom:parent.bottom
		anchors.topMargin:70
		width:parent.width
		TextField{
			id:text
			anchors{
				top:parent.top
				topMargin:50
				horizontalCenter:parent.horizontalCenter
			}
			placeholderText:"Input"
			width:200
			Component.onCompleted:{
				plt.draw([],0.5,"Bits",1)
				load.active = !load.active
            			load.active = !load.active
			}
			Keys.onReleased:{
					var inp = []
					for (var i = 0; i < text.text.length; i++){
						inp.push(parseInt(text.text[i]))
					}
					// Reload The images in the current Window
					plt.draw(inp,1,"Bits",1)
					load.active = !load.active
            				load.active = !load.active
					// SetUP LineCoding
					lineCode.setBits(inp) //Set the Input of lineCoding
					lineCode.applyCodage() //Apply The Codage
					//SetUP Filtre D'emission
					filtre.setCode(lineCode.out) // Set Up the input
					filtre.setDspCode(lineCode.dsp) // Calculate the Spectre
					filtre.setTm(lineCode.tm) // Set The period
					filtre.setBits(lineCode.bits) // Set up the bits
					filtre.filreCosin()
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
		}
		RowLayout{
			id:row
			anchors{
				top:text.bottom
				topMargin:10
				horizontalCenter:parent.horizontalCenter
			}
			Buttons{
				visible:false
				id:te
				width:100
				height:50
				text:"Random"
				onClicked:{
					var data = []
					for(var i = 0;i < 5;i++){
						var rand = Math.floor(Math.random()*2);
						data.push(rand)
					}
					text.text = ""
					data = data.join("")
					text.insert(0,data)
				}
			}
			Buttons{
				visible:false
				width:100
				height:50
				text:"File"
			}
		}
		Loader{
			id:load
			anchors{
				top:row.bottom
				bottom:root.bottom
				horizontalCenter:parent.horizontalCenter
			}
			sourceComponent:Image{
				id:img
				width:root.width - 150
				height: root.height -250
				source:"image://perflog/1"
				cache:false
			}
		}
	}
}

import QtQuick 2.15
import "function.js" as Base
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.10
Dialogs{
	function initBruit(){
					bruit.setVar(alpha.text)
					bruit.bruitGaussien()
					if (dsp.state == 1){
						plt.dsp(bruit.out,bruit.t,"Sorti",2)
					}else{
						plt.dsp(bruit.out,bruit.t,"Sorti",2)
					}
					demodulation.setBruit(bruit.bruit)
					demodulation.demodulator()
					// Set Up Filtre Reception
					filtreReception.setInp(demodulation.out)
					filtreReception.filreCosin()
					//set Up Decision
					decision.setInp(filtreReception.out)
					decision.decision()
					//set Up Output
					output.setBits(lineCode.bits)
					output.setInp(decision.out)
					output.tauxError()

					Base.reload(dspload)
	}
	onOpened:{
		plt.dsp(modulation.out,modulation.t,"Entrer",1)
		plt.dsp(bruit.out,bruit.t,"Sorti",2)
		Base.reload(outload)
		Base.reload(dspload)
	}
	id:root
	text:"Canal"
	Item{
			Component.onCompleted:{
				plt.draw([],1,"Bits",2)
				Base.reloainpd(outload)
				Base.reload(dspload)
			}
		anchors.top:parent.top
		anchors.bottom:parent.bottom
		anchors.topMargin:20
		width:parent.width
		RowLayout{
			id:choise
			width:parent.width
			anchors{
				top:parent.top
				topMargin:100
			}
		TextField{
			id:alpha
			visible:true
			Layout.alignment:Qt.AlignHCenter
			placeholderText:"Variance"
			Layout.preferredWidth:160
			Layout.rightMargin:100
			Keys.onReleased:{
				root.initBruit()
			}
		}
	}
		ColumnLayout{
			spacing:0
			anchors{
				top:choise.top
				topMargin:40
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
				visible:false
				anchors{
					horizontalCenter:parent.horizontalCenter
				}
				Layout.preferredHeight : 30
				text:'Spectre'
				onToggled:{
					if (state == 0){
						plt.dsp(bruit.dsp,bruit.f,"Spectre",2)
						state = 1
					}else{
						plt.draw(bruit.out,bruit.tm,"Sorti",2)
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

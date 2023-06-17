import QtQuick 2.15
import "function.js" as Base
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.10
Dialogs{
	function initDemo(){
					if (dsp.state == 0){
						plt.dsp(demodulation.out,filtre.t,"Sorti",2)
						dsp.state = 1
					}else{
						plt.dsp(demodulation.out,filtre.t,"Sorti",2)
						dsp.state = 0
					}
					Base.reload(outload)
					Base.reload(dspload)
					

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
		initDemo()
		plt.dsp(bruit.out,bruit.t,"Entrer",1)
		Base.reload(outload)
		Base.reload(dspload)
	}
	id:root
	text:"Demodulation"
	Item{
			Component.onCompleted:{
				plt.draw([],1,"Bits",2)
				Base.reload(outload)
				Base.reload(dspload)
			}
		anchors.top:parent.top
		anchors.bottom:parent.bottom
		anchors.topMargin:20
		width:parent.width
		ColumnLayout{
			spacing:0
			anchors{
				top:parent.top
				topMargin:100
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
				visible:false
				property int state: 0
				id:dsp
				anchors{
					horizontalCenter:parent.horizontalCenter
				}
				Layout.preferredHeight : 30
				text:'Spectre'
				onToggled:{
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

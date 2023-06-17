import QtQuick 2.15
import "function.js" as Base
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.10
Dialogs{
	function initdecision(){
					horloge.recupHorloge()
					decision.decision()
					plt.draw(decision.out,1,"Sorti",2)
					Base.reload(outload)
					Base.reload(dspload)
	}
	id:root
	property var error
	onOpened:{
		plt.draw(lineCode.bits,1,"Entrer du chaine du transmission",1)
		root.initdecision()
		root.error = output.error()
		if(root.error >= 50){
			errorText.color = "red"
		}else if(root.error <=10){
			errorText.color = "green"
		}else{
			errorText.color = "orange"
		}
	}
	text:"Sequence Binaire Recu"
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
					Text{
						id:errorText
						font.bold:true
					anchors{
						horizontalCenter:parent.horizontalCenter
					}
						text:"Taux d'erreur: " + root.error +"%"
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

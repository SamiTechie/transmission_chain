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
	onOpened:{
		plt.dsp(filtreReception.out,filtre.t,"Entrer",1)
		root.initdecision()
	}
	text:"Decision"
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

import QtQuick 2.15
import "function.js" as Base
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.10
Dialogs{
	id:root
	text:"Horloge"
	function initHorloge(){
					horloge.recupHorloge()
					plt.draw(horloge.out,horloge.tm,"Horloge",1)
					Base.reload(outload)
	}
	onOpened:{
		root.initHorloge()
	}
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
				left:parent.left
				right:parent.right
				bottom:parent.bottom
				leftMargin:10
				rightMargin:10
			}
			width:root.width 
		Loader{
			id:outload
			Layout.fillWidth:true
			sourceComponent:Image{
				id:img
				source:"image://perflog/1"
				cache:false
			}
		}
	}
	}
}

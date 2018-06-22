import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

Item {
	id: full

	width: 150
	height: 30

	ComboBox {
	    editable: false
	    model: items
			textRole: 'name'
        anchors.fill: parent

		onCurrentIndexChanged: monitor_name = items.get(currentIndex).name

	}
	    
	
}
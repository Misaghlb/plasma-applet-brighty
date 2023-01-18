import QtQuick 2.15
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.3

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kquickcontrolsaddons 2.0 as KQuickControlsAddonsComponents

Item {
	id: full

	//implicitHeight: column.implicitHeight
	// implicitWidth: column.implicitWidth

	Layout.preferredWidth: PlasmaCore.Units.gridUnit * 12
	Layout.preferredHeight: PlasmaCore.Units.gridUnit * 2
	Layout.minimumWidth: Layout.preferredWidth
	Layout.minimumHeight: Layout.preferredHeight
	Layout.maximumWidth: Layout.preferredWidth

	ComboBox {
	    editable: false
	    model: items
			textRole: 'name'
        anchors.fill: parent
		onCurrentIndexChanged: monitor_name = items.get(currentIndex).name

	}
}
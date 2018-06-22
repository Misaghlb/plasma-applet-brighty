import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: compactRepresentation


    property double itemWidth:  parent === null ? 0 : vertical ? parent.width : parent.height
    property double itemHeight: itemWidth

    Layout.minimumWidth: itemWidth
    Layout.minimumHeight: itemHeight
    Plasmoid.switchWidth: units.gridUnit * 20
    Plasmoid.switchHeight: units.gridUnit * 30


    // x100 for better counting
    property int brightnessIncrement: plasmoid.configuration.manualBrightnessStep * 100
    property int brightnessMin: 10
    property int brightnessMax: 100

    property bool textColorLight: ((theme.textColor.r + theme.textColor.g + theme.textColor.b) / 3) > 0.5
    property color iconColor: textColorLight ? Qt.tint(theme.textColor, '#f6f1f2') : Qt.tint(theme.textColor, '#232627')

    property string buttonImagePath: Qt.resolvedUrl('../icons/sun-flat.svg')

    IconSVG {
        source: buttonImagePath
        color: iconColor
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            plasmoid.expanded = !plasmoid.expanded
            brightyDS.connectedSources.push(mon_list_Command)
        }


        onWheel: {

            if (brightyDS.connectedSources.length > 0) {
                return
            }
            if (wheel.angleDelta.y > 0) {
                // wheel up
                    manualBrightness += brightnessIncrement
                    if (manualBrightness > brightnessMax) {
                        manualBrightness = brightnessMax
                    }
                    currentBrightness = manualBrightness
                
            } else {
                // wheel down
                    manualBrightness -= brightnessIncrement
                    if (manualBrightness < brightnessMin) {
                        manualBrightness = brightnessMin
                    }
                    currentBrightness = manualBrightness
                 
            }
            brightyDS.connectedSources.push(changeBrightnessCommand)
        }
    }
}

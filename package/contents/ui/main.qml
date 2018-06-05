/*
 * Copyright 2018  Misagh Lotfi Bafandeh <misaghlb@live.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http: //www.gnu.org/licenses/>.
 */
import QtQuick 2.2
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: main

    anchors.fill: parent

    property bool vertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)

    property int manualStartingBrightness: 100
    property int manualBrightness: manualStartingBrightness
    property int currentBrightness: manualStartingBrightness

    //
    // terminal commands
    // - commands
    property string brightnessValue: '' + (currentBrightness * 0.01).toFixed(2)
    property string changeBrightnessCommand: 'xrandr --output HDMI1 --brightness ' + brightnessValue


    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: CompactRepresentation { }


    PlasmaCore.DataSource {
        id: brightyDS
        engine: 'executable'

        onNewData: {
            connectedSources.length = 0
        }
    }


    Plasmoid.toolTipMainText: i18n('HDMI Brightness Control')
    Plasmoid.toolTipSubText: 'Control HDMI Monitor Brightness'
    Plasmoid.toolTipTextFormat: Text.RichText
    Plasmoid.icon: 'im-jabber'

}

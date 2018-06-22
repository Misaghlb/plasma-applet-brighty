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

    property string monitor_name: ''

    //
    // terminal commands
    // - commands
    property string brightnessValue: '' + (currentBrightness * 0.01).toFixed(2)
    property string changeBrightnessCommand: 'xrandr --output ' + monitor_name + ' --brightness ' + brightnessValue
    property string mon_list_Command: "xrandr | grep \" connected \" | awk '{ print$1 }' "

    property var mon_list
    property ListModel items: ListModel {}


    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: CompactRepresentation { }
    Plasmoid.fullRepresentation: FullRepresentation {}



    PlasmaCore.DataSource {
        id: brightyDS
        engine: 'executable'

        onNewData: {
            connectedSources.length = 0
            // get list of monitors
            if (sourceName == mon_list_Command){
                main.mon_list = data.stdout.split('\n')
                items.clear()
                if (main.mon_list.length > 0)
                {
                    for (var i = 0; i < main.mon_list.length; ++i)
                    {
                        if ( main.mon_list[i] != ""){
                            items.append({"name": main.mon_list[i]})
                        }

                    }
                }
                // set default monitor
                if (monitor_name == ''){
                    monitor_name = main.mon_list[0]
                }
            }
        }
    }


    Plasmoid.toolTipMainText: i18n('HDMI Brightness Control')
    Plasmoid.toolTipSubText: 'Control HDMI Monitor Brightness'
    Plasmoid.toolTipTextFormat: Text.RichText
    Plasmoid.icon: 'im-jabber'

    Component.onCompleted: {
        brightyDS.connectedSources.push(mon_list_Command)
    }

}

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "./modules"

ShellRoot {
    PanelWindow {
        id: window
        implicitWidth: 1050
        implicitHeight: 820
        WlrLayershell.namespace: "quickshell:hotbar" 
        color: "transparent"
        anchors { top: true; left: true }
        margins {
            top: 5
            left: (screen.width - implicitWidth) / 2
        }

        exclusiveZone: 0

        // КОРНЕВАЯ ПОДЛОЖКА ВСЕГО ОКНА
        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0.0196, 0.0431, 0.1294, 0.9)
            radius: 20 
            border.color: Qt.rgba(0.027, 0.055, 0.129, 0.7)
            border.width: 1

            RowLayout {
                anchors.fill: parent
                anchors.margins: 16 
                spacing: 16 

                Sidebar {
                    id: sidebar

                    Layout.preferredWidth: 72
                    Layout.fillHeight: true

                    onItemClicked: (index, name) =>
                        console.log("Sidebar ->", name)

                    onPowerClicked:
                        console.log("Power clicked")
                }

                ColumnLayout {
                    Layout.preferredWidth: 450
                    Layout.fillHeight: true
                    spacing: 20

                    WeatherCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 330
                    }

                    SystemCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 205
                    }

                    MusicPlayerCard {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }

                ColumnLayout {
                    Layout.preferredWidth: 380
                    Layout.fillHeight: true
                    spacing: 20

                    NotificationsCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 330
                    }

                    CalendarCard {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 320
                    }

                    EventsCard {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}

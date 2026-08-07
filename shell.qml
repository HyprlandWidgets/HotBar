import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Wayland
import "./"

ShellRoot {
    PanelWindow {
        id: window
        width: 770
        height: 750
        WlrLayershell.namespace: "quickshell:hotbar"
        color: "transparent"
        anchors {
            top: true
            left: true
        }

        margins {
            top: 5
            left: (screen.width - width) / 2
        }


        Rectangle {
            id: windowBackground
            anchors.fill: parent
            radius: 24
            color: "transparent"


            Image {
                id: backgroundImage
                anchors.fill: parent
                source: "./assest/blur.jpg"
                fillMode: Image.PreserveAspectCrop
                smooth: true
                visible: false
            }


            Rectangle {
                id: backgroundMask
                anchors.fill: parent
                radius: 24
                color: "white"
                visible: false
            }

            OpacityMask {
                anchors.fill: parent
                source: backgroundImage
                maskSource: backgroundMask
            }

            Rectangle {
                anchors.fill: parent
                radius: 24
                color: Qt.rgba(0.0196, 0.0431, 0.1294, 0.75)
            }

            GridLayout {
                anchors.fill: parent
                anchors.margins: 12
                columns: 2
                columnSpacing: 12


                Sidebar {
                    Layout.column: 0
                    Layout.preferredWidth: 70
                    Layout.fillHeight: true
                    radius: 18
                }


                GridLayout {
                    id: dashboard
                    Layout.column: 1
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    columns: 2
                    rowSpacing: 12
                    columnSpacing: 12


                    WeatherCard {
                        Layout.row: 0
                        Layout.column: 0
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }


                    NotificationsCard {
                        Layout.row: 0
                        Layout.column: 1
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }


                    SystemCard {
                        Layout.row: 1
                        Layout.column: 0
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }


                    CalendarCard {
                        Layout.row: 1
                        Layout.column: 1
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }


                    MusicPlayerCard {
                        Layout.row: 2
                        Layout.column: 0
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }


                    EventsCard {
                        Layout.row: 2
                        Layout.column: 1
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                    }


                    Rectangle {
                        id: quickAccessPlaceholder
                        Layout.row: 4
                        Layout.column: 0
                        Layout.columnSpan: 2
                        Layout.fillWidth: true
                        Layout.preferredHeight: 70
                        radius: 16
                        color: Qt.rgba(0.05, 0.10, 0.20, 0.65)
                    }
                }
            }
        }
    }
}
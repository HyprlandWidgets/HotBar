import QtQuick
import QtQuick.Layouts
import "../"

Rectangle {
    id: root
    // Более тёмный и плоский фон, как на полном скриншоте
    color: "#030918"

    // Градиент сильно приглушён (в пустом состоянии почти не читается)
    gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { position: 0.0;  color: "#1A5A7A40" }  
        GradientStop { position: 0.06; color: "#0C3A5A30" }
        GradientStop { position: 0.22; color: "transparent" }
    }

    border.color: Qt.rgba(0.45, 0.62, 1.0, 0.10)
    border.width: 1
    radius: Theme.radiusLg

    property string title: "Система"
    property string modeLabel: "Производительность"
    signal modeClicked()

    property int cpuUsage: -1
    property int cpuTemp: -1
    property var cpuHistory: []

    property int gpuUsage: -1
    property int gpuTemp: -1
    property var gpuHistory: []

    property int ramUsage: -1
    property string ramLabel: ""

    property int diskUsage: -1
    property string diskLabel: ""

    // Цвет внутренних плиток — едва отличим от фона
    readonly property color tileBg: Qt.rgba(0.04, 0.07, 0.20, 0.55)

    GridLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        columns: 1
        rowSpacing: Theme.spacingLg

        RowLayout {
            Layout.fillWidth: true

            Text {
                text: root.title
                color: "#8E94A8"                    // ближе к скриншоту
                font.pixelSize: 16
                font.bold: true
                font.family: Theme.fontFamily
            }

            Item { Layout.fillWidth: true }

            RowLayout {
                spacing: 4

                Text {
                    text: root.modeLabel
                    color: "#5C6478"
                    font.pixelSize: 12
                    font.family: Theme.fontFamily
                }

                Text {
                    text: Theme.glyph("expand_more")
                    font.family: Theme.fontFamily
                    font.pixelSize: 16
                    color: "#5C6478"
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: root.modeClicked()
                }
            }
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 4
            columnSpacing: Theme.spacingMd
            rowSpacing: Theme.spacingMd

            SparkTile {
                color: root.tileBg
                Layout.fillWidth: true
                Layout.fillHeight: true
                label: "CPU"
                value: root.cpuUsage
                subLabel: root.cpuTemp >= 0 ? ("Температура " + root.cpuTemp + "°C") : Theme.textNoData
                accent: Theme.colorCpu
                history: root.cpuHistory
            }

            SparkTile {
                color: root.tileBg
                Layout.fillWidth: true
                Layout.fillHeight: true
                label: "GPU"
                value: root.gpuUsage
                subLabel: root.gpuTemp >= 0 ? ("Температура " + root.gpuTemp + "°C") : Theme.textNoData
                accent: Theme.colorGpu
                history: root.gpuHistory
            }

            BarTile {
                color: root.tileBg
                Layout.fillWidth: true
                Layout.fillHeight: true
                label: "RAM"
                value: root.ramUsage
                subLabel: root.ramLabel
                accent: Theme.accent
            }

            BarTile {
                color: root.tileBg
                Layout.fillWidth: true
                Layout.fillHeight: true
                label: "DISK"
                value: root.diskUsage
                subLabel: root.diskLabel
                accent: Theme.colorGpu
            }
        }
    }
}
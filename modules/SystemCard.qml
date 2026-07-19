import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    color: Theme.bgCard
    radius: Theme.radiusLg
    border.width: 1
    border.color: Theme.border
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

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        spacing: Theme.spacingLg

        RowLayout {
            Layout.fillWidth: true
            Text { text: root.title; color: Theme.textPrimary; font.pixelSize: 16; font.bold: true; font.family: Theme.fontFamily }
            Item { Layout.fillWidth: true }
            RowLayout {
                spacing: 4
                Text { text: root.modeLabel; color: Theme.textSecondary; font.pixelSize: 12; font.family: Theme.fontFamily }
                Text { text: Theme.glyph("expand_more"); font.family: Theme.fontFamily; font.pixelSize: 16; color: Theme.textSecondary }
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.modeClicked() }
            }
        }

        GridLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            columns: 4
            columnSpacing: Theme.spacingMd
            rowSpacing: Theme.spacingMd

            SparkTile {
                Layout.fillWidth: true; Layout.fillHeight: true
                label: "CPU"; value: root.cpuUsage
                subLabel: root.cpuTemp >= 0 ? ("Температура " + root.cpuTemp + "°C") : Theme.textNoData
                accent: Theme.colorCpu; history: root.cpuHistory
            }
            SparkTile {
                Layout.fillWidth: true; Layout.fillHeight: true
                label: "GPU"; value: root.gpuUsage
                subLabel: root.gpuTemp >= 0 ? ("Температура " + root.gpuTemp + "°C") : Theme.textNoData
                accent: Theme.colorGpu; history: root.gpuHistory
            }
            BarTile {
                Layout.fillWidth: true; Layout.fillHeight: true
                label: "RAM"; value: root.ramUsage; subLabel: root.ramLabel; accent: Theme.accent
            }
            BarTile {
                Layout.fillWidth: true; Layout.fillHeight: true
                label: "DISK"; value: root.diskUsage; subLabel: root.diskLabel; accent: Theme.colorGpu
            }
        }
    }
}

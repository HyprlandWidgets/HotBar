import QtQuick
import QtQuick.Layouts

// Плитка с полосой прогресса (для RAM/DISK)
Rectangle {
    property string label: "RAM"
    property int value: 0
    property string subLabel: ""
    property color accent: Theme.accent

    radius: Theme.radiusMd
    color: Theme.bgTile

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 4

        readonly property bool noData: value < 0

        Text { text: label; color: Theme.textSecondary; font.pixelSize: 12; font.family: Theme.fontFamily }
        Text {
            text: noData ? Theme.textNoData : (value + "%")
            color: noData ? Theme.textMuted : Theme.textPrimary
            font.pixelSize: noData ? 14 : 22
            font.bold: !noData
            font.family: Theme.fontFamily
        }
        Text { text: noData ? "" : subLabel; color: Theme.textMuted; font.pixelSize: 11; font.family: Theme.fontFamily }

        Item { Layout.fillHeight: true }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 6
            radius: 3
            color: "#26FFFFFF"
            Rectangle {
                visible: !noData
                width: parent.width * Math.min(Math.max(value / 100, 0), 1)
                height: parent.height
                radius: 3
                color: accent
                Behavior on width { NumberAnimation { duration: 300 } }
            }
        }
    }
}

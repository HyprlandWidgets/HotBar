import QtQuick
import QtQuick.Layouts

RowLayout {
    property string timeLabel: ""
    property string eventTitle: ""
    property string duration: ""
    property string source: ""
    property color dotColor: Theme.accent
    signal clicked()

    spacing: 12

    Rectangle {
        Layout.alignment: Qt.AlignTop
        Layout.topMargin: 6
        width: 8; height: 8; radius: 4
        color: dotColor
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 2
        RowLayout {
            Layout.fillWidth: true
            Text { text: timeLabel; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true; font.family: Theme.fontFamily }
            Text { text: eventTitle; color: Theme.textPrimary; font.pixelSize: 13; font.family: Theme.fontFamily; Layout.leftMargin: 4 }
            Item { Layout.fillWidth: true }
            Text { text: duration; color: Theme.textMuted; font.pixelSize: 11; font.family: Theme.fontFamily }
        }
        Text { text: source; color: Theme.textSecondary; font.pixelSize: 11; font.family: Theme.fontFamily }
    }

    MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: parent.clicked() }
}

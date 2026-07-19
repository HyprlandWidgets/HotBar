import QtQuick
import QtQuick.Layouts

RowLayout {
    property string iconGlyph: "notifications"
    property color iconColor: Theme.accent
    property string appName: ""
    property string message: ""
    property string timeLabel: ""
    property bool unread: false
    signal clicked()

    spacing: 12

    Rectangle {
        width: 40; height: 40
        radius: Theme.radiusSm
        color: iconColor
        Text {
            anchors.centerIn: parent
            text: Theme.glyph(iconGlyph)
            font.family: Theme.fontFamily
            font.pixelSize: 18
            color: "#FFFFFF"
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        spacing: 2
        RowLayout {
            Layout.fillWidth: true
            Text { text: appName; color: Theme.textPrimary; font.pixelSize: 13; font.bold: true; font.family: Theme.fontFamily }
            Item { Layout.fillWidth: true }
            Text { text: timeLabel; color: Theme.textMuted; font.pixelSize: 11; font.family: Theme.fontFamily }
        }
        Text {
            text: message
            color: Theme.textSecondary
            font.pixelSize: 12
            font.family: Theme.fontFamily
            elide: Text.ElideRight
            Layout.fillWidth: true
        }
    }

    Rectangle {
        visible: unread
        width: 7; height: 7; radius: 3.5
        color: Theme.accent
        Layout.alignment: Qt.AlignTop
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: parent.clicked()
    }
}

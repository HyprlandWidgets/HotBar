import QtQuick
import QtQuick.Layouts
import "../"

Rectangle {
      gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { position: 0.0;  color: "#1A5A7A40" }  
        GradientStop { position: 0.06; color: "#0C3A5A30" }
        GradientStop { position: 0.22; color: "transparent" }
    }
    border.color: Qt.rgba(
    0.45,
    0.62,
    1.0,
    0.14
)
    id: root
    radius: Theme.radiusLg
    property string title: "Уведомления"
    property var notifications: []
    readonly property int unreadCount: notifications.filter(n => n.unread).length
    signal notificationClicked(int index)
    signal showAllClicked()

    GridLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        columns: 1
        rowSpacing: Theme.spacingMd

        RowLayout {
            Layout.fillWidth: true
            Text { text: root.title; color: Theme.textPrimary; font.pixelSize: 16; font.bold: true; font.family: Theme.fontFamily }
            Item { Layout.fillWidth: true }
            Text {
                text: root.notifications.length > 0 ? (root.unreadCount + " новых") : Theme.textNoData
                color: root.notifications.length > 0 ? Theme.accent : Theme.textMuted
                font.pixelSize: 12
                font.family: Theme.fontFamily
            }
        }

        GridLayout {
            Layout.fillWidth: true
            columns: 1
            rowSpacing: Theme.spacingMd
            Repeater {
                model: root.notifications
                delegate: NotificationRow {
                    required property var modelData
                    required property int index
                    Layout.fillWidth: true
                    appName: modelData.app
                    iconGlyph: modelData.icon
                    iconColor: modelData.color
                    message: modelData.message
                    timeLabel: modelData.time
                    unread: modelData.unread
                    onClicked: root.notificationClicked(index)
                }
            }

            Text {
                visible: root.notifications.length === 0
                text: Theme.textNoData
                color: Theme.textMuted
                font.pixelSize: 12
                font.family: Theme.fontFamily
            }
        }

        Item { Layout.fillHeight: true }

        Text {
            visible: root.notifications.length > 0
            Layout.alignment: Qt.AlignHCenter
            text: "Показать все уведомления  ›"
            color: Theme.accent
            font.pixelSize: 12
            font.family: Theme.fontFamily
            MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.showAllClicked() }
        }
    }
}

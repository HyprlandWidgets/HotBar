import QtQuick
import QtQuick.Layouts

Rectangle {
     gradient: Gradient {
        GradientStop {
            position: 0.5
            color: "#CC121321"
        }

        GradientStop {
            position: 0.5
             color: "#090E2C"
        }
    }
    id: root
    color: Theme.bgCard
    radius: Theme.radiusLg
    border.width: 1
    border.color: Theme.border
    property string title: "Уведомления"
    property var notifications: []
    readonly property int unreadCount: notifications.filter(n => n.unread).length
    signal notificationClicked(int index)
    signal showAllClicked()

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        spacing: Theme.spacingMd

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

        ColumnLayout {
            Layout.fillWidth: true
            spacing: Theme.spacingMd
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

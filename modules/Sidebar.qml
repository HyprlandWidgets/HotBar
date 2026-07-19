import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    color: Theme.bgCard
    radius: Theme.radiusLg
    border.width: 1
    border.color: Theme.border
    anchors.top: anchors.top = true
    height: parent.height
    property var items: [
        { icon: "home", name: "home" },
        { icon: "notifications", name: "notifications" },
        { icon: "cloud", name: "weather" },
        { icon: "desktop_windows", name: "system" },
        { icon: "calendar_month", name: "calendar" },
        { icon: "settings", name: "settings" }
    ]
    property int activeIndex: 0

    signal itemClicked(int index, string name)
    signal powerClicked()
    
    ColumnLayout {
        anchors.fill: parent
        anchors.top: anchors.top = true
        height: parent.height
        spacing: 12

        Repeater {
            model: root.items
            delegate: SidebarButton {
                required property var modelData
                required property int index
                Layout.alignment: Qt.AlignHCenter
                iconGlyph: modelData.icon
                active: index === root.activeIndex
                onClicked: {
                    root.activeIndex = index
                    root.itemClicked(index, modelData.name)
                }
            }
        }

        Item { Layout.fillHeight: true }

        SidebarButton {
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 4
            iconGlyph: "power_settings_new"
            circular: true
            onClicked: root.powerClicked()
        }
    }
}

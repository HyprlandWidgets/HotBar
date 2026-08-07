import QtQuick
import QtQuick.Layouts
import "../../"

Rectangle {
    id: root

    implicitWidth: 72
    implicitHeight: parent ? parent.height * 0.96 : 720
    radius: 16
    color: "#09142C"

    border.width: 1
    border.color: Qt.rgba(0.25, 0.40, 0.75, 0.12)

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        z: -1

        gradient: Gradient {
            orientation: Gradient.Vertical

            GradientStop { position: 0.0;  color: "#04081E" }   // чуть темнее сверху
            GradientStop { position: 0.15; color: "#09142C" }
            GradientStop { position: 0.85; color: "#09142C" }
            GradientStop { position: 1.0;  color: "#04081E" }   // чуть темнее снизу
        }
    }

    property var items: [
        { icon: "home",            name: "home" },
        { icon: "notifications",   name: "notifications" },
        { icon: "cloud",           name: "weather" },
        { icon: "desktop_windows", name: "system" },
        { icon: "calendar_month",  name: "calendar" },
        { icon: "settings",        name: "settings" }
    ]

    property int activeIndex: 0

    signal itemClicked(int index, string name)
    signal powerClicked()

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: 12
        anchors.bottomMargin: 12
        spacing: 30

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
            iconGlyph: "power_settings_new"
            circular: true
            onClicked: root.powerClicked()
        }
    }
}
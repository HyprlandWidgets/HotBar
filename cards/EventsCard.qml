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
    property var monthNamesGenitive: ["января", "февраля", "марта", "апреля", "мая", "июня",
                                        "июля", "августа", "сентября", "октября", "ноября", "декабря"]
    property date _now: new Date()
    readonly property string dateLabel: "Сегодня, " + _now.getDate() + " " + monthNamesGenitive[_now.getMonth()]
    signal eventClicked(int index)

    GridLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        columns: 1
        rowSpacing: Theme.spacingMd

        Text { text: root.dateLabel; color: Theme.textPrimary; font.pixelSize: 15; font.bold: true; font.family: Theme.fontFamily }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: Theme.spacingMd

            Repeater {
                model: root.events
                delegate: EventRow {
                    required property var modelData
                    required property int index
                    Layout.fillWidth: true
                    timeLabel: modelData.time
                    eventTitle: modelData.title
                    duration: modelData.duration
                    source: modelData.source
                    dotColor: modelData.color
                    onClicked: root.eventClicked(index)
                }
            }

            Text {
                visible: root.events.length === 0
                text: Theme.textNoData
                color: Theme.textMuted
                font.pixelSize: 12
                font.family: Theme.fontFamily
            }

            Item { Layout.fillHeight: true }
        }
    }
}

import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    color: Theme.bgCard
    radius: Theme.radiusLg
    border.width: 1
    border.color: Theme.border
    property var monthNamesGenitive: ["января", "февраля", "марта", "апреля", "мая", "июня",
                                        "июля", "августа", "сентября", "октября", "ноября", "декабря"]
    property date _now: new Date()
    readonly property string dateLabel: "Сегодня, " + _now.getDate() + " " + monthNamesGenitive[_now.getMonth()]
    signal eventClicked(int index)

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        spacing: Theme.spacingMd

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

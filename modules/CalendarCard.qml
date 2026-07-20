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
    property date _now: new Date()
    property int year: _now.getFullYear()
    property int month: _now.getMonth() + 1   // 1..12
    property int selectedDay: _now.getDate()
    property var weekDayLabels: ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    readonly property var monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
                                        "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    readonly property string monthLabel: monthNames[month - 1] + " " + year

    signal prevMonthClicked()
    signal nextMonthClicked()
    signal dayClicked(int day)

    function buildGrid() {
        let first = new Date(year, month - 1, 1)
        // JS: 0=Вс..6=Сб -> переводим на понедельник=0
        let startOffset = (first.getDay() + 6) % 7
        let daysInMonth = new Date(year, month, 0).getDate()
        let daysInPrevMonth = new Date(year, month - 1, 0).getDate()

        var cells = []
        for (var i = 0; i < startOffset; i++) {
            cells.push({ day: daysInPrevMonth - startOffset + i + 1, currentMonth: false })
        }
        for (var d = 1; d <= daysInMonth; d++) {
            cells.push({ day: d, currentMonth: true })
        }
        var next = 1
        while (cells.length % 7 !== 0 || cells.length < 42) {
            cells.push({ day: next, currentMonth: false })
            next++
            if (cells.length >= 42) break
        }
        return cells
    }

    property var gridDays: buildGrid()
    onYearChanged: gridDays = buildGrid()
    onMonthChanged: gridDays = buildGrid()

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        spacing: Theme.spacingMd

        RowLayout {
            Layout.fillWidth: true
            Text { text: root.monthLabel; color: Theme.textPrimary; font.pixelSize: 16; font.bold: true; font.family: Theme.fontFamily }
            Item { Layout.fillWidth: true }
            Text {
                text: Theme.glyph("chevron_left"); font.family: Theme.fontFamily; font.pixelSize: 18; color: Theme.textSecondary
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.prevMonthClicked() }
            }
            Text {
                text: Theme.glyph("chevron_right"); font.family: Theme.fontFamily; font.pixelSize: 18; color: Theme.textSecondary
                Layout.leftMargin: 12
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.nextMonthClicked() }
            }
        }

        GridLayout {
            Layout.alignment: Qt.AlignHCenter 
            columns: 7
            columnSpacing: 16
            rowSpacing: 4

            Repeater {
                model: root.weekDayLabels
                delegate: Text {
                    required property string modelData
                    Layout.preferredWidth: 40
                    horizontalAlignment: Text.AlignHCenter
                    text: modelData
                    color: Theme.textMuted
                    font.pixelSize: 11
                    font.family: Theme.fontFamily
                }
            }

            Repeater {
                model: root.gridDays
                delegate: DayCell {
                    required property var modelData
                    day: modelData.day
                    currentMonth: modelData.currentMonth
                    selected: currentMonth && day === root.selectedDay
                    onClicked: { root.selectedDay = day; root.dayClicked(day) }
                }
            }
        }
    }
}

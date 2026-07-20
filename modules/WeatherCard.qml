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
    property var weekDayNames: ["воскресенье", "понедельник", "вторник", "среда", "четверг", "пятница", "суббота"]
    property var monthNamesGenitive: ["января", "февраля", "марта", "апреля", "мая", "июня",
                                        "июля", "августа", "сентября", "октября", "ноября", "декабря"]
    property date now: new Date()
    Timer { interval: 1000; running: true; repeat: true; onTriggered: root.now = new Date() }

    readonly property string greeting: {
        var h = now.getHours()
        if (h >= 5 && h < 12) return "Доброе утро!"
        if (h >= 12 && h < 18) return "Добрый день!"
        if (h >= 18 && h < 23) return "Добрый вечер!"
        return "Доброй ночи!"
    }
    readonly property string dateLabel: "Сегодня " + now.getDate() + " " + monthNamesGenitive[now.getMonth()] + ", " + weekDayNames[now.getDay()]
    readonly property string timeLabel: Qt.formatTime(now, "hh:mm")
    property bool weatherDataAvailable: false
    property int temperature: 0
    property string conditionLabel: Theme.textNoData
    property string weatherIconGlyph: ""

    property int feelsLike: 0
    property int humidity: 0
    property int windSpeed: 0

    // TODO: заменить на данные из погодного сервиса/API (7 дней)
    property var forecast: []

    signal menuClicked()

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        spacing: Theme.spacingLg

        // Заголовок
        RowLayout {
            Layout.fillWidth: true
            ColumnLayout {
                spacing: 2
                Text {
                    text: root.greeting
                    color: Theme.textPrimary
                    font.pixelSize: 20
                    font.bold: true
                    font.family: Theme.fontFamily
                }
                Text {
                    text: root.dateLabel
                    color: Theme.textSecondary
                    font.pixelSize: 12
                    font.family: Theme.fontFamily
                }
            }
            Item { Layout.fillWidth: true }
            Text {
                text: root.timeLabel
                color: Theme.textPrimary
                font.pixelSize: 14
                font.family: Theme.fontFamily
            }
            Text {
                text: Theme.glyph("more_vert")
                font.family: Theme.fontFamily
                font.pixelSize: 18
                color: Theme.textMuted
                Layout.leftMargin: 8
                MouseArea { anchors.fill: parent; cursorShape: Qt.PointingHandCursor; onClicked: root.menuClicked() }
            }
        }

        // Текущая погода + доп. инфо
        RowLayout {
            Layout.fillWidth: true
            spacing: Theme.spacingLg

            RowLayout {
                spacing: 12
                Rectangle {
                    width: 56; height: 56
                    radius: 28
                    color: "#1E2038"
                    Text {
                        anchors.centerIn: parent
                        text: root.weatherDataAvailable ? Theme.glyph(root.weatherIconGlyph) : "?"
                        font.family: Theme.fontFamily
                        font.pixelSize: 30
                        color: "#8FB4FF"
                    }
                }
                ColumnLayout {
                    spacing: 4
                    Text {
                        text: root.weatherDataAvailable ? (root.temperature + "°C") : Theme.textNoData
                        color: root.weatherDataAvailable ? Theme.textPrimary : Theme.textMuted
                        font.pixelSize: root.weatherDataAvailable ? 26 : 15
                        font.bold: root.weatherDataAvailable
                        font.family: Theme.fontFamily
                    }
                    Text {
                        text: root.weatherDataAvailable ? root.conditionLabel : ""
                        color: Theme.textSecondary
                        font.pixelSize: 12
                        font.family: Theme.fontFamily
                    }
                }
            }
           
            Item { Layout.fillWidth: true }

            Rectangle {
                Layout.preferredWidth: 215
                Layout.preferredHeight: 90
                radius: Theme.radiusMd
                color: Theme.bgTile
                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 3
                    spacing: 0
                    InfoRow { iconGlyph: "thermostat"; label: "Ощущается как"; value: root.weatherDataAvailable ? (root.feelsLike + "°") : Theme.textNoData }
                    InfoRow { iconGlyph: "water_drop"; label: "Влажность"; value: root.weatherDataAvailable ? (root.humidity + "%") : Theme.textNoData }
                    InfoRow { iconGlyph: "air"; label: "Ветер"; value: root.weatherDataAvailable ? (root.windSpeed + " км/ч") : Theme.textNoData }
                }
            }
        }

        // Прогноз на неделю
        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 0

            Text {
                visible: root.forecast.length === 0
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                text: Theme.textNoData
                color: Theme.textMuted
                font.pixelSize: 12
                font.family: Theme.fontFamily
            }

            Repeater {
                model: root.forecast
                delegate: ForecastDay {
                    required property var modelData
                    Layout.fillWidth: true
                    dayLabel: modelData.day
                    iconGlyph: modelData.icon
                    high: modelData.high
                    low: modelData.low
                }
            }
        }
    }
}

import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../"
import "../utils/greeting/greeting.js" as Greeting
import "../utils/date/date.js" as DateTime

Rectangle {
    id: root
    radius: 28
    clip: true

    border.width: 1
    border.color: Theme.border

    property var now: DateTime.getObjectDate()
    property string greeting: ""
    property string dateLabel: ""
    readonly property string timeLabel: Qt.formatTime(now, "hh:mm")

    property bool weatherDataAvailable: false
    property int temperature: 0
    property string conditionLabel: "Нет данных"
    property string weatherIconGlyph: "cloud"
    property int feelsLike: 0
    property int humidity: 0
    property int windSpeed: 0
    property var forecast: []

    Item {
        anchors.fill: parent
        z: 0

        Image {
            id: backgroundImage
            anchors.fill: parent
            source: "../assest/weather.png"
            fillMode: Image.PreserveAspectCrop
            visible: false
        }

        Rectangle {
            id: backgroundMask
            anchors.fill: parent
            radius: root.radius
            color: "white"
            visible: false
        }

        OpacityMask {
            anchors.fill: parent
            source: backgroundImage
            maskSource: backgroundMask
        }
    }

    Rectangle {
        anchors.fill: parent
        radius: root.radius
        color: Qt.rgba(0.02, 0.04, 0.12, 0.55)
        z: 1
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            greeting = Greeting.determinateTheTimeOfDay()
            root.now = DateTime.getObjectDate()
            dateLabel = DateTime.getGreeting()
        }
    }


    GridLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        columns: 1
        rowSpacing: 5
        z: 2

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


            Item {
                Layout.fillWidth: true
            }

            Text {
                text: root.timeLabel
                color: Theme.textPrimary
                font.pixelSize: 16
                font.family: Theme.fontFamily
            }

            Text {
                text: Theme.glyph("more_vert")
                color: Theme.textMuted
                font.pixelSize: 18
            }
        }

        GridLayout {
            Layout.fillWidth: true
            columns: 1
            columnSpacing: 4
            RowLayout {
                Layout.fillWidth: true
                spacing: 5
                Rectangle {
                    width: 50
                    height: 50
                    radius: 35
                    color: Qt.rgba(0.1, 0.12, 0.22, 0.8)
                    Text {
                        anchors.centerIn: parent
                        text: root.weatherDataAvailable
                              ? Theme.glyph(root.weatherIconGlyph)
                              : "?"
                        color: "#8FB4FF"
                        font.pixelSize: 19
                    }
                }
                
                ColumnLayout {
                    spacing: 2
                    Text {
                        text: root.weatherDataAvailable ? root.temperature + "°C" : "--°C"
                        color: Theme.textPrimary
                        font.pixelSize: 19
                        font.bold: true
                    }

                    Text {
                        text: root.conditionLabel
                        color: Theme.textSecondary
                        font.pixelSize: 13
                    }
                }
            }
        }   
    }

        Repeater {
            model: root.forecast
            delegate: ForecastDay {
                Layout.fillWidth: true
                dayLabel: modelData.day
                iconGlyph: modelData.icon
                high: modelData.high
                low: modelData.low
            }
        }
    }

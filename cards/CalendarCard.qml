import QtQuick
import QtQuick.Layouts
import "../"


Rectangle {
    id: root

    radius: Theme.radiusLg

     gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { position: 0.0;  color: "#1A5A7A40" }  
        GradientStop { position: 0.06; color: "#0C3A5A30" }
        GradientStop { position: 0.22; color: "transparent" }
    }

    border.width: 1
    border.color: Qt.rgba(
        0.45,
        0.62,
        1.0,
        0.14
    )


    property date _now: new Date()

    property int year: _now.getFullYear()
    property int month: _now.getMonth() + 1
    property int selectedDay: _now.getDate()

    property var weekDayLabels: [
        "Пн",
        "Вт",
        "Ср",
        "Чт",
        "Пт",
        "Сб",
        "Вс"
    ]

    readonly property var monthNames: [
        "Январь",
        "Февраль",
        "Март",
        "Апрель",
        "Май",
        "Июнь",
        "Июль",
        "Август",
        "Сентябрь",
        "Октябрь",
        "Ноябрь",
        "Декабрь"
    ]

    readonly property string monthLabel:
        monthNames[month - 1] + " " + year


    signal prevMonthClicked()
    signal nextMonthClicked()
    signal dayClicked(int day)



    function buildGrid() {

        let first = new Date(
            year,
            month - 1,
            1
        )

        let startOffset =
            (first.getDay() + 6) % 7


        let daysInMonth =
            new Date(
                year,
                month,
                0
            ).getDate()


        let daysInPrevMonth =
            new Date(
                year,
                month - 1,
                0
            ).getDate()


        let cells = []


        for (let i = 0; i < startOffset; i++) {

            cells.push({
                day:
                    daysInPrevMonth -
                    startOffset +
                    i +
                    1,

                currentMonth:false
            })
        }


        for (let d = 1; d <= daysInMonth; d++) {

            cells.push({
                day:d,
                currentMonth:true
            })
        }


        let next = 1

        while (cells.length < 42) {

            cells.push({
                day:next,
                currentMonth:false
            })

            next++
        }


        return cells
    }



    property var gridDays: buildGrid()


    onYearChanged:
        gridDays = buildGrid()

    onMonthChanged:
        gridDays = buildGrid()



    GridLayout {

        anchors.fill: parent
        anchors.margins: Theme.cardPadding


        columns: 1
        rows: 2


        rowSpacing: Theme.spacingMd



        // HEADER

        RowLayout {

            Layout.fillWidth: true


            Text {

                text: root.monthLabel

                color: Theme.textPrimary

                font.pixelSize: 16
                font.bold: true
                font.family: Theme.fontFamily
            }


            Item {
                Layout.fillWidth: true
            }


            Text {

                text: Theme.glyph("chevron_left")

                color: Theme.textSecondary

                font.pixelSize:18
                font.family:Theme.fontFamily


                MouseArea {

                    anchors.fill: parent

                    cursorShape:
                        Qt.PointingHandCursor


                    onClicked:
                        root.prevMonthClicked()
                }
            }



            Text {

                text: Theme.glyph("chevron_right")

                color: Theme.textSecondary

                font.pixelSize:18
                font.family:Theme.fontFamily


                Layout.leftMargin:12


                MouseArea {

                    anchors.fill: parent

                    cursorShape:
                        Qt.PointingHandCursor


                    onClicked:
                        root.nextMonthClicked()
                }
            }
        }



        // CALENDAR GRID


        GridLayout {

            id: calendarGrid


            Layout.fillWidth:true
            Layout.fillHeight:true


            columns:7


            columnSpacing:0
            rowSpacing:4



            Repeater {

                model:
                    root.weekDayLabels



                delegate: Text {


                    required property string modelData


                    Layout.fillWidth:true

                    Layout.preferredHeight:24


                    text:modelData


                    color:
                        Theme.textMuted


                    font.pixelSize:11
                    font.family:
                        Theme.fontFamily


                    horizontalAlignment:
                        Text.AlignHCenter


                    verticalAlignment:
                        Text.AlignVCenter
                }
            }



            Repeater {

                model:
                    root.gridDays



                delegate: Item {


                    Layout.fillWidth:true
                    Layout.fillHeight:true


                    implicitWidth:
                        calendarGrid.width / 7


                    implicitHeight:
                        implicitWidth



                    DayCell {

                        anchors.centerIn:parent


                        width:
                            Math.min(
                                parent.width,
                                parent.height
                            )


                        height:
                            width



                        day:
                            modelData.day


                        currentMonth:
                            modelData.currentMonth



                        selected:
                            currentMonth &&
                            day === root.selectedDay



                        onClicked: {

                            root.selectedDay = day

                            root.dayClicked(day)
                        }
                    }
                }
            }
        }
    }
}
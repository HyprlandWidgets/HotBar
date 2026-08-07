import QtQuick
import QtQuick.Layouts
import "../../"

// Плитка со спарклайном (для CPU/GPU)
Rectangle {
    property string label: "CPU"
    property int value: 0
    property string subLabel: ""
    property color accent: Theme.colorCpu
    // История значений 0..100 для мини-графика. Пушь сюда новые точки для динамики.
    property var history: [30, 45, 25, 60, 40, 55, 35, 50, 30, 45]

    radius: Theme.radiusMd
    color: Theme.bgTile

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 14
        spacing: 4

        readonly property bool noData: value < 0 || history.length < 2

        Text { text: label; color: Theme.textSecondary; font.pixelSize: 12; font.family: Theme.fontFamily }
        Text {
            text: noData ? Theme.textNoData : (value + "%")
            color: noData ? Theme.textMuted : Theme.textPrimary
            font.pixelSize: noData ? 14 : 22
            font.bold: !noData
            font.family: Theme.fontFamily
        }
        Text { text: noData ? "" : subLabel; color: Theme.textMuted; font.pixelSize: 11; font.family: Theme.fontFamily }

        Item { Layout.fillHeight: true }

        Canvas {
            id: canvas
            Layout.fillWidth: true
            Layout.preferredHeight: 28
            visible: !noData
            property var pts: history
            onPtsChanged: requestPaint()
            onWidthChanged: requestPaint()
            onPaint: {
                var ctx = getContext("2d")
                ctx.reset()
                if (pts.length < 2) return
                ctx.strokeStyle = accent
                ctx.lineWidth = 2
                ctx.beginPath()
                var stepX = width / (pts.length - 1)
                for (var i = 0; i < pts.length; i++) {
                    var x = i * stepX
                    var y = height - (pts[i] / 100) * height
                    if (i === 0) ctx.moveTo(x, y)
                    else ctx.lineTo(x, y)
                }
                ctx.stroke()
            }
        }
    }
}

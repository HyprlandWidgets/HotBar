import QtQuick
import QtQuick.Layouts

ColumnLayout {
    property string dayLabel: "Сб"
    property string iconGlyph: "cloud"
    property int high: 20
    property int low: 10
    spacing: 6

    Text {
        Layout.alignment: Qt.AlignHCenter
        text: dayLabel
        color: Theme.textSecondary
        font.pixelSize: 12
        font.family: Theme.fontFamily
    }
    Rectangle {
        Layout.alignment: Qt.AlignHCenter
        width: 32; height: 32
        radius: 16
        color: "#1E2038"
        Text {
            anchors.centerIn: parent
            text: Theme.glyph(iconGlyph)
            font.family: Theme.fontFamily
            font.pixelSize: 18
            color: "#8FB4FF"
        }
    }
    Text {
        Layout.alignment: Qt.AlignHCenter
        text: high + "°/" + low + "°"
        color: Theme.textPrimary
        font.pixelSize: 12
        font.family: Theme.fontFamily
    }
}

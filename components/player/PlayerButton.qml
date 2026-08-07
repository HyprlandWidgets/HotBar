import QtQuick
import "../../"

Rectangle {
    id: btn
    property string iconGlyph: "play_arrow"
    property bool primary: false
    signal clicked()

    width: primary ? 44 : 34
    height: width
    radius: width / 2
    color: primary ? Theme.accent : (ma.containsMouse ? Theme.hoverBg : "transparent")

    Text {
        anchors.centerIn: parent
        text: Theme.glyph(btn.iconGlyph)
        font.family: Theme.fontFamily
        font.pixelSize: primary ? 20 : 18
        color: btn.primary ? "#FFFFFF" : Theme.textSecondary
    }
    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: btn.clicked()
    }
}

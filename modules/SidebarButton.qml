import QtQuick

Rectangle {
    id: btn
    property string iconGlyph: "home"
    property bool active: false
    property bool circular: false
    signal clicked()

    width: 52
    height: 52
    radius: circular ? width / 2 : Theme.radiusMd
    color: active ? Theme.accentSoft : (ma.containsMouse ? Theme.hoverBg : "transparent")
    border.width: active ? 1 : 0
    border.color: Theme.accent

    Behavior on color { ColorAnimation { duration: 120 } }

    Text {
        anchors.centerIn: parent
        text: Theme.glyph(btn.iconGlyph)
        font.family: Theme.fontFamily
        font.pixelSize: 22
        color: btn.active ? Theme.accent : Theme.textSecondary
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: btn.clicked()
    }
}

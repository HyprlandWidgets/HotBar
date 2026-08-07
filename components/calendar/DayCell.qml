import QtQuick
import "../../"

Rectangle {
    property int day: 1
    property bool currentMonth: true
    property bool selected: false
    signal clicked()
    
    width: 40; height: 34
    radius: Theme.radiusSm
    color: selected ? Theme.accent : (ma.containsMouse && currentMonth ? Theme.hoverBg : "transparent")

    Text {
        anchors.centerIn: parent
        text: day
        font.pixelSize: 13
        font.family: Theme.fontFamily
        color: selected ? "#FFFFFF" : (currentMonth ? Theme.textPrimary : Theme.textMuted)
    }
    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        enabled: currentMonth
        cursorShape: Qt.PointingHandCursor
        onClicked: parent.clicked()
    }
}

import QtQuick
import QtQuick.Effects
import "../../"


Rectangle {

    id: root


    property bool active: false
    property bool circular: false
    property string iconGlyph: ""

    signal clicked()

    width: active ? 42 : 32
    height: active ? 42 : 32


    radius: active ? 12 : 10



    color: active ? "#7650ff" : "transparent"



    Gradient {
        id: activeGradient

        GradientStop {
            position: 0.0
            color: "#7650ff"
        }

        GradientStop {
            position: 1.0
            color: "#4524df"
        }
    }



    gradient: active ? activeGradient : null

    Text {
        anchors.centerIn: parent
        text: Theme.glyph(iconGlyph)
        font.family: Theme.fontFamily
        font.pixelSize: active ? 18 : 16
        color: active ? "#FFFFFF" : Theme.textSecondary
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    layer.enabled: active

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }

    layer.effect: MultiEffect {

        shadowEnabled: true

        shadowBlur: 12

        shadowColor: Qt.rgba(
            110 / 255,
            75 / 255,
            255 / 255,
            0.8
        )
    }
}
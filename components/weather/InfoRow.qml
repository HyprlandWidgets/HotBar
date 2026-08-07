import QtQuick
import QtQuick.Layouts
import "../../"

RowLayout {
    property string iconGlyph: "thermostat"
    property string label: ""
    property string value: ""
    spacing: 4
    Text {
        text: Theme.glyph(iconGlyph)
        font.family: Theme.fontFamily
        font.pixelSize: 14
        color: Theme.textMuted
    }
    Text {
        text: label
        color: Theme.textSecondary
        font.pixelSize: 12
        font.family: Theme.fontFamily
        Layout.fillWidth: true
    }
    Text {
        text: value
        color: Theme.textPrimary
        font.pixelSize: 12
        font.family: Theme.fontFamily
        font.bold: true
    }
}

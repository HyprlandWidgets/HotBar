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
    
    property bool playerAvailable: false
    property url albumArt: ""            // TODO: bind to player.trackArtUrl
    property string trackTitle: Theme.textNoData
    property string trackArtist: ""
    property bool isPlaying: false
    property bool liked: false

    property real positionRatio: 0        // 0..1, TODO: player.position / player.length
    property string positionLabel: "--:--"
    property string durationLabel: "--:--"
    property real volume: 0               // 0..1

    signal playPauseClicked()
    signal previousClicked()
    signal nextClicked()
    signal likeToggled(bool liked)
    signal seekRequested(real ratio)
    signal volumeChangeRequested(real volume)

    RowLayout {
        anchors.fill: parent
        anchors.margins: Theme.cardPadding
        spacing: Theme.spacingLg

        Rectangle {
            Layout.preferredWidth: 90
            Layout.preferredHeight: 90
            radius: Theme.radiusMd
            clip: true
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#7C6BFC" }
                GradientStop { position: 1.0; color: "#2B2050" }
            }
            Image {
                anchors.fill: parent
                source: root.albumArt
                fillMode: Image.PreserveAspectCrop
                visible: root.albumArt.toString().length > 0
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: Theme.spacingSm

            RowLayout {
                Layout.fillWidth: true
                ColumnLayout {
                    spacing: 2
                    Text { text: root.trackTitle; color: Theme.textPrimary; font.pixelSize: 15; font.bold: true; font.family: Theme.fontFamily }
                    Text { text: root.trackArtist; color: Theme.textSecondary; font.pixelSize: 12; font.family: Theme.fontFamily }
                }
                Item { Layout.fillWidth: true }
                Rectangle {
                    visible: root.isPlaying
                    radius: 8
                    color: "#1A3D2E"
                    implicitHeight: 20
                    implicitWidth: playingRow.width + 16
                    RowLayout {
                        id: playingRow
                        anchors.centerIn: parent
                        spacing: 4
                        Rectangle { width: 6; height: 6; radius: 3; color: Theme.colorGood }
                        Text { text: "играет сейчас"; color: Theme.colorGood; font.pixelSize: 10; font.family: Theme.fontFamily }
                    }
                }
            }

            Item { Layout.fillHeight: true }

            // Waveform реальных амплитуд трека (заполняется, когда подключен плеер)
            Row {
                Layout.fillWidth: true
                height: 20
                spacing: 2
                visible: root.playerAvailable
                Repeater {
                    model: 40
                    delegate: Rectangle {
                        required property int index
                        width: 2
                        radius: 1
                        height: 4 + Math.abs(Math.sin(index * 0.7)) * 16
                        anchors.bottom: parent.bottom
                        color: (index / 40) < root.positionRatio ? Theme.accent : "#2A2C42"
                    }
                }
            }
            Text {
                visible: !root.playerAvailable
                Layout.fillWidth: true
                text: Theme.textNoData
                color: Theme.textMuted
                font.pixelSize: 12
                font.family: Theme.fontFamily
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: Theme.spacingMd

                Text { text: root.positionLabel; color: Theme.textMuted; font.pixelSize: 11; font.family: Theme.fontFamily }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 4
                    radius: 2
                    color: "#26FFFFFF"
                    Rectangle {
                        width: parent.width * root.positionRatio
                        height: parent.height
                        radius: 2
                        color: Theme.accent
                    }
                    Rectangle {
                        width: 10; height: 10; radius: 5
                        color: Theme.accent
                        x: parent.width * root.positionRatio - width / 2
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: (mouse) => root.seekRequested(mouse.x / width)
                    }
                }

                Text { text: root.durationLabel; color: Theme.textMuted; font.pixelSize: 11; font.family: Theme.fontFamily }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: Theme.spacingMd

                PlayerButton {
                    iconGlyph: root.liked ? "favorite" : "favorite_border"
                    onClicked: { root.liked = !root.liked; root.likeToggled(root.liked) }
                }
                Item { Layout.fillWidth: true }
                PlayerButton { iconGlyph: "skip_previous"; onClicked: root.previousClicked() }
                PlayerButton {
                    primary: true
                    iconGlyph: root.isPlaying ? "pause" : "play_arrow"
                    onClicked: { root.isPlaying = !root.isPlaying; root.playPauseClicked() }
                }
                PlayerButton { iconGlyph: "skip_next"; onClicked: root.nextClicked() }
                Item { Layout.fillWidth: true }

                RowLayout {
                    spacing: 6
                    Text { text: Theme.glyph("volume_up"); font.family: Theme.fontFamily; font.pixelSize: 16; color: Theme.textSecondary }
                    Rectangle {
                        Layout.preferredWidth: 70
                        Layout.preferredHeight: 4
                        radius: 2
                        color: "#26FFFFFF"
                        Rectangle {
                            width: parent.width * root.volume
                            height: parent.height
                            radius: 2
                            color: Theme.accent
                        }
                        Rectangle {
                            width: 8; height: 8; radius: 4
                            color: Theme.accent
                            x: parent.width * root.volume - width / 2
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: (mouse) => root.volumeChangeRequested(mouse.x / width)
                        }
                    }
                }
            }
        }
    }
}

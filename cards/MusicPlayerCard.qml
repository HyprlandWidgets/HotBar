import QtQuick
import QtQuick.Layouts
import "../"

Rectangle {

    id: root


    gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop { position: 0.0;  color: "#1A5A7A40" }  
        GradientStop { position: 0.06; color: "#0C3A5A30" }
        GradientStop { position: 0.22; color: "transparent" }
    }
    
    border.width:1
    border.color: Qt.rgba(
        0.45,
        0.62,
        1.0,
        0.14
    )


    radius:Theme.radiusLg



    property bool playerAvailable:false

    property url albumArt:""

    property string trackTitle:
        Theme.textNoData

    property string trackArtist:""


    property bool isPlaying:false

    property bool liked:false


    property real positionRatio:0

    property string positionLabel:"--:--"

    property string durationLabel:"--:--"

    property real volume:0



    signal playPauseClicked()
    signal previousClicked()
    signal nextClicked()

    signal likeToggled(bool liked)

    signal seekRequested(real ratio)

    signal volumeChangeRequested(real volume)




    GridLayout {

        anchors.fill:parent

        anchors.margins:
            Theme.cardPadding


        columns:1

        rows:2


        rowSpacing:
            Theme.spacingMd





        // TOP PLAYER INFO

        RowLayout {


            Layout.fillWidth:true


            spacing:
                Theme.spacingMd



            Rectangle {


                Layout.preferredWidth:
                    Math.min(
                        parent.width * 0.22,
                        90
                    )


                Layout.preferredHeight:
                    width



                Layout.minimumWidth:50

                Layout.minimumHeight:50



                radius:
                    Theme.radiusMd


                clip:true



                gradient: Gradient {


                    GradientStop {
                        position:0
                        color:"#7C6BFC"
                    }


                    GradientStop {
                        position:1
                        color:"#2B2050"
                    }
                }



                Image {

                    anchors.fill:parent

                    source:
                        root.albumArt


                    fillMode:
                        Image.PreserveAspectCrop


                    visible:
                        root.albumArt.toString().length > 0
                }
            }





            ColumnLayout {


                Layout.fillWidth:true


                spacing:Theme.spacingSm



                RowLayout {


                    Layout.fillWidth:true



                    ColumnLayout {


                        Layout.fillWidth:true


                        spacing:2



                        Text {

                            Layout.fillWidth:true


                            text:
                                root.trackTitle


                            elide:
                                Text.ElideRight


                            color:
                                Theme.textPrimary


                            font.pixelSize:15

                            font.bold:true

                            font.family:
                                Theme.fontFamily
                        }



                        Text {

                            Layout.fillWidth:true


                            text:
                                root.trackArtist


                            elide:
                                Text.ElideRight


                            color:
                                Theme.textSecondary


                            font.pixelSize:12

                            font.family:
                                Theme.fontFamily
                        }
                    }



                    Rectangle {


                        visible:
                            root.isPlaying



                        radius:8


                        color:"#1A3D2E"


                        Layout.preferredHeight:20


                        Layout.preferredWidth:
                            playingRow.width + 16



                        RowLayout {


                            id:playingRow


                            anchors.centerIn:parent


                            spacing:4



                            Rectangle {

                                width:6

                                height:6

                                radius:3

                                color:
                                    Theme.colorGood
                            }



                            Text {

                                text:"играет сейчас"


                                color:
                                    Theme.colorGood


                                font.pixelSize:10

                                font.family:
                                    Theme.fontFamily
                            }
                        }
                    }
                }
            }
        }





        ColumnLayout {


            Layout.fillWidth:true

            Layout.fillHeight:true


            spacing:
                Theme.spacingSm





            // WAVEFORM


            Item {


                Layout.fillWidth:true

                Layout.preferredHeight:24



                visible:
                    root.playerAvailable



                Row {


                    anchors.fill:parent


                    spacing:2



                    Repeater {


                        model:40



                        delegate:Rectangle {


                            required property int index



                            width:2


                            radius:1


                            height:
                                4 +
                                Math.abs(
                                    Math.sin(index * 0.7)
                                ) * 16



                            anchors.bottom:
                                parent.bottom



                            color:
                                (index / 40)
                                <
                                root.positionRatio
                                ?
                                Theme.accent
                                :
                                "#2A2C42"
                        }
                    }
                }
            }





            Text {


                visible:
                    !root.playerAvailable



                Layout.fillWidth:true


                text:
                    Theme.textNoData


                color:
                    Theme.textMuted


                font.pixelSize:12

                font.family:
                    Theme.fontFamily
            }






            // PROGRESS


            RowLayout {


                Layout.fillWidth:true


                spacing:
                    Theme.spacingSm



                Text {

                    text:
                        root.positionLabel


                    color:
                        Theme.textMuted


                    font.pixelSize:11

                    font.family:
                        Theme.fontFamily
                }




                Rectangle {


                    Layout.fillWidth:true


                    Layout.preferredHeight:5


                    radius:3


                    color:"#26FFFFFF"



                    Rectangle {

                        width:
                            parent.width *
                            root.positionRatio


                        height:
                            parent.height


                        radius:3


                        color:
                            Theme.accent
                    }



                    MouseArea {


                        anchors.fill:parent


                        onClicked:
                            root.seekRequested(
                                mouse.x / width
                            )
                    }
                }




                Text {


                    text:
                        root.durationLabel


                    color:
                        Theme.textMuted


                    font.pixelSize:11

                    font.family:
                        Theme.fontFamily
                }
            }






            // CONTROLS


            RowLayout {


                Layout.fillWidth:true


                spacing:
                    Theme.spacingSm




                PlayerButton {

                    iconGlyph:
                        root.liked
                        ?
                        "favorite"
                        :
                        "favorite_border"


                    onClicked:{

                        root.liked =
                            !root.liked

                        root.likeToggled(
                            root.liked
                        )
                    }
                }




                Item {
                    Layout.fillWidth:true
                }




                PlayerButton {

                    iconGlyph:"skip_previous"

                    onClicked:
                        root.previousClicked()
                }




                PlayerButton {

                    primary:true


                    iconGlyph:
                        root.isPlaying
                        ?
                        "pause"
                        :
                        "play_arrow"



                    onClicked:{

                        root.isPlaying =
                            !root.isPlaying


                        root.playPauseClicked()
                    }
                }




                PlayerButton {

                    iconGlyph:"skip_next"

                    onClicked:
                        root.nextClicked()
                }




                Item {

                    Layout.fillWidth:true
                }





                RowLayout {


                    spacing:6


                    Text {

                        text:
                            Theme.glyph(
                                "volume_up"
                            )


                        color:
                            Theme.textSecondary


                        font.pixelSize:16

                        font.family:
                            Theme.fontFamily
                    }



                    Rectangle {


                        Layout.preferredWidth:
                            Math.min(
                                parent.width * 0.15,
                                90
                            )


                        Layout.minimumWidth:40


                        Layout.preferredHeight:4


                        radius:2


                        color:"#26FFFFFF"



                        Rectangle {

                            width:
                                parent.width *
                                root.volume


                            height:
                                parent.height


                            radius:2


                            color:
                                Theme.accent
                        }



                        MouseArea {

                            anchors.fill:parent


                            onClicked:
                                root.volumeChangeRequested(
                                    mouse.x / width
                                )
                        }
                    }
                }
            }
        }
    }
}
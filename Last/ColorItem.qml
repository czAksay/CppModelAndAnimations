import QtQuick 2.0

Rectangle {
    id: root
    width: 230
    height: 27
    property int fontSize: normalFontSize
    property int normalFontSize: 14
    property int hoveredFontSize: 18
    property string colorText: "Color name"
    property color currColor: "#ffffff"
    color: "#20808080"

    states: [
        State {
            name: "Normal"
            when: !mouseArea.containsMouse
            PropertyChanges {
                target: root
                fontSize: normalFontSize
                color: "#20808080"
                border.color: "transparent"
            }
            PropertyChanges {
                target: rowWithButtons
                opacity: 0
            }
        },
        State {
            name: "Hovered"
            when: mouseArea.containsMouse
            PropertyChanges {
                target: root
                fontSize: hoveredFontSize
                color: "#90808080"
                border.color: "black"
            }
            PropertyChanges {
                target: rowWithButtons
                opacity: 1
            }
        }
    ]

    Behavior on color {
        id: rootColorAnimation
        ColorAnimation {
            duration: 200
        }
    }

    Behavior on border.color {
        id: toorBorderAnimation
        ColorAnimation {
            duration: 300
        }
    }

    signal removed()
    signal moveDown()
    signal moveUp()
    signal selected()

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            root.selected();
        }
    }

    Text {
        property int maxTextLength: 25
        text: parent.colorText.length > maxTextLength ? parent.colorText.substring(0, maxTextLength) + "..." : parent.colorText   // + " [" + root.state + "]"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: parent.fontSize
        font.family: "Comic Sans MS"

        Behavior on font.pixelSize {
            id: fontAnimation
            NumberAnimation {
                duration: 100
            }
        }
    }

    Row {
        id: rowWithButtons
        property int marg: 6
        layoutDirection: Qt.RightToLeft
        anchors.right: parent.right
        anchors.rightMargin: marg
        anchors.top: parent.top
        anchors.topMargin: marg
        anchors.bottom: parent.bottom
        anchors.bottomMargin: marg
        spacing: marg

        Image {
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            width: height
            source: "img/x.png"

            MouseArea {
                id: clickDel
                anchors.fill: parent

                onClicked: {
                    root.removed();
                }
            }
        }
        Image {
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            width: height
            source: "img/down.png"

            MouseArea {
                id: clickDown
                anchors.fill: parent

                onClicked: {
                    root.moveDown();
                }
            }
        }
        Image {
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            width: height
            source: "img/up.png"

            MouseArea {
                id: clickUp
                anchors.fill: parent
                onClicked: {
                    root.moveUp();
                }
            }
        }

        Behavior on opacity {
            id: opacityAnimation
            NumberAnimation {
                duration: 300
            }
        }
    }
}

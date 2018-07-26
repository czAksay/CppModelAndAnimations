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
                target: imageX
                opacity: 0
            }
            PropertyChanges {
                target: imageDown
                opacity: 0
            }
            PropertyChanges {
                target: imageUp
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
                target: imageX
                opacity: 1
            }
            PropertyChanges {
                target: imageDown
                opacity: 1
            }
            PropertyChanges {
                target: imageUp
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

    Image {
        property int marg: 6
        id: imageX
        x: 92
        width: height
        anchors.top: parent.top
        anchors.topMargin: marg
        anchors.bottom: parent.bottom
        anchors.bottomMargin: marg
        anchors.right: parent.right
        anchors.rightMargin: marg
        source: "img/x.png"

        Behavior on opacity {
            id: xOpacityAnimation
            NumberAnimation {
                duration: 300
            }
        }

        MouseArea {
            id: clickDel
            anchors.fill: parent

            onClicked: {
                root.removed();
            }
        }
    }

    Image {
        property int marg: 6
        id: imageDown
        x: 92
        width: height
        anchors.top: parent.top
        anchors.topMargin: marg
        anchors.bottom: parent.bottom
        anchors.bottomMargin: marg
        anchors.right: imageX.left
        anchors.rightMargin: marg
        source: "img/down.png"

        Behavior on opacity {
            id: xOpacityAnimation2
            NumberAnimation {
                duration: 300
            }
        }

        MouseArea {
            id: clicDown
            anchors.fill: parent

            onClicked: {
                root.moveDown();
            }
        }
    }

    Image {
        property int marg: 6
        id: imageUp
        x: 92
        width: height
        anchors.right: imageDown.left
        anchors.rightMargin: marg
        anchors.top: parent.top
        anchors.topMargin: marg
        anchors.bottom: parent.bottom
        anchors.bottomMargin: marg
        source: "img/up.png"

        Behavior on opacity {
            id: xOpacityAnimation3
            NumberAnimation {
                duration: 300
            }
        }

        MouseArea {
            id: clicUp
            anchors.fill: parent

            onClicked: {
                root.moveUp();
            }
        }
    }
}

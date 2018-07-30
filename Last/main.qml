import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    visible: true
    width: 780
    height: 460
    title: qsTr("Color Picker")
    color: "#BFB7C2"
    minimumHeight: 250
    minimumWidth : 400

    Image {
        id: imgFon
        source: "/img/fon.jpg"
        anchors.fill: parent
    }

    function getColorFromSliders () {
        var newCol = Array
        for (var i = 0; i < sliderRepeat.count; i ++)
        {
            newCol[i] = sliderRepeat.itemAt(i).value / sliderRepeat.colorMaxValue
        }

        return Qt.rgba(newCol[0], newCol[1], newCol[2], newCol[3]);
    }


    Rectangle {
        border.color: "black"
        border.width: 2
        anchors.fill: parent
        anchors.margins: 7
        color: "transparent"
        RowLayout {
            anchors.fill: parent
            anchors.margins: 6
            spacing: 4
            Rectangle {
                id: leftSide
                color: "#AADDDFFF"
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout {
                    anchors.fill: parent
                    GridLayout {
                        id: gridSliderContainer
                        property variant colorTitles: ["Red", "Green", "Blue", "Alpha"]
                        property int marg: 8
                        Layout.margins: marg
                        flow: GridLayout.TopToBottom
                        rows: colorTitles.length

                        Repeater {
                            id: labelRepeat
                            model: gridSliderContainer.colorTitles
                            Item {
                                width: 78
                                height: 24
                                Layout.fillHeight: true
                                Text {
                                    id: text1
                                    anchors.fill:parent
                                    font.pixelSize: 15
                                    font.family: "Times New Roman"
                                    text: modelData + " [" + sliderRepeat.itemAt(index).value + "]"
                                    verticalAlignment: Text.AlignVCenter
                                }
                            }
                        }

                        Repeater {
                            id: sliderRepeat
                            property int colorMaxValue: 255
                            model: gridSliderContainer.colorTitles.length
                            Slider {
                                minimumValue: 0
                                maximumValue: sliderRepeat.colorMaxValue
                                value: {
                                    if (index == 0)
                                        return 128
                                    if (index == 1)
                                        return 166
                                    if (index == 2)
                                        return 196
                                    if (index == 3)
                                        return 255
                                }
                                stepSize: 1
                                Layout.fillWidth:  true

                                Behavior on value {
                                    id: sliderValueAnimation
                                    NumberAnimation {
                                        duration: 250
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: saveColorRoot
                        height: 140
                        Layout.fillWidth: true
                        property int marg: 6
                        Layout.rightMargin: marg
                        Layout.leftMargin: marg
                        Layout.bottomMargin: marg
                        color: "transparent"

                        TextField {
                            id: saveColorName
                            text: ""
                            maximumLength: 30
                            placeholderText: "Enter color name"
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.margins: 4
                            font.family: "Comic Sans MS"
                            font.pixelSize: 14
                        }

                        Button {
                            id: saveColorButton
                            anchors.top: saveColorName.bottom
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.margins: 4
                            anchors.topMargin: 10
                            style: ButtonStyle {
                                label: Text {
                                    font.family: saveColorName.font.family
                                    font.pixelSize: 20
                                    renderType: Text.NativeRendering
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "Save"
                                }
                            }

                            onClicked: {
                                ColorController.add(saveColorName.text.length > 0 ? saveColorName.text : "no name", getColorFromSliders());
                            }
                        }
                    }
                }
            }
            Rectangle {
                id: rightSide
                color: "#AADDDFFF"
                Layout.fillWidth: true
                Layout.fillHeight: true
                height: 200
                GroupBox {
                    id: groupBox
                    title: qsTr("Color Preview")
                    anchors.fill: parent

                    Rectangle {
                        id: canvasRoot
                        height: parent.height * 0.5
                        color: "transparent"
                        anchors.left: parent.left
                        anchors.right: parent.right

                        Canvas {
                            id: canvas
                            anchors.fill: parent
                            property color selectedColor: {
                                getColorFromSliders();
                            }

                            onSelectedColorChanged:  {
                                requestPaint();
                            }

                            onPaint: {
                                var ctx = canvas.getContext("2d");
                                ctx.beginPath();
                                ctx.fillStyle = selectedColor
                                ctx.clearRect(0, 0, canvas.width, canvas.height);
                                ctx.arc(width/2, height/2, width<height?width/2 - 6:height/2 - 6, 0, 2*Math.PI);
                                ctx.fill();
                                ctx.stroke();
                            }

                            Behavior on selectedColor {
                                id: animation
                                ColorAnimation {
                                    duration: 400
                                }
                            }
                        }
                    }

                    Rectangle {
                        id: modelRoot
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.top: canvasRoot.bottom
                        anchors.topMargin: 15
                        color: "transparent"
                        border.color: "black"

                        ListView {
                            id: listView
                            boundsBehavior: Flickable.DragOverBounds
                            anchors.fill: parent
                            model: ColorController.model
                            spacing: 5

                            add: Transition {
                                ParallelAnimation {
                                    NumberAnimation {properties: "opacity"; from: 0; to: 1.0; duration: 280 }
                                    NumberAnimation {properties: "scale"; from: 4.0; to: 1; duration: 280 }
                                }
                            }

                            move: Transition {
                                NumberAnimation { properties: "x,y"; duration: 300}
                                SequentialAnimation {
                                    NumberAnimation { properties: "scale"; from: 1.0; to: 0.75; duration: 150}
                                    NumberAnimation { properties: "scale"; from: 0.75; to: 1.0; duration: 150}
                                }
                            }

                            remove: Transition {
                                NumberAnimation {
                                    property: "scale"
                                    from: 1
                                    to: 0
                                    duration: 300
                                }
                            }

                            delegate: ColorItem {
                                id: colorItem
                                anchors.right: parent.right
                                anchors.left: parent.left
                                colorText: mText
                                currColor: mColor

                                onMoveDown: {
                                    ColorController.move(index, index + 1);
                                }

                                onMoveUp: {
                                    ColorController.move(index, index - 1);
                                }

                                onRemoved:  {
                                    ColorController.remove(index);
                                }

                                onSelected: {
                                    var color = colorItem.currColor;
                                    for (var i = 0; i < sliderRepeat.count; i ++)
                                    {
                                        sliderRepeat.itemAt(i).value = ColorController.getColorChannel(color, i);
                                    }
                                }


                                ListView.onRemove: SequentialAnimation {
                                    PropertyAction { target: colorItem; property: "ListView.delayRemove"; value: true }
                                    ParallelAnimation {
                                        NumberAnimation { target: colorItem;  properties: "opacity"; from: 1.0; to: 0.0; duration: 250 }
                                        NumberAnimation { target: colorItem;  properties: "scale"; from: 1.0; to: 0; duration: 250 }
                                    }
                                    PropertyAction { target: colorItem; property: "ListView.delayRemove"; value: false } // ok, can remove it
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

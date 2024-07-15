import QtQuick 2.0

Item {
    width: parent.width
    height: 250
    Rectangle{
        id : rect1
        width: 350;height: 20;color:"skyblue";radius: 30
        /*anchors.top: ownShipDepthRectId.bottom;anchors.topMargin: comboBox8.anchors.topMargin +comboBox8.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 10
        Text {
            text: qsTr("Select Stand by Missile")
            anchors.centerIn: parent
            font.pixelSize: 10
            font.bold: true

        }
    }
    ///////////////row 1
    Row {
        id : row1
        anchors.top: rect1.bottom;anchors.topMargin: 5 /*rect1.anchors.topMargin +rect1.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 10

        Repeater {
            model: 4
            property int index
            Rectangle {
                width: 120; height: 15 //40
                border.width: 0.5
                border.color: "blue"
                color: "green"
                Text {
                    anchors.centerIn: parent
                    text: (index)*2+1
                    color: "white";font.pixelSize: 10;font.bold: true
                }

            }
        }
    }
    Row{
        id : row2
        anchors.top: rect1.bottom;anchors.topMargin: row1.anchors.topMargin +row1.height
        anchors.left: parent.left;anchors.leftMargin: 10
        Repeater {
            model: 4
            property int index
            CustTextField{ width: 120; height: 40 }
        }

    }
    ///////////////row 2
    Row {
        id : row3
        anchors.top: rect1.bottom;anchors.topMargin: row2.anchors.topMargin +row2.height
        anchors.left: parent.left;anchors.leftMargin: 10
        Repeater {
            model: 4
            property int index
            Rectangle {
                width: 120; height: 15
                border.width: 0.5
                border.color: "blue"
                color: "green"
                Text {
                    anchors.centerIn: parent
                    text: (index)*2+2
                    color: "white";font.pixelSize: 10;font.bold: true
                }

            }
        }
    }
    Row{
        id : row4
        anchors.top: rect1.bottom;anchors.topMargin: row3.anchors.topMargin +row3.height
        anchors.left: parent.left;anchors.leftMargin: 10
        Repeater {
            model: 4
            property int index
            CustTextField{ width: 120; height: 40 }
        }

    }

    ////////////////row 3

    Row {
        id : row5
        anchors.top: rect1.bottom;anchors.topMargin: row4.anchors.topMargin +row4.height
        anchors.left: parent.left;anchors.leftMargin: 10
        Repeater {
            model: 4
            property int index
            Rectangle {
                width: 120; height: 15
                border.width: 0.5
                border.color: "blue"
                color: "green"
                Text {
                    anchors.centerIn: parent
                    text: (index)*2+9
                    color: "white";font.pixelSize: 10;font.bold: true
                }

            }
        }
    }
    Row{
        id : row6
        anchors.top: rect1.bottom;anchors.topMargin: row5.anchors.topMargin +row5.height
        anchors.left: parent.left;anchors.leftMargin: 10
        Repeater {
            model: 4
            property int index
            CustTextField{ width: 120; height: 40 }
        }

    }

    ////////////////row 4
    Row {
        id : row7
        anchors.top: rect1.bottom;anchors.topMargin: row6.anchors.topMargin +row6.height
        anchors.left: parent.left;anchors.leftMargin: 10
        Repeater {
            model: 4
            property int index
            Rectangle {
                width: 120; height: 15
                border.width: 0.5
                border.color: "blue"
                color: "green"
                Text {
                    anchors.centerIn: parent
                    text: (index)*2+10
                    color: "white";font.pixelSize: 10;font.bold: true
                }

            }
        }
    }
    Row{
        id : row8
        anchors.top: rect1.bottom;anchors.topMargin: row7.anchors.topMargin +row7.height
        anchors.left: parent.left;anchors.leftMargin: 10
        Repeater {
            model: 4
            property int index
            CustTextField{ width: 120; height: 40 }
        }

    }
}

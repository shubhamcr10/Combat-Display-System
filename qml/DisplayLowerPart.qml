import QtQuick 2.0

Rectangle{
    width: parent.width
    height: 180
    color: "black"//"white"

    ////////////////////small rects
    Row {
        id : row1
        anchors.left: parent.left;anchors.leftMargin: 1
        anchors.top: parent.top;anchors.topMargin: 5
        Repeater {
            model: 8
            Rectangle {
                width: 60; height: 12
                border.width: 1
                color: "black"
                Text {
                    anchors.centerIn: parent
                    text: (index)+1
                    color: "yellow";font.pixelSize: 10;font.bold: true
                }
            }
        }
    }
    Row {
        id : row2
        anchors.left: parent.left;anchors.leftMargin: 1
        anchors.top: parent.top;anchors.topMargin: row1.anchors.topMargin +row1.height
        Repeater {
            model: 8
            Rectangle {
                width: 60; height: 12
                border.width: 1
                color: "black"
                Text {
                    anchors.centerIn: parent
                    text: (index)+9
                    color: "yellow";font.pixelSize: 10;font.bold: true
                }
            }
        }
    }
    //    ///////////////start pplp
        Rectangle{
            id:startPplpButton1
            width: 180;height: 20;color: "skyblue";radius: 40
            anchors.top: parent.top;anchors.topMargin: row2.anchors.topMargin +row2.height + 5
            anchors.left: parent.left;anchors.leftMargin: 10
            Text {
                anchors.centerIn: parent
                text:"Start PPLP"
                color: "black";font.pixelSize: 10;font.bold: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {

                }
            }
        }

         DisplayTextField{ width: 70; height: 30
            text: "120 s"
            anchors.top: parent.top;anchors.topMargin: row2.anchors.topMargin +row2.height
            anchors.left: parent.left;anchors.leftMargin: 210

//            Text {
//                text: "120 s"
//                font.pixelSize: 10
////                color: "white"
//            }
        }
        Rectangle{
            id:startPplpButton2
            width: 180;height: 20;color: "skyblue";radius: 40
            anchors.top: parent.top;anchors.topMargin: startPplpButton1.anchors.topMargin + startPplpButton1.height + 5
            anchors.left: parent.left;anchors.leftMargin: 10
            Text {
                anchors.centerIn: parent
                text:"Start PPLP"
                color: "black";font.pixelSize: 10;font.bold: true
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {

                }
            }
        }

        DisplayTextField{ width: 70; height: 30
            text: "120 s"
            anchors.top: parent.top;anchors.topMargin: startPplpButton1.anchors.topMargin +startPplpButton1.height
            anchors.left: parent.left;anchors.leftMargin: 210
        }

//    //////////////fire button
    Rectangle{
        id:fireButton
        width: 140;height: 40;color: "green";radius: 5
        anchors.top: parent.top;anchors.topMargin: startPplpButton2.anchors.topMargin +startPplpButton2.height + 5
        anchors.left: parent.left;anchors.leftMargin: 200
        Text {
            anchors.centerIn: parent
            text:"Fire"
            color: "white";font.pixelSize: 10;font.bold: true
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }
    }
//    //////////target cancel button
    Rectangle{
        id:cancelTargetButton
        width: 180;height: 20;color: "red";radius: 40
        anchors.top: parent.top;anchors.topMargin: startPplpButton1.anchors.topMargin +startPplpButton1.height
        anchors.left: parent.left;anchors.leftMargin: 300
        Text {
            anchors.centerIn: parent
            text:"Target Cancel"
            color: "white";font.pixelSize: 10;font.bold: true
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {

            }
        }
    }



//    /////////launch in progres5
    Rectangle{
        anchors.top: parent.top;anchors.topMargin: fireButton.anchors.topMargin +fireButton.height + 5
        anchors.left: parent.left;anchors.leftMargin: 20
        width: 450;height: 40;color: "grey"

        Text {
            color: "green";font.pixelSize: 12;font.bold: true
            anchors.centerIn: parent
            text: qsTr("Launch in progress")
        }
    }
}

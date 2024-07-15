import QtQuick 2.0

Item {
    id: root
    // Container item
        width: parent.width
        height: 120 // Adjust height as needed
    Rectangle {
        id: ownShipCourseRectId
        width: 350
        height: ownShipCourseId.implicitHeight + 16

        anchors.top: parent.top;
        anchors.topMargin: 5
        anchors.left: parent.left;
        anchors.leftMargin: 5

        color: "#1a1c1f"
        //        border.color: "yellowgreen"
        Text {
            //            id: ownShipCourseId
            //            anchors.centerIn: parent
            //            text: "Course (CoG)"
            //            font.pointSize: 16
            //            color: "blue"

            id: ownShipCourseId
            anchors.verticalCenter: parent.verticalCenter
            text: "Course (CoG)"
            font.pointSize: 16
            color: "white"
            x: 10 // Set the left margin here (adjust the value as needed)
        }
    }

    Rectangle {
        id: ownShipCourseValueRectId
        anchors.left: ownShipCourseRectId.right
        anchors.leftMargin: 0
        //        width: ownShipCourseValueId.implicitWidth + 120
        width: 135
        height: ownShipCourseValueId.implicitHeight + 16

        anchors.top: parent.top;
        anchors.topMargin: 5

        color: "#1a1c1f"
        //        border.color: "yellowgreen"
        Text {
            id: ownShipCourseValueId
            anchors.centerIn: parent
            text: OwnShip.course + " Deg"
            font.pointSize: 16
            color: "white"
        }
    }

    //    Rectangle {
    //        id: ownShipCourseUnitId
    //        anchors.left: ownShipCourseValueRectId.right
    //        anchors.leftMargin: 0
    ////        width: ownShipCourseValueId.implicitWidth + 120
    //        width: 35
    //        height: ownShipCourseValueId.implicitHeight + 16

    //        anchors.top: parent.top;
    //        anchors.topMargin: 5

    //        color: "black"
    ////        border.color: "yellowgreen"
    //        Text {
    //            id: ownShipCourseValueUnitId
    //            anchors.centerIn: parent
    //            text: "°"
    //            font.pointSize: 16
    //            color: "white"
    //        }
    //    }

    Rectangle {
        id: ownShipSpeedRectId
        anchors.top: ownShipCourseRectId.bottom
        //        anchors.leftMargin: 0
        //        width: ownShipSpeedId.implicitWidth + 260
        //        height: ownShipSpeedId.implicitHeight + 16

        width: 350
        height: ownShipCourseId.implicitHeight + 16

        anchors.left: parent.left;
        anchors.leftMargin: 5


        //        color: "#292d39"
        color: "#1a1c1f"
        //        border.color: "yellowgreen"
        Text {
            id: ownShipSpeedId
            //            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            text: "Speed (SoG)"
            font.pointSize: 16
            color: "white"
            x:10
        }
    }

    Rectangle {
        id: ownShipSpeedValueRectId
        anchors.left: ownShipSpeedRectId.right
        anchors.top: ownShipCourseRectId.bottom
        anchors.leftMargin: 0
        //        width: ownShipSpeedValueId.implicitWidth + 120
        width: 135
        height: ownShipSpeedValueId.implicitHeight + 16
        //        color: "#292d39"
        color: "#1a1c1f"
        //        border.color: "yellowgreen"
        Text {
            id: ownShipSpeedValueId
            anchors.centerIn: parent
            text: OwnShip.speed + " Kn"
            font.pointSize: 16
            color: "white"
        }
    }

    Rectangle {
        id: ownShipDepthRectId
        anchors.top: ownShipSpeedRectId.bottom
        //        anchors.leftMargin: 0
        //        width: ownShipDepthId.implicitWidth + 332
        height: ownShipDepthId.implicitHeight + 16
        width: 350

        anchors.left: parent.left;
        anchors.leftMargin: 5

        color: "#1a1c1f"
        //        border.color: "yellowgreen"
        Text {
            id: ownShipDepthId
            //            anchors.centerIn: parent
            anchors.verticalCenter: parent.verticalCenter
            text: "Depth"
            font.pointSize: 16
            color: "white"
            x:10
        }
    }
    Rectangle {
        id: ownShipDepthValueRectId
        anchors.left: ownShipDepthRectId.right
        anchors.top: ownShipSpeedRectId.bottom
        anchors.leftMargin: 0
        //        width: ownShipDepthValueId.implicitWidth + 120
        width: 135
        height: ownShipDepthValueId.implicitHeight + 16
        color: "#1a1c1f"
        //        border.color: "yellowgreen"
        Text {
            id: ownShipDepthValueId
            anchors.centerIn: parent
            text: OwnShip.depth + " M"
            font.pointSize: 16
            color: "white"
        }
    }
}

import QtQuick 2.0
import QtQuick.Controls 2.14

Item {
    id: hookedTrackInfo
    width: parent.width
    height: 115
    property int textLeftMargin: 20
    property int rowNum: 6
    property int columnNum: 2

    Rectangle{
        id:hookedHeader
        width: parent.width
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        Text {
            id: hookedHeaderText
            text: "Hooked Track Info"
            color: "white"
            anchors.centerIn: parent
            visible: true
        }
    }
// --------------------------- Track ID -----------------
    Rectangle {
        id:idRect
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: hookedHeader.bottom
        anchors.left: parent.left
        Text {
            id: idRectText
            text: "Track ID:"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    Rectangle {
        id:idRectValue
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: hookedHeader.bottom
        anchors.left: idRect.right
        Text {
            id: idRectTextValue
            text: ""
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }
// --------------------------- Sensor ID -----------------
    Rectangle {
        id:sensorIdRect
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: idRect.bottom
        anchors.left: parent.left
        Text {
            id: sensorIdText
            text: "Sensor ID:"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    Rectangle {
        id:sensorIdRectValue
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: idRectValue.bottom
        anchors.left: idRect.right
        Text {
            id: sensorIdRectTextValue
            text: ""
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    // --------------------------- Range -----------------

    Rectangle {
        id:rangeRect
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: sensorIdRect.bottom
        anchors.left: parent.left
        //        margin: 5

        Text {
            id: rangeRectText
            text: "Range:"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    Rectangle {
        id:rangeRectValue
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: sensorIdRectValue.bottom
        anchors.left: rangeRect.right
        Text {
            id: rangeRectTextValue
            text: "00 NM"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    // --------------------------- Bearing -----------------

    Rectangle {
        id:bearingRect
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: rangeRect.bottom
        anchors.left: parent.left
        //        margin: 5
        Text {
            id: bearingRectText
            text: "Bearing:"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    Rectangle {
        id:bearingRectValue
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: rangeRectValue.bottom
        anchors.left: bearingRect.right
        Text {
            id: bearingRectTextValue
            text: "00 deg"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    // --------------------------- Speed -----------------

    Rectangle {
        id:speedRect
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: bearingRect.bottom
        anchors.left: parent.left
        Text {
            id: speedRectText
            text: "Speed:"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    Rectangle {
        id:speedRectValue
        width: parent.width/columnNum
        height: parent.height/rowNum
        color: "black"
        border.color: "white"
        anchors.top: bearingRectValue.bottom
        anchors.left: speedRect.right
        Text {
            id: speedRectTextValue
            text: "00 Kn"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: textLeftMargin
            visible: true
        }
    }

    function trackHooked(id, sensorId, range, bearing, speed) {
        idRectTextValue.text = id;
        sensorIdRectTextValue.text = sensorId;
        rangeRectTextValue.text = range + " NM";
        bearingRectTextValue.text = bearing + " Deg";
        speedRectTextValue.text = speed + " Kn";
    }
}

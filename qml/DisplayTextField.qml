//import QtQuick 2.0
import QtQuick 2.1
import QtQuick.Controls 2.1

TextField {
    width: parent.width
    height: parent.height

    Text {
    color: "green"
    font.family: "Arial";
    font.pointSize:  12
     }

    background: Rectangle {
        color: "black"
        border.width: 0.5
//        border.color: "blue"
    }
    padding: 5
    cursorDelegate: Rectangle {
        width: 1
        color: "black"
    }
}





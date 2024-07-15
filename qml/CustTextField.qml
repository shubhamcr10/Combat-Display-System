import QtQuick 2.1
import QtQuick.Controls 2.1

Item {
    width: 200

     Rectangle {
            width: parent.width
            height: parent.height

             color: "black"
             border.width: 0.5
             border.color: "blue"

             Text {
            anchors.fill:parent
             text:"     A                    T\n         Hatch \n          Gannister"
            color: "green"
            font.family: "Arial";
            font.pointSize:  9
             }
         }

}




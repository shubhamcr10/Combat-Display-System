import QtQuick 2.0

Item {
    width: parent.width
    height: 35
    Combobox{
        id:comboBox6
        model: ["Probability of Kill"]
        /*anchors.top: ownShipDepthRectId.bottom;anchors.topMargin: comboBox5.anchors.topMargin +comboBox5.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 5
    }
}

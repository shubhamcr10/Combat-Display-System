import QtQuick 2.0

Item {
    width: parent.width
    height: 35
    Combobox{
        id:comboBox7
        model: ["Trajectory Computation"]
        /*anchors.top: ownShipDepthRectId.bottom;anchors.topMargin: comboBox6.anchors.topMargin +comboBox6.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 5
    }
}

import QtQuick 2.0

Item {
    width: parent.width
    height: 35
    Combobox{
        id:comboBox8
        model: ["Combat"]
        /*anchors.top: ownShipDepthRectId.bottom;anchors.topMargin: comboBox7.anchors.topMargin +comboBox7.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 5
    }
}

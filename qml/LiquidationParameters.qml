import QtQuick 2.0

Item {
    width: parent.width
    height: 35
    Combobox{
        id:comboBox5
        model: ["Liquidation Parameters"]
        /*anchors.top: ownShipDepthRectId.bottom;anchors.topMargin: comboBox4.anchors.topMargin +comboBox4.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 5
    }
}

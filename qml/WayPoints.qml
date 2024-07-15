import QtQuick 2.0

Item {
    width: parent.width
    height: 35
    Combobox{
        id:comboBox3
        model: ["Way Points"]
        /*anchors.top: ownShipDepthRectId.bottom;anchors.topMargin:comboBox2.anchors.topMargin + comboBox2.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 5
    }
}

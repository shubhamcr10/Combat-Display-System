import QtQuick 2.0

Item {
    width: parent.width
    height: 35
    Combobox{
        id:comboBox2
        model: ["SSM Target Data"]
        /*anchors.top: ownShipDepthRectId.bottom;anchors.topMargin: comboBox1.anchors.topMargin +comboBox1.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 5
    }
}

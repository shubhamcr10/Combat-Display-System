import QtQuick 2.0

Item {
    width: parent.width
    height: 35

    Combobox{
        id:comboBox4
        model: ["Weapon Danger Zone"]
        /*anchors.top: ownShipDepthRectId.bottom;anchors.topMargin:comboBox3.anchors.topMargin + comboBox3.height+3*/
        anchors.left: parent.left;anchors.leftMargin: 5
    }
}

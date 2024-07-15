import QtQuick 2.0

Item {
    width: parent.width
    height: 35

    Combobox{
        id:comboBox1
        model: trackModel
        displayText: "Track Table"
        textRole: "trackId"
         currentIndex: 0 // Select the first index
//        anchors.top: courseSpeedDepthLoader.bottom;
        anchors.topMargin: 5
        anchors.left: parent.left;
        anchors.leftMargin: 5
    }
}

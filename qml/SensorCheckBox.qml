import QtQuick 2.14
import QtQuick.Controls 2.14

Rectangle {
    id: sensorCheckBox
    width: parent.width
    height: 50
    color: "transparent"

    signal checkBoxSelected(string checkBoxId, bool checked) // Define a signal

    Row {
        spacing: 5

        // Spacer item with desired width
        Rectangle {
            width: 5
            height: parent.height
            color: "transparent" // Make the spacer transparent
        }

        //        anchors.centerIn: parent
        CheckBox {
            id: radar1Checkbox
            text: "Radar 1"

            checked: false // Initial state
          //   textColor: "white" // Text color
            onCheckedChanged: {
                sensorCheckBox.checkBoxSelected("radar1", radar1Checkbox.checked)
                reloadTracks();
            }
            background: Rectangle {
                implicitWidth: 18
                implicitHeight: 18
                color: root.checked ? activeFocus ? "#007bff" : "#6c757d" : "#6c757d"
                border.color: "#ED0707"
                radius: 2
            }
        }

        CheckBox {
            id: sonar1Checkbox
            text: "Sonar 1"
            checked: false // Initial state
            //        textColor: "white" // Text color
            onCheckedChanged: {
                sensorCheckBox.checkBoxSelected("sonar1", sonar1Checkbox.checked)
                reloadTracks();
            }
            background: Rectangle {
                implicitWidth: 18
                implicitHeight: 18
                color: root.checked ? activeFocus ? "#007bff" : "#6c757d" : "#6c757d"
                border.color:"#FCE131"
                radius: 2
            }
        }

        CheckBox {
            id: sonar2Checkbox
            text: "Sonar 2"
            checked: false // Initial state
            //        textColor: "white" // Text color
            onCheckedChanged: {
                sensorCheckBox.checkBoxSelected("sonar2", sonar2Checkbox.checked)
                reloadTracks();
            }
            background: Rectangle {
                implicitWidth: 18
                implicitHeight: 18
                color: root.checked ? activeFocus ? "#007bff" : "#6c757d" : "#6c757d"
                border.color: "#1FFF0F"
                radius: 2
            }
//            MouseArea{
//                anchors.fill: parent
//                hoverEnabled: true

//                onEntered: {
//                    greentriangle.source="qrc:/yellowleftarrow.svg"
//                }

//                onExited: {
//                    greentriangle.source="qrc:/leftarrow.svg"
//                }
//        }
//            Image {
//                id:greentriangle
//                source: "qrc:/S002.svg"
//            }
    }
    Component.onCompleted: {
        radar1Checkbox.checked = true; // Set initial state
        sonar1Checkbox.checked = true; // Set initial state
        sonar2Checkbox.checked = true; // Set initial state
    }
}
}


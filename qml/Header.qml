import QtQuick 2.0
import QtQuick.Controls 2.0
Item {
    width: parent.width
    height: 35
    property int defaultrange: 120
    signal rangeRularChanged(int newValue)

    Rectangle {
        width: parent.width
        height: parent.height
        color: "#1a1c1f"


        Rectangle{
            id:rangescale
            width: 140
            height: parent.height
            x:parent.width-700
            y:0
            color: "transparent"


            Rectangle{
                id:leftbutton
                width: 35
                height:parent.height

                color:"transparent"
               MouseArea{
                   anchors.fill: parent
                   hoverEnabled: true

                   onEntered: {
                       lefticonimage.source="qrc:/leftarrow.svg"
                   }

                   onExited: {
                       lefticonimage.source="qrc:/blueleftarrow.svg"
                   }
                   onClicked: {
                       if(defaultrange>30){
                          defaultrange=defaultrange/2
                               onrangeRularChanged: rangeRularChanged(defaultrange)
                       }

                }

               }
                Image{
                    id:lefticonimage
                    anchors.fill: parent
                    source: "qrc:/blueleftarrow.svg"
                    fillMode: Image.Stretch
                }
            }
            Rectangle{
                 id:rangelabel
                 anchors.centerIn: parent
                 anchors.left: leftbutton.right
                  width:70
                  height:parent.height
                  border.color: "#87CEEB"
                  border.width: 1
                  color: "transparent"
            Label{
                color: "white"
                text: defaultrange*4 + " Nm"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.centerIn: parent
                }
            }

            Rectangle{
                id:rightbutton
                width: 35
                height:parent.height

                color:"transparent"
                anchors.left: rangelabel.right
                MouseArea{
                   anchors.fill: parent
                   hoverEnabled: true

                   onEntered: {
                       righticonimage.source="qrc:/rightarrow.svg"
                   }

                   onExited: {
                       righticonimage.source="qrc:/bluerightarrow.svg"
                   }

                   onClicked: {
                       if(defaultrange<=480){
                    defaultrange=defaultrange*2
                       onrangeRularChanged: rangeRularChanged(defaultrange)
                       }
                }

               }
                Image{
                    id:righticonimage
                    anchors.fill: parent
                    source: "qrc:/bluerightarrow.svg"
                    fillMode: Image.Stretch
                }
            }


        }
    }
}

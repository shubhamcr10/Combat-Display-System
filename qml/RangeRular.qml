import QtQuick 2.12
import QtQuick.Controls 2.14

Item {
    width: 80
    height: parent.height/3;

    property int counter:1
    property int range: 120
    property bool increaseFlag: false
    property int majorStep:0
    property int minorStep:0
    // Define a signal that will be emitted when rangeScale changes
    signal rangeRularChanged(int newValue, int count)

    Rectangle {
        id:rularBoarder
//        width: 50
//        height: parent.height - 40;
        width: parent.width
        height: parent.height
        border.color: "green"
//        color: "green"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 20
        anchors.rightMargin: 20

        Canvas {
            id: rulerCanvas
//                        width: rulerArea.width + 20
//                        height: 1;
            anchors.fill: parent
//            anchors.left: rularBoarder.left

            onPaint: {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, rulerCanvas.width, rulerCanvas.height);

//                var stepSize = 50; // Pixel size of each step (assumed to be 1 inch)
//                var totalSteps = Math.floor((rularBoarder.height - 10) / stepSize); // Calculate the number of steps based on the height
//                var startY = 10; // Starting Y position for the ruler lines
                console.log("rularBoarder.height: ", rularBoarder.height);
                var stepSize = rularBoarder.height/8; // Pixel size of each step (assumed to be 1 inch)
                majorStep = stepSize;
                var totalSteps = 8; // Calculate the number of steps based on the height
                var startY = 10; // Starting Y position for the ruler lines

                ctx.strokeStyle = "black";
                ctx.lineWidth = 1;
                console.log("stepSize: ", stepSize)
                var cc = Math.floor(totalSteps/2);
                for (var i = 0; i <= totalSteps; i++) {
//                    var y = startY + i * 100;

                    var y = i * stepSize;

                    ctx.beginPath();
                    ctx.moveTo(30, y);
                    ctx.lineTo(rulerCanvas.width-10, y);
                    ctx.stroke();


                    // Add text left of rular scale
                    if(i !== 0 && i !== totalSteps) {
                        if(cc === 1){
                            increaseFlag = true;
                        }
                        if(increaseFlag){
                            var lab = 120/cc;
                            cc++;
                        } else {
                           lab = 120*cc;
                            cc--;
                        }

                        ctx.font = "12px Arial, serif"; // Set font size and type
                        ctx.fillStyle = "black"; // Set text color
                        ctx.textAlign = "left"; // Align text horizontally to the center
                        ctx.fillText(lab.toString(), 5, y+5); // Draw the text
                    }

                    // Sub Scale
                    var subStepSize = stepSize/10;
                    minorStep = 10;
                    console.log("subStepSize: ", subStepSize)
                    for (var j = 1; j <= minorStep; j++) {
                        var subY =  y + j * subStepSize; // minus 1 for equally partition
                        console.log("subY: ", subY)
                        ctx.beginPath();
                        ctx.moveTo(35, subY);
                        ctx.lineTo(rulerCanvas.width -15, subY);
                        ctx.stroke();
                    }
                }
            }
        }

        Rectangle {
            id:rular
            width: 10
            height: parent.height;
//            border.color: "blue"
            color: "black"
//            anchors.centerIn: parent
            anchors.right: parent.right
//            anchors.top: parent.top
//            anchors.right: parent.right
//            anchors.topMargin: 20
            anchors.rightMargin: 25
        }

        Rectangle {
            id: movableButton
            property int offsetX: 0
            property int offsetY: 0

            property int minX: 0
            property int minY: 0

            property int maxX: 0
            property int maxY: 0

            property int prevY: rularBoarder.height-10;


//            text: "mv"
            color: "green"
            width: rularBoarder.width/3
            height: 8

//            x:rularBoarder.width/2-width/2
            x:37
            y:rularBoarder.height/2 - height/2

            //        anchors.centerIn: parent
//            anchors.bottom: rularBoarder.bottom
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onPressed: {
                    movableButton.z = 1 // Move the button to the top
                    movableButton.minX = 0
                    movableButton.minY = 0
                    movableButton.maxX = rularBoarder.width - movableButton.width
                    movableButton.maxY = rularBoarder.height - 10

//                    movableButton.minX = -movableButton.width/2
//                    movableButton.minY = -movableButton.height/2
//                    movableButton.maxX = rularBoarder.width - movableButton.width/2
//                    movableButton.maxY = rularBoarder.height - movableButton.height/2
                }
                onPositionChanged: {
                    //                if (mouseArea.containsMouse) {
                    console.log("mouseX: ", mouseX, "mouseY: ", mouseY)
                    movableButton.offsetX = mouseX + movableButton.x - movableButton.width/2
                    movableButton.offsetY = mouseY + movableButton.y - movableButton.height/2
                    console.log("mouseX: ", mouseX, "mouseY: ", mouseY)
                    console.log("movableButton.offsetX: ", movableButton.offsetX, "movableButton.offsetY: ", movableButton.offsetY)

                    if(movableButton.offsetY < movableButton.maxY && movableButton.offsetY > movableButton.minY) {
//                        movableButton.x = movableButton.offsetX
                        movableButton.y = movableButton.offsetY

//                        range_scale =  range_scale * (movableButton.prevY - movableButton.y)

                        var cursorInitialPos = rularBoarder.height/2 - height/2;
                        var step = cursorInitialPos - movableButton.y;

                        if(step > majorStep){
//                            counter = counter - step
                            counter = Math.floor(step/majorStep);
                            if(counter > 0){
                                range = 120
                                range_scale = range* (counter + 1)
                                // Whenever rangeScale updates, emit the signal
                                onRangeRularChanged: rangeRularChanged(range_scale, counter)
                            }
                        } else {
                            counter = Math.floor(step/majorStep);
                            if(counter < 0){
                                range = 120
                                range_scale = Math.floor(range/(0-counter))
                                // Whenever rangeScale updates, emit the signal
                                onRangeRularChanged: rangeRularChanged(range_scale, counter)
                            }
                        }
                    }
                    //                }
                }
                onReleased: {
                    movableButton.z = 0 // Restore the button's stacking order
                }
            }
        }
    }
}

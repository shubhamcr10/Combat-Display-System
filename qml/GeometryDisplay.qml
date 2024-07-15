import QtQuick 2.0

Item {
    id: geometryDisplay
    width: parent.width
    height: parent.height
    Canvas {
        id: geometryCanvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.strokeStyle = "white";
            ctx.lineWidth = 1;

            // Draw radar grid circles
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(centerX, centerY) - 20; // Adjust -10 as needed

            for (var i = 1; i <= 4; i++) {
                ctx.beginPath();
                ctx.arc(centerX, centerY, radius * i / 4, 0, Math.PI * 2);
                ctx.stroke();

                // Add range scale on the circle
                ctx.font = "12px Arial, serif"; // Set font size and type
                ctx.fillStyle = "white"; // Set text color
                ctx.textAlign = "center"; // Align text horizontally to the center
                var range = radius* i / 4;
//                ctx.fillText(range.toFixed(2), centerX + range + 20, centerY); // Draw the text
//                ctx.fillText(range.toFixed(2), centerX - range - 20, centerY); // Draw the text
                var scaledRange = range_scale * i
                if(i == 4){
                    ctx.fillText(scaledRange.toFixed(2)+" Nm", centerX + range + 20, centerY); // Draw the text
                    ctx.fillText(scaledRange.toFixed(2)+" Nm", centerX - range - 20, centerY); // Draw the text
                }
                else{
                ctx.fillText(scaledRange.toFixed(2), centerX + range + 20, centerY); // Draw the text
                ctx.fillText(scaledRange.toFixed(2), centerX - range - 20, centerY); // Draw the text
                }

            }

            // Draw degree scale on the second last circle
            var degreeScaleRadius = 10 + radius * 3.5 / 4;
            var angleStep = 10; // Adjust the angle step as needed
            var degreeTextRadius = degreeScaleRadius + 15; // Adjust the radius for degree text

            for (var angle = 0; angle < 360; angle += angleStep) {
                var radian = angle * Math.PI / 180;
                var startX = centerX + degreeScaleRadius * Math.cos(radian);
                var startY = centerY + degreeScaleRadius * Math.sin(radian); // Adjusted for positive y-axis
                var endX = centerX + radius * 3.5 / 4 * Math.cos(radian);
                var endY = centerY + radius * 3.5 / 4 * Math.sin(radian); // Adjusted for positive y-axis

                ctx.beginPath();
                ctx.moveTo(startX, startY);
                ctx.lineTo(endX, endY);
                ctx.stroke();

                // Draw degree labels
                ctx.font = "12px Arial, serif";
                ctx.fillStyle = "white";
                ctx.textAlign = "center";
                ctx.textBaseline = "middle";

                // Invert angle to display from top to bottom
                var subRadian =( angle - 90) * Math.PI / 180;
                ctx.fillText((angle).toFixed(0), centerX + degreeTextRadius * Math.cos(subRadian) * 1, centerY + degreeTextRadius * Math.sin(subRadian));

                for(var j = 0; j<10; j++)
                {
                    ++radian;
                    startX = centerX + (degreeScaleRadius - 5 )* Math.cos(radian);
                    startY = centerY + (degreeScaleRadius - 5 )* Math.sin(radian); // Adjusted for positive y-axis
                    endX = centerX + radius * 3.5 / 4 * Math.cos(radian);
                    endY = centerY + radius * 3.5 / 4 * Math.sin(radian); // Adjusted for positive y-axis
                    ctx.beginPath();
                    ctx.moveTo(startX, startY);
                    ctx.lineTo(endX, endY);
                    ctx.stroke();
                }
            }
        }
    }

    function reloadGeometry() {
        var ctx = geometryCanvas.getContext("2d");
        ctx.clearRect(0, 0, geometryCanvas.width, geometryCanvas.height); // Clear the canvas
        geometryCanvas.requestPaint();
    }
}

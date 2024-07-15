import QtQuick 2.0

Item {
    width: parent.width
    height: parent.height

    Component.onCompleted: {
        console.log("OwnShip width:", range_scale_width);
        console.log("OwnShip height:", range_scale_height);
    }

    Canvas {
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");

            // Set circle fill color
            ctx.fillStyle = "darkgreen";

            ownShipPixelLat = width / 2;
            ownShipPixelLong = height / 2;

            // Draw circle
            var centerX = ownShipPixelLat;
            var centerY = ownShipPixelLong;

            var k = Math.min(width, height) / 3;

            ctx.strokeStyle = "white";
            ctx.beginPath();
            ctx.arc(centerX, centerY, 20, 0, Math.PI * 2);
            ctx.stroke();
            ctx.fill();

            // Draw plus sign
            var halfWidth = 20;
            var halfHeight = 20;

            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.moveTo(centerX - halfWidth, centerY);
            ctx.lineTo(centerX + halfWidth, centerY);
            ctx.stroke();

            ctx.beginPath();
            ctx.moveTo(centerX, centerY - halfHeight);
            ctx.lineTo(centerX, centerY + halfHeight);
            ctx.stroke();

            // Add text below the circle
            ctx.font = "12px Arial, serif"; // Set font size and type
            ctx.fillStyle = "white"; // Set text color
            ctx.textAlign = "center"; // Align text horizontally to the center
            ctx.fillText("OwnShip", centerX, centerY + 30); // Draw the text
        }
    }
}

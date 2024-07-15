import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.0

Window {
    id:root
    visible: true
    //    width: 2560
    //    height: 1440

    width: 1920
    height: 1080
    flags: Qt.FramelessWindowHint
    title: qsTr("Combat Display")

    property int border_thickness: 1
    property int range_scale: 120
    property int pixelOffset: 1
    property int range_scale_width: 0
    property int range_scale_height: 0
    property real ownShipPixelLat: 0.0
    property real ownShipPixelLong: 0.0

    property bool radar1Flag: true
    property bool sonar1Flag: true
    property bool sonar2Flag: true

    property bool isTrackModelUpdating: true

    property string hookedTrack: ""

    function worldToPixel(lat, lng) {

        if(range_scale <= 120){
            var resultX = ownShipPixelLat + lat*(120/range_scale);
            var resultY = ownShipPixelLong - lng*(120/range_scale);
        }
        if(range_scale >= 120){
            resultX = ownShipPixelLat + lat/(range_scale/120);
            resultY = ownShipPixelLong - lng/(range_scale/120);
        }
        return {resultX:resultX, resultY:resultY};
    }

    function reloadTracks(){
        isTrackModelUpdating = false
        var trackCount = Tracks.getTracksList().length;

        for (var i = 0; i < trackCount; ++i) {
            var track = Tracks.getTracksList()[i];
            if(track.range <= 4*range_scale){

                var pixLatLong = worldToPixel(track.latitude, track.longitude);

                var index = findIndexFromListModel(trackListModel, track.trackId);
                if(index >= 0){
                    if(track.sensorID === "R001"){
                        trackListModel.set(index, {"latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": track.range, "bearing": track.bearing, "sensorID": track.sensorID, "speed": track.speed.toFixed(0), "sensorFlag":radar1Flag, "trackIcon":"qrc:/R001.svg"})
                    }
                    if(track.sensorID === "S001"){
                        trackListModel.set(index, {"latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": track.range, "bearing": track.bearing, "sensorID": track.sensorID, "speed": track.speed.toFixed(0), "sensorFlag":sonar1Flag, "trackIcon":"qrc:/S001.svg"})
                    }
                    if(track.sensorID === "S002"){
                        trackListModel.set(index, {"latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": track.range, "bearing": track.bearing, "sensorID": track.sensorID, "speed": track.speed.toFixed(0), "sensorFlag":sonar2Flag, "trackIcon":"qrc:/S002.svg"})
                    }
                }
                else {
                    if(track.sensorID === "R001"){
                        trackListModel.append({ "trackId": track.trackId, "latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": track.range, "bearing": track.bearing, "sensorID": track.sensorID, "speed": track.speed.toFixed(0), "sensorFlag":radar1Flag, "hookFlag":false, "trackIcon":"qrc:/R001.svg"})
                    }
                    if(track.sensorID === "S001"){
                        trackListModel.append({ "trackId": track.trackId, "latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": track.range, "bearing": track.bearing, "sensorID": track.sensorID, "speed": track.speed.toFixed(0), "sensorFlag":sonar1Flag, "hookFlag":false, "trackIcon":"qrc:/S001.svg"})
                    }
                    if(track.sensorID === "S002"){
                        trackListModel.append({ "trackId": track.trackId, "latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": track.range, "bearing": track.bearing, "sensorID": track.sensorID, "speed": track.speed.toFixed(0), "sensorFlag":sonar2Flag, "hookFlag":false, "trackIcon":"qrc:/S002.svg"})
                    }
                }
                if(!isExistInTrackList(trackModel, track.trackId)) {
                    addTrackToTrackList(track.trackId);
                }
            }
            else {
                removeItemByTrackId(trackListModel, track.trackId);
                removeItemByTrackId(trackModel, track.trackId);
                if(hookedTrack === track.trackId){
                    hookedTrack = "";
                    hookedTrackInfo.trackHooked("", "", "", "","");
                }
            }
        }
        isTrackModelUpdating = true;
    }

    function addTrackToTrackList(trackId){

        trackModel.append({"trackId": trackId})

        var trackIds = [];
        // Copy track IDs from ListModel to temporary array
        for (var k = 0; k < trackModel.count; ++k) {
            var track1 = trackModel.get(k).trackId;
            trackIds.push(track1);
        }

        // Sorting the trackIds array based on the string after first character
        trackIds.sort(function(a, b) {
            var trackIDA = parseInt(a.substring(1));
            var trackIDB = parseInt(b.substring(1));
            return trackIDA - trackIDB;
        });

        // Add sorted track IDs back to the ListModel
        for (var j = 0; j < trackIds.length; j++) {
            if(trackModel.get(j).trackId !== trackIds[j])
             {
                trackModel.set(j, { "trackId": trackIds[j] });
             }
        }

    }

    function isTrackIDExist(trackID) {
        for (var i = 0; i < trackModel.count; ++i) {
            if (trackModel.get(i).trackID === trackID) {
                return true; // TrackID found
            }
        }
        return false; // TrackID not found
    }

    // Define a function to handle range scale changes
    function handleRangeScaleChange(newValue) {
        range_scale = newValue;
        geometryDisplay.reloadGeometry();
        pixelOffset = range_scale/120;
        reloadTracks();
    }

    //Apply Hook
    function applyHook(track_id){
        for (var i = 0; i < trackListModel.count; ++i) {
            if (trackListModel.get(i).trackId === track_id) {
                if(trackListModel.get(i).hookFlag){
                    trackListModel.set(i, {"hookFlag":false});
                    hookedTrack = "";
                    hookedTrackInfo.trackHooked("", "", "", "","");
                    return;
                }
                else {
                    var index = findIndexFromListModel(trackListModel,hookedTrack);
                    if(index >=0){
                        trackListModel.set(index, {"hookFlag":false});
                    }

                    trackListModel.set(i, {"hookFlag":true});
                    hookedTrack = track_id;
                    hookedTrackInfo.trackHooked(trackListModel.get(i).trackId, trackListModel.get(i).sensorID, trackListModel.get(i).range, trackListModel.get(i).bearing, trackListModel.get(i).speed);
                    return;
                }
            }
        }
    }

    // Find the index of the item with the specified trackId
    function isExistInTrackList(listModel, trackId) {
        for (var i = 0; i < listModel.count; ++i) {
            if (listModel.get(i).trackId === trackId) {
                return true;
            }
        }
        return false; // Return -1 if the item is not found
    }

    // Find the index from the list model if match with trackId
    function findIndexFromListModel(listModel,trackId) {
        for (var i = 0; i < listModel.count; ++i) {
            if (listModel.get(i).trackId === trackId) {
                return i;
            }
        }
        return -1; // Return -1 if the item is not found
    }

    // Add element
    function addTrackToModel(trackMap) {
        if(isTrackModelUpdating){
            for (var i = 0; i < trackListModel.count; ++i) {
                if (trackListModel.get(i).trackId === trackMap.trackId) {

                    if(trackMap.range <= 4*range_scale){
                        var pixLatLong = worldToPixel(trackMap.latitude, trackMap.longitude);
                        //                trackListModel.insert(i,{ "trackId": trackMap.trackId, "latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": trackMap.range, "bearing": trackMap.bearing, "sensorID": trackMap.sensorID, "speed": trackMap.speed.toFixed(0)})

                        if(trackMap.sensorID === "R001"){
                            trackListModel.set(i, {"latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": trackMap.range, "bearing": trackMap.bearing, "sensorID": trackMap.sensorID, "speed": trackMap.speed.toFixed(0), "sensorFlag":radar1Flag, "trackIcon":"qrc:/R001.svg"})
                        }
                        if(trackMap.sensorID === "S001"){
                            trackListModel.set(i, {"latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": trackMap.range, "bearing": trackMap.bearing, "sensorID": trackMap.sensorID, "speed": trackMap.speed.toFixed(0), "sensorFlag":sonar1Flag, "trackIcon":"qrc:/S001.svg"})
                        }
                        if(trackMap.sensorID === "S002"){
                            trackListModel.set(i, {"latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": trackMap.range, "bearing": trackMap.bearing, "sensorID": trackMap.sensorID, "speed": trackMap.speed.toFixed(0), "sensorFlag":sonar2Flag, "trackIcon":"qrc:/S002.svg"})
                        }

                        if(hookedTrack === trackMap.trackId){
                            hookedTrackInfo.trackHooked(trackMap.trackId, trackMap.sensorID, trackMap.range, trackMap.bearing, trackMap.speed)
                        }
                    } else {
                        if(hookedTrack === trackMap.trackId) {
                            hookedTrackInfo.trackHooked("", "", "", "","")
                        }
                        removeItemByTrackId(trackListModel, trackMap.trackId);
                        removeItemByTrackId(trackModel, trackMap.trackId);
                    }
                    return
                }
            }

            pixLatLong = worldToPixel(trackMap.latitude, trackMap.longitude);

            if(trackMap.range <= 4*range_scale){
                if(trackMap.sensorID === "R001"){
                    trackListModel.append({ "trackId": trackMap.trackId, "latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": trackMap.range, "bearing": trackMap.bearing, "sensorID": trackMap.sensorID, "speed": trackMap.speed.toFixed(0), "sensorFlag":radar1Flag, "hookFlag":false, "trackIcon":"qrc:/R001.svg"})
                }
                if(trackMap.sensorID === "S001"){
                    trackListModel.append({ "trackId": trackMap.trackId, "latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": trackMap.range, "bearing": trackMap.bearing, "sensorID": trackMap.sensorID, "speed": trackMap.speed.toFixed(0), "sensorFlag":sonar1Flag, "hookFlag":false, "trackIcon":"qrc:/S001.svg"})
                }
                if(trackMap.sensorID === "S002"){
                    trackListModel.append({ "trackId": trackMap.trackId, "latitude": pixLatLong.resultX, "longitude": pixLatLong.resultY, "range": trackMap.range, "bearing": trackMap.bearing, "sensorID": trackMap.sensorID, "speed": trackMap.speed.toFixed(0), "sensorFlag":sonar2Flag, "hookFlag":false, "trackIcon":"qrc:/S002.svg"})
                }
                if(!isExistInTrackList(trackModel, trackMap.trackId)) {
                    addTrackToTrackList(trackMap.trackId);
                }
            }
            else {
                removeItemByTrackId(trackListModel, trackMap.trackId);
                removeItemByTrackId(trackModel, trackMap.trackId);
            }
        }
    }

    // Remove an item from the model by its trackId
    function removeItemByTrackId(listModel, trackId) {
        var index = findIndexFromListModel(listModel,trackId);

        if (index !== -1) {
            listModel.remove(index);
        }
    }

    Rectangle {
        width: Window.width
        height: Window.height
        border.color: "gray"
        border.width: border_thickness
        color: "transparent"

        Rectangle {
            width: parent.width - border_thickness
            height: parent.height - border_thickness
            anchors.centerIn: parent
            color: "white"

            Header {
                id: header
                anchors.top: parent.top
                onRangeRularChanged: handleRangeScaleChange(newValue)
            }

            Rectangle{              //Left rectangle start
                id:mainRect
                visible: true
                width:500;
                height:1000;
                color: "#1a1c1f"
                anchors.top: header.bottom
                anchors.right: parent.right

                CourseSpeedDepth {
                    id: courseSpeedDepthLoader
                }

                ListModel {
                    id: trackModel
                }

                TrackTable {
                    id: trackTableLoader
                    anchors.top: courseSpeedDepthLoader.bottom
                }

                SSMTargetData {
                    id: ssmTargetDataLoader
                    anchors.top: trackTableLoader.bottom
                }

                WayPoints {
                    id: wayPointsLoader
                    anchors.top: ssmTargetDataLoader.bottom
                }

                WeaponDangerZone {
                    id: weaponDangerZoneLoader
                    anchors.top: wayPointsLoader.bottom
                }

                LiquidationParameters {
                    id: liquidationParametersLoader
                    anchors.top: weaponDangerZoneLoader.bottom
                }

                ProbabilityOfKill {
                    id: probabilityOfKillLoader
                    anchors.top: liquidationParametersLoader.bottom
                }


                TrajectoryComputation {
                    id: trajectoryComputationLoader
                    anchors.top: probabilityOfKillLoader.bottom
                }

                Combat {
                    id: combatLoader
                    anchors.top: trajectoryComputationLoader.bottom
                }

                SelectStandByMissile{
                    id: selectStandByMissileLoader
                    anchors.top: combatLoader.bottom
                }

                DisplayLowerPart{
                    id: combatdisplayLowerPart
                    anchors.top: selectStandByMissileLoader.bottom
                }

                SensorCheckBox{
                    id: sensorCheckBox
                    anchors.top: combatdisplayLowerPart.bottom

                    onCheckBoxSelected: {
                        console.log("CheckBox Selected - ID:", checkBoxId, "Checked:", checked)
                        // Handle the signal here
                        if(checkBoxId == "radar1") {
                            radar1Flag = checked
                        }
                        if(checkBoxId == "sonar1") {
                            sonar1Flag = checked
                        }
                        if(checkBoxId == "sonar2") {
                            sonar2Flag = checked
                        }
                    }
                }

                HookedTrackInfo {
                    id: hookedTrackInfo
                    anchors.top: sensorCheckBox.bottom
                }

            } //Left rectangle end
            // New rectangle on the right side
            Rectangle {  //Right rectangle start
                id: newRect
                //            width: 350
                width: parent.width - mainRect.width
                //                height: Screen.desktopAvailableHeight
                height: mainRect.height // Match the height with the main rectangle

                anchors.right: mainRect.left
                anchors.top: header.bottom

                //Set Default Range Scale
                Component.onCompleted: {
                    range_scale_width = width;
                    range_scale_height = height;
                }

                // Background image
                Image {
                    anchors.fill: parent
                    source:"qrc:/map.jpg"
                    fillMode: Image.Stretch // Adjust this property according to your requirement
                }


//                RangeRular {
//                    id: rangeRularComponent
//                    anchors.top: newRect.top
//                    anchors.right: newRect.right
//                    // Connect the signal from RangeRular to the function in main.qml
//                    onRangeRularChanged: handleRangeScaleChange(newValue, count)
//                }

                GeometryDisplay{
                    id: geometryDisplay
                    anchors.centerIn: newRect.Center
                }

                OwnShipD{
                    anchors.centerIn: newRect.Center
                }

                ListModel {
                    id: trackListModel
                }

                Repeater {
                    id: trackRepeater
                    model: trackListModel

                    Rectangle {
                        id:hookRect
                        width: 22
                        height: 22
                        color: "transparent" // Semi-transparent red
                        x: model.latitude - width/2
                        y: model.longitude - height/2

                        property string sensorIdText: "SensorID: " + model.sensorID
                        property string rangeText: "Range: " + model.range
                        property string bearingText: "Bearing: " + model.bearing
                        property string speedText: "Speed: " + model.speed
                        visible: model.sensorFlag

                        Image {
                            id:image
                            width: parent.width
                            height: parent.height
                            source: model.trackIcon
                            fillMode: Image.Stretch

                        }

                        Image {
                            id:hookImage
                            x: - 7
                            y: - 7
                            width: parent.width+14
                            height: parent.height+14
                            source:"qrc:/Focus.svg"
                            fillMode: Image.Stretch
                            visible: model.hookFlag
                        }

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: {
                                infoText.visible = true
                            }

                            onExited: {
                                infoText.visible = false
                            }

                            onClicked: {
                                applyHook(model.trackId);
                            }
                        }

                        Text {
                            id: infoText
                            text: sensorIdText + "\n" + rangeText + "\n" + bearingText + "\n" + speedText
                            //                                anchors.centerIn: parent
                            color: "white"
                            anchors.bottom: parent.top
                            visible: false
                        }

                        Text {
                            text: model.trackId // Display the track ID
                            anchors {
                                horizontalCenter: parent.horizontalCenter // Center horizontally
                                top: parent.bottom // Anchor to the bottom of the rectangle
                                topMargin: 5 // Add some margin to separate the text from the rectangle
                            }
                            font.pixelSize: 12 // Set the font size as needed
                            color: "white" // Set the text color
                        }

                        Component.onCompleted: {

                            if(hookedTrack === model.trackId){
                                //                                centreRect.visible = true
                                hookImage.visible = true
                                hookedTrackInfo.trackHooked(model.trackId, model.sensorID, model.range, model.bearing, model.speed)
                            }
                        }
                    }
                }

                Timer {
                    interval: 500 // Check every 0.5 seconds
                    running: true
                    repeat: true
                    onTriggered: {
                        Tracks.checkTimestampDifference();
                    }
                }

            } //Right rectangle end

            Footer {
                id: footer
                anchors.bottom: parent.bottom
            }

            Connections {
                target: Tracks
                onTracksListNewUpdated: {
                    addTrackToModel(trackMap)
                }
            }

            Connections {
                target: Tracks
                onTrackRemoved: {
                    console.log("Tracks removing connections");
                    removeItemByTrackId(trackListModel, trackId);
                    removeItemByTrackId(trackModel, trackId);
                }
            }
        }
    }
}

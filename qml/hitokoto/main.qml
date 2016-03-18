import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0
import QtQuick.Window 2.1
import QtSensors 5.0
import "./main.js" as JS
import "./fontawesome.js" as FontAwesome
import harbour.saildbmeter.dbmeter 1.0

Rectangle {
    id: window
    width: isMobile() ? Screen.width : 480
    height: isMobile() ? Screen.height : 800

    property string hitokoto;
    property string  source
    property string  author
    property string  catname
    property bool loading: false
    property int fontlen: 0
    property alias level: meterObject.level

    DBMeterController {
        id: meterObject
        running: Qt.application.active
    }

    onLevelChanged: {
        //console.log("level:"+level)
        if(level.toFixed(2) > 80.00){
            JS.gethitokoto();
        }
    }

    function isMobile() {
                var b = false
                switch(Qt.platform.os) {
                case "ios":
                    b = true
                    break
                case "android":
                    b = true
                    break
                }
                console.log("ismobile:"+b)
                return b
            }

    Connections{
        target: signalcenter;
        onLoadStarted:{
            window.loading=true;
        }
        onLoadFinished:{
            window.loading=false;
        }
        onLoadFailed:{
            window.loading=false;
            //signalCenter.showMessage(errorstring);
            detectedText.text = errorstring;
        }
    }

    Signalcenter{
        id:signalcenter
    }

    Themex{
        id:themex
    }

    SensorGesture {
        id:gestureid
        gestures : ["QtSensors.shake"]
        enabled: true
        onDetected:{
            JS.gethitokoto()
        }
    }

    Image{
        id:img
        source: "./gfx.jpg"
        //fillMode: Image.PreserveAspectFit
        width: parent.width
        height:parent.height
        opacity: 0.08
    }
    FontLoader {
        source: "./fontawesome-webfont.ttf"
    }

    function getRandomIcon(){

        return FontAwesome.valuesArray[Math.ceil(Math.random()*(0-fontlen)+fontlen)]
    }

    Flickable{
        anchors.fill: parent
        contentHeight: detectedText.height + contentExt.height + themex.paddingMedium
        Label{
            id:detectedText
            anchors{
                left:parent.left
                right:parent.right
                margins: themex.paddingMedium
            }
            y:window.height / 2 - detectedText.height /2
            width: parent.width
            wrapMode: Text.WordWrap
            font.pixelSize: themex.fontSizeLarge
            color: themex.highlightColor
            opacity:0.7
            font.family: "FontAwesome"
            font.bold: true
            horizontalAlignment: Text.AlignLeft
            //truncationMode: TruncationMode.Elide
            text: getRandomIcon()+ ": "+hitokoto
            MouseArea{
                anchors.fill: parent
                onPressAndHold: {
                    Clipboard.text = hitokoto;
                    //addNotification(qsTr("Copyed to clipboard"));
                }
            }
        }
        Label{
            id:contentExt
            text:"——"+(source?(source+","):"")+catname
            width:parent.width * 0.7
            wrapMode: Text.WordWrap
            font.pixelSize:themex.fontSizeSmall
            horizontalAlignment: Text.AlignRight
            anchors{
                top:detectedText.bottom
                right:parent.right
                margins: themex.paddingMedium
            }
        }

    }
    Component.onCompleted: {
        console.log("app started")
        fontlen = FontAwesome.keysArray.length;
        JS.signalcenter = signalcenter
        JS.app = window
        JS.gethitokoto();

    }
}

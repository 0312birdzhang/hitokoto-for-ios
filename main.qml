import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0
import QtSensors 5.0
import "qml/main.js" as JS
import "qml/fontawesome.js" as FontAwesome
import "qml"

ApplicationWindow {
    id:window
    visible: true
    width: isMobile() ? Screen.width : 540
    height: isMobile() ? Screen.height : 960

    property string hitokoto;
    property string  source
    property string  author
    property string  catname
    property bool loading: false
    property int fontlen: 0


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
        gestures : ["QtSensors.shake","QtSensors.shake2",
                    "QtSensors.cover","QtSensors.doubletap","QtSensors.pickup"]
                   // "QtSensors.hover","QtSensors.slam","QtSensors.turnover","QtSensors.twist","QtSensors.whip"]
        enabled: true
        onDetected:{
            JS.gethitokoto()
        }
    }

    Image{
        id:img
        source: "qml/gfx.jpg"
        //fillMode: Image.PreserveAspectFit
        width: parent.width
        height:parent.height
        opacity: 0.1
    }
    FontLoader {
        source: "qml/fontawesome-webfont.ttf"
    }

    function getRandomIcon(){

        return FontAwesome.valuesArray[Math.ceil(Math.random()*(0-fontlen)+fontlen)]
    }
    function copy(text) {
            helper.text = text;
            helper.selectAll();
            helper.copy();

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
            text: hitokoto?(getRandomIcon()+ ": "+hitokoto):""
            MouseArea{
                anchors.fill: parent
                onPressAndHold: {
                    //Clipboard.text = hitokoto;
                    //addNotification(qsTr("Copyed to clipboard"));
                    copy(hitokoto);

                }

                onDoubleClicked: JS.gethitokoto()
            }
        }
        Label{
            id:contentExt
            text:catname?("——"+(source?(source+","):"")+catname):""
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
    TextEdit {
            id: helper
            visible: false
        }
    Component.onCompleted: {
        console.log("app started");
        fontlen = FontAwesome.keysArray.length;
        JS.signalcenter = signalcenter
        JS.app = window
        JS.gethitokoto();

    }
}

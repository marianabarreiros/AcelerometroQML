import QtQuick 2.10
import QtQuick.Window 2.10
import QtSensors 5.9

Window {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property var pixelDensity

    Rectangle {
        id: ball
        x: window.width - width
        y: window.height - height
        radius: width / 2
        width: 24 * pixelDensity
        height: 24 * pixelDensity
        color: "green"
        Behavior on x {NumberAnimation{ duration: 100} }
        Behavior on y {NumberAnimation{ duration: 100} }
    }

    Accelerometer{
        active: true
        dataRate: 20
        onReadingChanged: {
            var newX = ball.x - reading.x * pixelDensity * 30
            var newY = ball.y - reading.y * pixelDensity * 30

            if(newX + ball.width > window.width)
                newX = window.width - ball.width
            if(newY + ball.height > window.height)
                newY = window.height - ball.height
            if(newX  < 0)
                newX = 0
            if(newY < 0)
                newY = 0

            ball.x = newX
            ball.y = newY
        }
    }

    ProximitySensor{
        active: true
        dataRate: 20
        onReadingChanged: ball.color = (reading.near) ? "black":"green"
    }

    Component.onCompleted: pixelDensity = Screen.logicalPixelDensity
}

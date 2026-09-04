import QtQuick
import QtQuick.Layouts
import Quickshell.Io

BaseCard {
    cardTitle: Strings.cardTitleAbout
    cardIcon:  "»"

    Process {
        id: aboutProc
        command: ["argvus", "--about"]
    }

    Text {
        Layout.fillWidth: true
        text: Strings.aboutHint
        color: Theme.fgDim
        font.pixelSize: 10
        font.family: "Terminus (TTF)"
        wrapMode: Text.WordWrap
    }

    GlassButton {
        Layout.fillWidth: true
        implicitHeight: 36
        iconText: "\uf05a"
        label: Strings.aboutOpen
        active: true
        onClicked: if (!aboutProc.running) aboutProc.running = true
    }
}

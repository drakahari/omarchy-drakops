import QtQuick
import QtQuick.Controls
import Quickshell

Item {
  id: root

  property bool available: false
  readonly property string label: available ? "Open DrakOps" : "DrakOps is not installed"

  implicitWidth: 30
  implicitHeight: 26

  function refreshAvailability() {
    available = !!DesktopEntries.byId("drakops")
  }

  Component.onCompleted: refreshAvailability()

  Connections {
    target: DesktopEntries.applications
    function onValuesChanged() { root.refreshAvailability() }
  }

  function openDrakOps() {
    const entry = DesktopEntries.byId("drakops")
    if (entry)
      entry.execute()
  }

  Rectangle {
    anchors.centerIn: parent
    width: 24
    height: 20
    radius: 5
    color: hotspot.containsMouse && root.available ? "#5B328E" : "#43236D"
    opacity: root.available ? 1 : 0.55

    Text {
      anchors.centerIn: parent
      text: ">_"
      color: "#F8F0FF"
      font.pixelSize: 12
      font.bold: true
      font.family: "monospace"
    }
  }

  Accessible.role: Accessible.Button
  Accessible.name: root.label
  Accessible.onPressAction: root.openDrakOps()

  MouseArea {
    id: hotspot
    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.LeftButton
    cursorShape: root.available ? Qt.PointingHandCursor : Qt.ArrowCursor
    onClicked: root.openDrakOps()
  }

  ToolTip.visible: hotspot.containsMouse
  ToolTip.delay: 350
  ToolTip.text: root.label
}

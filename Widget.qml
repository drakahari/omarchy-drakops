import QtQuick
import QtQuick.Controls
import Quickshell

Item {
  id: root

  property bool available: false
  property url appIcon: ""
  readonly property string label: available ? "Open DrakOps" : "DrakOps is not installed"

  implicitWidth: 30
  implicitHeight: 26

  function refreshAvailability() {
    const entry = DesktopEntries.byId("drakops")
    available = !!entry
    const icon = entry ? entry.icon : ""
    appIcon = !icon ? "" : icon[0] === "/"
      ? "file://" + icon.split("/").map(encodeURIComponent).join("/")
      : /^[A-Za-z0-9_.-]+$/.test(icon) ? Quickshell.iconPath(icon, true) : ""
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

  Image {
    id: installedIcon
    objectName: "drakopsInstalledIcon"
    anchors.centerIn: parent
    width: 22
    height: 22
    source: root.appIcon
    sourceSize.width: 64
    sourceSize.height: 64
    fillMode: Image.PreserveAspectFit
    visible: status === Image.Ready
  }

  Rectangle {
    objectName: "drakopsFallbackIcon"
    visible: !installedIcon.visible
    anchors.centerIn: parent
    width: 24
    height: 20
    radius: 5
    color: hotspot.containsMouse && root.available ? "#5B328E" : "#43236D"
    opacity: root.available ? 1 : 0.55

    Text {
      anchors.centerIn: parent
      textFormat: Text.PlainText
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

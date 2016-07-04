import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

WaveletWindow {

  id: root

  theme {
      primaryColor: "#003262"
      accentColor: "#FDB515"
      tabHighlightColor: "#FF0000"//"#DCEDC8"
  }
  property string namespace: "gabe.pantry"
  signal namespaceUpdated();
  Item {
      Layout.preferredWidth: rows.implicitWidth + dp(40)
      anchors.right: parent.right
      anchors.margins: dp(20)
      RowLayout {
        id: rows
        anchors.right: parent.right
        Label {
          id: l
          anchors.left: parent.left
          anchors.margins: dp(20)
          color: "white"
          text: "Namespace: "
        }
        TextField {
            id: nsChooser
            anchors.left: l.right
            anchors.right: parent.right
            text: "gabe.pantry"
            textColor: "white"
            onAccepted: {
                console.log(nsChooser.text)
                namespace = nsChooser.text
                namespaceUpdated();
            }
        }
      }
  }

  initialPage : TabbedPage {
    id : overview
    title : "Service Dashboard"
    Tab {
      title : "Services"
      ServicesList {
        id: list
        renderNS: namespace
      }
    }


  }
}

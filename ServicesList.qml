import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import BOSSWAVE 1.0
import WaveViewer 1.0

Item {

  id : main
  property string renderNS: ""

  function update() {
    console.log("Namespace:", renderNS)
    if (renderNS.length == 0) {
        return
    }
    BW.createView({
      "ns":[renderNS],
    },function(err, handle) {
      console.log("creation error:", err);
      console.log("handle:",handle);
      console.log("interfaces: ", handle.interfaces);
      bv = Qt.binding(function(){
        console.log("evaluated binding")
        return handle.interfaces;
      })
    });
  }

  Component {
    id: svc_delegate

    View {
      elevation:1
      Layout.preferredHeight: lay.implicitHeight+dp(40)
      anchors.left:parent.left
      anchors.right:parent.right
      GridLayout {
        id:lay
        anchors.margins: dp(20)
        columns:4
        anchors.fill:parent
        Label {
          style: "title"
          text: modelData.suffix
          Layout.columnSpan:2
          Layout.fillWidth: true
        }
       Label {
         style: "body2"
         text: "Last seen "
       }
        AgeLabel {
          style: "subheading"
          from: modelData.metadata["lastalive"]
        }
        Label {
          style: "body2"
          text: "Metadata:"
          Layout.columnSpan:3
        }
        Button {
            anchors.right: parent.right
            text: "Detail"
            elevation: 1
            onClicked: {
                //page.serviceURI = renderNS + modelData.suffix
                console.log(renderNS+"/"+modelData.suffix)
                pageStack.push(Qt.resolvedUrl("ServiceDetail.qml"), {serviceURI: renderNS+"/"+modelData.suffix})
            }
        }
        Repeater {
          model: MetadataModel {
            from: modelData.metadata
            excludeHB: true
          }
          Label {
            style: "body1"
            Layout.columnSpan: 4
            text: key + " -> " + value
          }
        }
      }
    }
  }
  property var bv : []
  Component.onCompleted : {
    update();
  }
  Connections {
    target: root
    onNamespaceUpdated: {
        update();
    }
  }

  Flickable {
    anchors.fill:parent
    contentWidth: v.width
    contentHeight: v.height
    anchors.margins: dp(20)
    Item {
      id : v
      //elevation: 1
      width: main.width < dp(800) ? dp(800) : main.width - dp(40)
      height: col.implicitHeight
      //height: 1000
      ColumnLayout {
        id: col
        width: v.width

        //anchors.margins: dp(50)
        ListItem.Subheader {
          text: "Available interfaces on "+namespace
        }
        Repeater {
          id: rep
          delegate: svc_delegate
          model: bv
        }
        Item {
          Layout.fillHeight:true
        }
      }
    }

  }


}

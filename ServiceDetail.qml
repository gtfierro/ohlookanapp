import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import BOSSWAVE 1.0
import WaveViewer 1.0
import MrPlotter 0.1
import "mr-plotter-layouts" as MrPlotterLayouts

TabbedPage {
    id: page
    title: "Detail"
    property string serviceURI: ""
    property var plotme: []
    onGoBack: {
        event.accepted = true
    }
    Tab {
        title: "Detail"

        Component.onCompleted: {
            var vk = BW.getVK()
            vk = vk.slice(0,vk.length-1)
            var uri = "gabe.ns/s.giles/0/i.archiver/signal/"+vk+",queries"
            console.log("try to load", serviceURI)
            BW.subscribeMsgPack(uri, 
                function(msg) {
                    console.log("GOT",JSON.stringify(msg))
                    for (var u in msg.Data) {
                        console.log("->",msg.Data[u])
                        streams.append({"suuid": msg.Data[u]})
                        plotme.push({"suuid": msg.Data[u]})
                    }
                    console.log("done", JSON.stringify(plotme))
                },
                function(error) {
                    console.log("error", error)
                }
            )
            var queryString = "select distinct uuid where Path like '"+serviceURI+"/*';"
            BW.publishMsgPack("gabe.ns/s.giles/0/i.archiver/slot/query", "2.0.8.1", {"Nonce": 1, "Query": queryString},
              function(msg) {
                  console.log("published", {"Nonce": 1, "Query": queryString});
              }
            )
        }

        ListModel {
            id: streams
        }

        //RowLayout {
        //    id: row
        //    model: uuids
        //    delegate: MrPlotterLayouts.Sparkline {
        //      uuid: suuid
        //      archiver: "gabe.ns/s.giles/0/i.archiver"
        //      autozoomOnLoad: true
        //      color: "blue"
        //      scrollZoomable: false

        //      width: view.cellWidth
        //      height: view.cellHeight
        //    }
        //}

        GridView {
          id: view
          anchors.fill: parent
          cellWidth: 300
          cellHeight: 200

          model: streams
          delegate: MrPlotterLayouts.Sparkline {
            uuid: suuid
            archiver: "gabe.ns/s.giles/0/i.archiver"
            autozoomOnLoad: true
            color: "blue"
            scrollZoomable: false

            width: view.cellWidth
            height: view.cellHeight
            Component.onCompleted: {
                console.log("plot", suuid)
            }
          }
        }

        //Button {
        //    width: 200
        //    height: 80
        //    elevation: 2
        //    anchors.bottom: parent.bottom
        //    text: "BACK"
        //    onClicked: page.forcePop()
        //}
    }
}

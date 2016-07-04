import QtQuick 2.0
import MrPlotter 0.1

Item {
    id: toplevel
    property string uuid
    property string archiver
    property bool autozoomOnLoad
    property alias color: stream.color
    property alias timeDomain: mrp.timeDomain
    property alias scrollZoomable: pa.scrollZoomable

    Stream {
        id: stream
        uuid: toplevel.uuid
        archiver: toplevel.archiver
    }

    YAxis {
        id: yaxis
        dynamicAutoscale: true
        name: "Reading"
        domain: [-1, 1]
        streamList: [stream]

        Behavior on domainLo {
            NumberAnimation {
                duration: 200
            }
        }

        Behavior on domainHi {
            NumberAnimation {
                duration: 200
            }
        }
    }

    PlotArea {
        id: pa
        anchors.fill: toplevel

        streamList: [stream]
    }

    MrPlotter {
        id: mrp
        mainPlot: pa
        timeDomain: [1415643674978, 1415643674979, 469055, 469060]

        Component.onCompleted: {
            if (autozoomOnLoad)
            {
                mrp.autozoom([stream]);
            }
        }
    }
}

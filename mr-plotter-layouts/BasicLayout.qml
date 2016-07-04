import QtQuick 2.0
import MrPlotter 0.1

Item {
    id: toplevel
    property alias plotter: mrp;
    property alias plotarea: pa;
    property alias datadensityplotarea: ddpa;
    property alias yaxisarea: yaa;
    property alias datadensityyaxisarea: ddyaa;

    PlotArea {
        id: ddpa
        anchors.left: pa.left
        width: pa.width
        height: 70
        yAxisArea: ddyaa
    }

    YAxisArea {
        id: ddyaa
        y: 0
        anchors.right: ddpa.left
        width: fyaa.width
        height: parent.height
        rangeStart: ddpa.y + ddpa.height
        rangeEnd: ddpa.y
    }

    PlotArea {
        id: pa
        y: ddpa.height + 15
        anchors.left: fyaa.right
        width: parent.width - fyaa.width
        height: Math.max(parent.height - taa.height - ddpa.height, 60)
        yAxisArea: yaa
    }

    Flickable {
        id: fyaa
        anchors.left: parent.left
        y: 0
        width: Math.min(parent.width / 5, yaa.width)
        height: parent.height
        contentWidth: yaa.width
        clip: true

        YAxisArea {
            id: yaa
            height: fyaa.height
            rangeStart: pa.y + pa.height
            rangeEnd: pa.y
        }
    }

    TimeAxisArea {
        id: taa
        anchors.top: pa.bottom
        x: 0
        width: parent.width
        height: 70
        rangeStart: pa.x
        rangeEnd: pa.x + pa.width
    }

    MrPlotter {
        id: mrp
        mainPlot: pa
        dataDensityPlot: ddpa
        timeaxisarea: taa
    }
}

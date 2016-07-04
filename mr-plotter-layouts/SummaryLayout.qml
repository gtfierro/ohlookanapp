import QtQuick 2.0
import MrPlotter 0.1

Item {
    property alias plotter: mrp;
    property alias plotarea: pa;

    PlotArea {
        id: pa
        anchors.fill: parent
    }

    MrPlotter {
        id: mrp
        mainPlot: pa
    }
}

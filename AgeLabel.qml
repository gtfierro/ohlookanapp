import "moment.js" as Moment
import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1 as ListItem
import Material.Extras 0.1

Label {
  id : top
  text : ""
  property string from : ""
  function update() {
    if (from == "") {
      return
    }
    var d = Moment.moment(from, "YYYY-MM-DD HH:mm:ss.SSSSSSSSS Z");
    top.text = d.fromNow();
  }
  Timer {
    interval: 2000; running: true; repeat: true
    onTriggered: {update();}
  }
  Component.onCompleted : {update();}
}

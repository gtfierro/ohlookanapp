import QtQml.Models 2.2

ListModel {
  property var from
  property bool excludeHB : false
  onFromChanged : {
    clear();
    for (var key in from) {
      if (key == "lastalive" && excludeHB) {
        continue
      }
      append({"key":key, "value":from[key]});
    }
  }
}

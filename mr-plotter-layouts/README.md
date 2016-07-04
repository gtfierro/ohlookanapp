Mr. Plotter Layouts Library
===========================

While the Mr. Plotter QML repository (SoftwareDefinedBuildings/mr-plotter-qml) provides QML components, implemented in C++, for the plotter, the QML interface is rather low-level. This is useful because it is highly customizable; however, it can be cumbersome for an application developer who simply wants to "drop in" a plot.

In this repository are a series of preset QML Layouts for Mr. Plotter that allow a user to include a plot by placing a single QML component, that already contains the "glue" for positioning the plot area, axis area, etc., into his or her application. Hopefully this will ease application development by making it easy to create plots with commonly-used layouts.

If you need a more customizable layout than the ones provided in this repository, you can import MrPlotter directly (see SoftwareDefinedBuildings/mr-plotter-qml) and use the low-level components.

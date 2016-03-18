import QtQuick 2.0

QtObject{
         id:signalcenter;
         signal loadStarted;
         signal loadFinished;
         signal loadFailed(string errorstring);
        }

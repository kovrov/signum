import QtQuick 2.4
import Network 1.0

Item {

    Column {
        anchors.centerIn: parent
        spacing: 16

        Repeater {
            model: NetworkConfigurationModel {}

            Column {

                NetworkSession {
                    id: session
                    configuration: model.configuration
                }

                Row {
                    spacing: 8
                    Text {
                        color: "gray"
                        text: "Interface: " + model.bearerTypeName + " (" + model.name + ")"
                    }
                    Text {
                        text: "[" +
                              ["Invalid",
                            "NotAvailable",
                            "Connecting",
                            "Connected",
                            "Closing",
                            "Disconnected",
                            "Roaming"][session.state] + "]"
                    }
                }

                Text {
                    color: "gray"
                    text: {
                        var flags = {
                            IsUp: session.interface.flags & NetworkSession.IsUp,
                            IsRunning: session.interface.flags & NetworkSession.IsRunning,
                            CanBroadcast: session.interface.flags & NetworkSession.CanBroadcast,
                            IsLoopBack: session.interface.flags & NetworkSession.IsLoopBack,
                            IsPointToPoint: session.interface.flags & NetworkSession.IsPointToPoint,
                            CanMulticast: session.interface.flags & NetworkSession.CanMulticast
                        }
                        Object.keys(flags).filter(function(k){return flags[k]}).join(" | ");
                    }
                }

                Row {
                    spacing: 8
                    Text {
                        visible: Boolean(session.interface.hardwareAddress)
                        color: "gray"
                        text: "Hardware Address:"
                    }
                    Text {
                        visible: Boolean(session.interface.hardwareAddress)
                        color: "gray"
                        text: session.interface.hardwareAddress
                    }
                }

                Repeater {
                    model: session.interface.addressEntries.filter(function(i) {
                        return Boolean(i.protocol.toLowerCase() === "ipv4");
                    })
                    Row {
                        spacing: 8
                        Text { text: "IP Address: (" + modelData.protocol + "):"; color: "gray" }
                        Text { text: modelData.ip }
                    }
                }
            }
        }
    }
}


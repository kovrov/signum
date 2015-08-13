TEMPLATE = aux

OTHER_FILES += $$files(*.qml)

qml.path = /usr/share/signum
qml.files = $$files(*.qml) $$files(*.js)

INSTALLS += qml

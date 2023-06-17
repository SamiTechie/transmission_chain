from PySide6.QtQuick import QQuickItem
from PySide6.QtCore import QObject

class MaskedMouseArea(QQuickItem):
    def __init__(self):
        QObject().__init__()
        Q_PROPERTY(bool pressed READ isPressed NOTIFY pressedChanged)

text = MaskedMouseArea()


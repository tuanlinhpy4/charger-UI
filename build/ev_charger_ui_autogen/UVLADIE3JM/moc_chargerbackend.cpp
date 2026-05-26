/****************************************************************************
** Meta object code from reading C++ file 'chargerbackend.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../src/chargerbackend.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'chargerbackend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_ChargerPort_t {
    QByteArrayData data[23];
    char stringdata0[281];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ChargerPort_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ChargerPort_t qt_meta_stringdata_ChargerPort = {
    {
QT_MOC_LITERAL(0, 0, 11), // "ChargerPort"
QT_MOC_LITERAL(1, 12, 12), // "stateChanged"
QT_MOC_LITERAL(2, 25, 0), // ""
QT_MOC_LITERAL(3, 26, 21), // "batteryPercentChanged"
QT_MOC_LITERAL(4, 48, 22), // "energyDeliveredChanged"
QT_MOC_LITERAL(5, 71, 21), // "elapsedSecondsChanged"
QT_MOC_LITERAL(6, 93, 19), // "currentPowerChanged"
QT_MOC_LITERAL(7, 113, 9), // "onSimTick"
QT_MOC_LITERAL(8, 123, 13), // "startCharging"
QT_MOC_LITERAL(9, 137, 12), // "stopCharging"
QT_MOC_LITERAL(10, 150, 4), // "name"
QT_MOC_LITERAL(11, 155, 9), // "connector"
QT_MOC_LITERAL(12, 165, 8), // "maxPower"
QT_MOC_LITERAL(13, 174, 5), // "state"
QT_MOC_LITERAL(14, 180, 14), // "batteryPercent"
QT_MOC_LITERAL(15, 195, 15), // "energyDelivered"
QT_MOC_LITERAL(16, 211, 14), // "elapsedSeconds"
QT_MOC_LITERAL(17, 226, 12), // "currentPower"
QT_MOC_LITERAL(18, 239, 5), // "State"
QT_MOC_LITERAL(19, 245, 9), // "Available"
QT_MOC_LITERAL(20, 255, 8), // "Charging"
QT_MOC_LITERAL(21, 264, 8), // "Finished"
QT_MOC_LITERAL(22, 273, 7) // "Faulted"

    },
    "ChargerPort\0stateChanged\0\0"
    "batteryPercentChanged\0energyDeliveredChanged\0"
    "elapsedSecondsChanged\0currentPowerChanged\0"
    "onSimTick\0startCharging\0stopCharging\0"
    "name\0connector\0maxPower\0state\0"
    "batteryPercent\0energyDelivered\0"
    "elapsedSeconds\0currentPower\0State\0"
    "Available\0Charging\0Finished\0Faulted"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ChargerPort[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       8,   62, // properties
       1,   94, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x06 /* Public */,
       3,    0,   55,    2, 0x06 /* Public */,
       4,    0,   56,    2, 0x06 /* Public */,
       5,    0,   57,    2, 0x06 /* Public */,
       6,    0,   58,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       7,    0,   59,    2, 0x08 /* Private */,

 // methods: name, argc, parameters, tag, flags
       8,    0,   60,    2, 0x02 /* Public */,
       9,    0,   61,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
      10, QMetaType::QString, 0x00095401,
      11, QMetaType::QString, 0x00095401,
      12, QMetaType::Int, 0x00095401,
      13, QMetaType::Int, 0x00495103,
      14, QMetaType::Double, 0x00495001,
      15, QMetaType::Double, 0x00495001,
      16, QMetaType::Int, 0x00495001,
      17, QMetaType::Double, 0x00495001,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,
       1,
       2,
       3,
       4,

 // enums: name, alias, flags, count, data
      18,   18, 0x0,    4,   99,

 // enum data: key, value
      19, uint(ChargerPort::Available),
      20, uint(ChargerPort::Charging),
      21, uint(ChargerPort::Finished),
      22, uint(ChargerPort::Faulted),

       0        // eod
};

void ChargerPort::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ChargerPort *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->stateChanged(); break;
        case 1: _t->batteryPercentChanged(); break;
        case 2: _t->energyDeliveredChanged(); break;
        case 3: _t->elapsedSecondsChanged(); break;
        case 4: _t->currentPowerChanged(); break;
        case 5: _t->onSimTick(); break;
        case 6: _t->startCharging(); break;
        case 7: _t->stopCharging(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::stateChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::batteryPercentChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::energyDeliveredChanged)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::elapsedSecondsChanged)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::currentPowerChanged)) {
                *result = 4;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ChargerPort *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->name(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->connector(); break;
        case 2: *reinterpret_cast< int*>(_v) = _t->maxPower(); break;
        case 3: *reinterpret_cast< int*>(_v) = _t->state(); break;
        case 4: *reinterpret_cast< double*>(_v) = _t->batteryPercent(); break;
        case 5: *reinterpret_cast< double*>(_v) = _t->energyDelivered(); break;
        case 6: *reinterpret_cast< int*>(_v) = _t->elapsedSeconds(); break;
        case 7: *reinterpret_cast< double*>(_v) = _t->currentPower(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<ChargerPort *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 3: _t->setState(*reinterpret_cast< int*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
    (void)_a;
}

QT_INIT_METAOBJECT const QMetaObject ChargerPort::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ChargerPort.data,
    qt_meta_data_ChargerPort,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *ChargerPort::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ChargerPort::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ChargerPort.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ChargerPort::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 8;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 8;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void ChargerPort::stateChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void ChargerPort::batteryPercentChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void ChargerPort::energyDeliveredChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void ChargerPort::elapsedSecondsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void ChargerPort::currentPowerChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}
struct qt_meta_stringdata_ChargerBackend_t {
    QByteArrayData data[10];
    char stringdata0[119];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ChargerBackend_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ChargerBackend_t qt_meta_stringdata_ChargerBackend = {
    {
QT_MOC_LITERAL(0, 0, 14), // "ChargerBackend"
QT_MOC_LITERAL(1, 15, 18), // "currentTimeChanged"
QT_MOC_LITERAL(2, 34, 0), // ""
QT_MOC_LITERAL(3, 35, 20), // "ocppConnectedChanged"
QT_MOC_LITERAL(4, 56, 11), // "currentTime"
QT_MOC_LITERAL(5, 68, 11), // "currentDate"
QT_MOC_LITERAL(6, 80, 13), // "ocppConnected"
QT_MOC_LITERAL(7, 94, 5), // "portA"
QT_MOC_LITERAL(8, 100, 12), // "ChargerPort*"
QT_MOC_LITERAL(9, 113, 5) // "portB"

    },
    "ChargerBackend\0currentTimeChanged\0\0"
    "ocppConnectedChanged\0currentTime\0"
    "currentDate\0ocppConnected\0portA\0"
    "ChargerPort*\0portB"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ChargerBackend[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       2,   14, // methods
       5,   26, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   24,    2, 0x06 /* Public */,
       3,    0,   25,    2, 0x06 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
       4, QMetaType::QString, 0x00495001,
       5, QMetaType::QString, 0x00495001,
       6, QMetaType::Bool, 0x00495001,
       7, 0x80000000 | 8, 0x00095409,
       9, 0x80000000 | 8, 0x00095409,

 // properties: notify_signal_id
       0,
       0,
       1,
       0,
       0,

       0        // eod
};

void ChargerBackend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ChargerBackend *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->currentTimeChanged(); break;
        case 1: _t->ocppConnectedChanged(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ChargerBackend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerBackend::currentTimeChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ChargerBackend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerBackend::ocppConnectedChanged)) {
                *result = 1;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 4:
        case 3:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< ChargerPort* >(); break;
        }
    }

#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<ChargerBackend *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->currentTime(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->currentDate(); break;
        case 2: *reinterpret_cast< bool*>(_v) = _t->ocppConnected(); break;
        case 3: *reinterpret_cast< ChargerPort**>(_v) = _t->portA(); break;
        case 4: *reinterpret_cast< ChargerPort**>(_v) = _t->portB(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject ChargerBackend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ChargerBackend.data,
    qt_meta_data_ChargerBackend,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *ChargerBackend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ChargerBackend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ChargerBackend.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ChargerBackend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 2)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 2;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 5;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 5;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void ChargerBackend::currentTimeChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void ChargerBackend::ocppConnectedChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE

/****************************************************************************
** Meta object code from reading C++ file 'chargerbackend.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.2.4)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "src/chargerbackend.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'chargerbackend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.2.4. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_SessionRecord_t {
    const uint offsetsAndSize[26];
    char stringdata0[115];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_SessionRecord_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_SessionRecord_t qt_meta_stringdata_SessionRecord = {
    {
QT_MOC_LITERAL(0, 13), // "SessionRecord"
QT_MOC_LITERAL(14, 9), // "sessionId"
QT_MOC_LITERAL(24, 8), // "portName"
QT_MOC_LITERAL(33, 9), // "connector"
QT_MOC_LITERAL(43, 9), // "timestamp"
QT_MOC_LITERAL(53, 6), // "energy"
QT_MOC_LITERAL(60, 8), // "duration"
QT_MOC_LITERAL(69, 8), // "avgPower"
QT_MOC_LITERAL(78, 4), // "cost"
QT_MOC_LITERAL(83, 6), // "status"
QT_MOC_LITERAL(90, 8), // "startSoc"
QT_MOC_LITERAL(99, 6), // "endSoc"
QT_MOC_LITERAL(106, 8) // "maxPower"

    },
    "SessionRecord\0sessionId\0portName\0"
    "connector\0timestamp\0energy\0duration\0"
    "avgPower\0cost\0status\0startSoc\0endSoc\0"
    "maxPower"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_SessionRecord[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
       0,    0, // methods
      12,   14, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // properties: name, type, flags
       1, QMetaType::QString, 0x00015401, uint(-1), 0,
       2, QMetaType::QString, 0x00015401, uint(-1), 0,
       3, QMetaType::QString, 0x00015401, uint(-1), 0,
       4, QMetaType::QString, 0x00015401, uint(-1), 0,
       5, QMetaType::Double, 0x00015401, uint(-1), 0,
       6, QMetaType::Int, 0x00015401, uint(-1), 0,
       7, QMetaType::Double, 0x00015401, uint(-1), 0,
       8, QMetaType::Double, 0x00015401, uint(-1), 0,
       9, QMetaType::QString, 0x00015401, uint(-1), 0,
      10, QMetaType::Double, 0x00015401, uint(-1), 0,
      11, QMetaType::Double, 0x00015401, uint(-1), 0,
      12, QMetaType::Double, 0x00015401, uint(-1), 0,

       0        // eod
};

void SessionRecord::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{

#ifndef QT_NO_PROPERTIES
    if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<SessionRecord *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->sessionId(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->portName(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->connector(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->timestamp(); break;
        case 4: *reinterpret_cast< double*>(_v) = _t->energy(); break;
        case 5: *reinterpret_cast< int*>(_v) = _t->duration(); break;
        case 6: *reinterpret_cast< double*>(_v) = _t->avgPower(); break;
        case 7: *reinterpret_cast< double*>(_v) = _t->cost(); break;
        case 8: *reinterpret_cast< QString*>(_v) = _t->status(); break;
        case 9: *reinterpret_cast< double*>(_v) = _t->startSoc(); break;
        case 10: *reinterpret_cast< double*>(_v) = _t->endSoc(); break;
        case 11: *reinterpret_cast< double*>(_v) = _t->maxPower(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
#endif // QT_NO_PROPERTIES
    (void)_o;
    (void)_id;
    (void)_c;
    (void)_a;
}

const QMetaObject SessionRecord::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_SessionRecord.offsetsAndSize,
    qt_meta_data_SessionRecord,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_SessionRecord_t
, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<int, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<SessionRecord, std::true_type>



>,
    nullptr
} };


const QMetaObject *SessionRecord::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *SessionRecord::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_SessionRecord.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int SessionRecord::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    
#ifndef QT_NO_PROPERTIES
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}
struct qt_meta_stringdata_ChargerPort_t {
    const uint offsetsAndSize[114];
    char stringdata0[606];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_ChargerPort_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_ChargerPort_t qt_meta_stringdata_ChargerPort = {
    {
QT_MOC_LITERAL(0, 11), // "ChargerPort"
QT_MOC_LITERAL(12, 12), // "stateChanged"
QT_MOC_LITERAL(25, 0), // ""
QT_MOC_LITERAL(26, 16), // "connectorChanged"
QT_MOC_LITERAL(43, 21), // "batteryPercentChanged"
QT_MOC_LITERAL(65, 22), // "energyDeliveredChanged"
QT_MOC_LITERAL(88, 21), // "elapsedSecondsChanged"
QT_MOC_LITERAL(110, 19), // "currentPowerChanged"
QT_MOC_LITERAL(130, 14), // "sessionStarted"
QT_MOC_LITERAL(145, 9), // "sessionId"
QT_MOC_LITERAL(155, 12), // "sessionEnded"
QT_MOC_LITERAL(168, 6), // "energy"
QT_MOC_LITERAL(175, 4), // "cost"
QT_MOC_LITERAL(180, 8), // "avgPower"
QT_MOC_LITERAL(189, 8), // "startSoc"
QT_MOC_LITERAL(198, 6), // "endSoc"
QT_MOC_LITERAL(205, 6), // "status"
QT_MOC_LITERAL(212, 8), // "duration"
QT_MOC_LITERAL(221, 6), // "maxPwr"
QT_MOC_LITERAL(228, 11), // "authChanged"
QT_MOC_LITERAL(240, 13), // "faultOccurred"
QT_MOC_LITERAL(254, 6), // "reason"
QT_MOC_LITERAL(261, 9), // "onSimTick"
QT_MOC_LITERAL(271, 13), // "startCharging"
QT_MOC_LITERAL(285, 12), // "stopCharging"
QT_MOC_LITERAL(298, 9), // "resetPort"
QT_MOC_LITERAL(308, 12), // "authenticate"
QT_MOC_LITERAL(321, 6), // "method"
QT_MOC_LITERAL(328, 10), // "credential"
QT_MOC_LITERAL(339, 12), // "setConnector"
QT_MOC_LITERAL(352, 4), // "conn"
QT_MOC_LITERAL(357, 10), // "setPricing"
QT_MOC_LITERAL(368, 6), // "config"
QT_MOC_LITERAL(375, 8), // "setState"
QT_MOC_LITERAL(384, 1), // "s"
QT_MOC_LITERAL(386, 4), // "name"
QT_MOC_LITERAL(391, 9), // "connector"
QT_MOC_LITERAL(401, 8), // "maxPower"
QT_MOC_LITERAL(410, 5), // "state"
QT_MOC_LITERAL(416, 14), // "batteryPercent"
QT_MOC_LITERAL(431, 15), // "energyDelivered"
QT_MOC_LITERAL(447, 14), // "elapsedSeconds"
QT_MOC_LITERAL(462, 12), // "currentPower"
QT_MOC_LITERAL(475, 11), // "sessionCost"
QT_MOC_LITERAL(487, 13), // "authenticated"
QT_MOC_LITERAL(501, 5), // "State"
QT_MOC_LITERAL(507, 9), // "Available"
QT_MOC_LITERAL(517, 8), // "Charging"
QT_MOC_LITERAL(526, 8), // "Finished"
QT_MOC_LITERAL(535, 7), // "Faulted"
QT_MOC_LITERAL(543, 6), // "Locked"
QT_MOC_LITERAL(550, 12), // "AwaitingAuth"
QT_MOC_LITERAL(563, 10), // "AuthMethod"
QT_MOC_LITERAL(574, 5), // "AppQR"
QT_MOC_LITERAL(580, 7), // "NFCRfid"
QT_MOC_LITERAL(588, 3), // "PIN"
QT_MOC_LITERAL(592, 13) // "PlugAndCharge"

    },
    "ChargerPort\0stateChanged\0\0connectorChanged\0"
    "batteryPercentChanged\0energyDeliveredChanged\0"
    "elapsedSecondsChanged\0currentPowerChanged\0"
    "sessionStarted\0sessionId\0sessionEnded\0"
    "energy\0cost\0avgPower\0startSoc\0endSoc\0"
    "status\0duration\0maxPwr\0authChanged\0"
    "faultOccurred\0reason\0onSimTick\0"
    "startCharging\0stopCharging\0resetPort\0"
    "authenticate\0method\0credential\0"
    "setConnector\0conn\0setPricing\0config\0"
    "setState\0s\0name\0connector\0maxPower\0"
    "state\0batteryPercent\0energyDelivered\0"
    "elapsedSeconds\0currentPower\0sessionCost\0"
    "authenticated\0State\0Available\0Charging\0"
    "Finished\0Faulted\0Locked\0AwaitingAuth\0"
    "AuthMethod\0AppQR\0NFCRfid\0PIN\0PlugAndCharge"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ChargerPort[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
      19,   14, // methods
      13,  181, // properties
       2,  246, // enums/sets
       0,    0, // constructors
       0,       // flags
      10,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,  128,    2, 0x06,   14 /* Public */,
       3,    0,  129,    2, 0x06,   15 /* Public */,
       4,    0,  130,    2, 0x06,   16 /* Public */,
       5,    0,  131,    2, 0x06,   17 /* Public */,
       6,    0,  132,    2, 0x06,   18 /* Public */,
       7,    0,  133,    2, 0x06,   19 /* Public */,
       8,    1,  134,    2, 0x06,   20 /* Public */,
      10,    9,  137,    2, 0x06,   22 /* Public */,
      19,    0,  156,    2, 0x06,   32 /* Public */,
      20,    1,  157,    2, 0x06,   33 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
      22,    0,  160,    2, 0x08,   35 /* Private */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      23,    0,  161,    2, 0x02,   36 /* Public */,
      24,    0,  162,    2, 0x02,   37 /* Public */,
      25,    0,  163,    2, 0x02,   38 /* Public */,
      26,    2,  164,    2, 0x02,   39 /* Public */,
      26,    1,  169,    2, 0x22,   42 /* Public | MethodCloned */,
      29,    1,  172,    2, 0x02,   44 /* Public */,
      31,    1,  175,    2, 0x02,   46 /* Public */,
      33,    1,  178,    2, 0x02,   48 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    9,
    QMetaType::Void, QMetaType::QString, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::QString, QMetaType::Int, QMetaType::Double,    9,   11,   12,   13,   14,   15,   16,   17,   18,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,   21,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Bool, QMetaType::Int, QMetaType::QString,   27,   28,
    QMetaType::Bool, QMetaType::Int,   27,
    QMetaType::Void, QMetaType::QString,   30,
    QMetaType::Void, QMetaType::QVariantMap,   32,
    QMetaType::Void, QMetaType::Int,   34,

 // properties: name, type, flags
      35, QMetaType::QString, 0x00015401, uint(-1), 0,
      36, QMetaType::QString, 0x00015001, uint(1), 0,
      37, QMetaType::Int, 0x00015401, uint(-1), 0,
      38, QMetaType::Int, 0x00015001, uint(0), 0,
      39, QMetaType::Double, 0x00015001, uint(2), 0,
      14, QMetaType::Double, 0x00015001, uint(2), 0,
      40, QMetaType::Double, 0x00015001, uint(3), 0,
      41, QMetaType::Int, 0x00015001, uint(4), 0,
      42, QMetaType::Double, 0x00015001, uint(5), 0,
      13, QMetaType::Double, 0x00015001, uint(3), 0,
      43, QMetaType::Double, 0x00015001, uint(3), 0,
       9, QMetaType::QString, 0x00015001, uint(6), 0,
      44, QMetaType::Bool, 0x00015001, uint(8), 0,

 // enums: name, alias, flags, count, data
      45,   45, 0x0,    6,  256,
      52,   52, 0x0,    4,  268,

 // enum data: key, value
      46, uint(ChargerPort::Available),
      47, uint(ChargerPort::Charging),
      48, uint(ChargerPort::Finished),
      49, uint(ChargerPort::Faulted),
      50, uint(ChargerPort::Locked),
      51, uint(ChargerPort::AwaitingAuth),
      53, uint(ChargerPort::AppQR),
      54, uint(ChargerPort::NFCRfid),
      55, uint(ChargerPort::PIN),
      56, uint(ChargerPort::PlugAndCharge),

       0        // eod
};

void ChargerPort::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ChargerPort *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->stateChanged(); break;
        case 1: _t->connectorChanged(); break;
        case 2: _t->batteryPercentChanged(); break;
        case 3: _t->energyDeliveredChanged(); break;
        case 4: _t->elapsedSecondsChanged(); break;
        case 5: _t->currentPowerChanged(); break;
        case 6: _t->sessionStarted((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 7: _t->sessionEnded((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[6])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[7])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[8])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[9]))); break;
        case 8: _t->authChanged(); break;
        case 9: _t->faultOccurred((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 10: _t->onSimTick(); break;
        case 11: _t->startCharging(); break;
        case 12: _t->stopCharging(); break;
        case 13: _t->resetPort(); break;
        case 14: { bool _r = _t->authenticate((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 15: { bool _r = _t->authenticate((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 16: _t->setConnector((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 17: _t->setPricing((*reinterpret_cast< std::add_pointer_t<QVariantMap>>(_a[1]))); break;
        case 18: _t->setState((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
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
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::connectorChanged)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::batteryPercentChanged)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::energyDeliveredChanged)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::elapsedSecondsChanged)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::currentPowerChanged)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)(const QString & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::sessionStarted)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)(const QString & , double , double , double , double , double , const QString & , int , double );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::sessionEnded)) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::authChanged)) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (ChargerPort::*)(const QString & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerPort::faultOccurred)) {
                *result = 9;
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
        case 5: *reinterpret_cast< double*>(_v) = _t->startSoc(); break;
        case 6: *reinterpret_cast< double*>(_v) = _t->energyDelivered(); break;
        case 7: *reinterpret_cast< int*>(_v) = _t->elapsedSeconds(); break;
        case 8: *reinterpret_cast< double*>(_v) = _t->currentPower(); break;
        case 9: *reinterpret_cast< double*>(_v) = _t->avgPower(); break;
        case 10: *reinterpret_cast< double*>(_v) = _t->sessionCost(); break;
        case 11: *reinterpret_cast< QString*>(_v) = _t->sessionId(); break;
        case 12: *reinterpret_cast< bool*>(_v) = _t->authenticated(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject ChargerPort::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ChargerPort.offsetsAndSize,
    qt_meta_data_ChargerPort,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_ChargerPort_t
, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<int, std::true_type>, QtPrivate::TypeAndForceComplete<int, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<int, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<bool, std::true_type>, QtPrivate::TypeAndForceComplete<ChargerPort, std::true_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>
, QtPrivate::TypeAndForceComplete<void, std::false_type>
, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<bool, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<bool, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QVariantMap &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>

>,
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
        if (_id < 19)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 19;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 19)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 19;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
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
void ChargerPort::connectorChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void ChargerPort::batteryPercentChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void ChargerPort::energyDeliveredChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}

// SIGNAL 4
void ChargerPort::elapsedSecondsChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void ChargerPort::currentPowerChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void ChargerPort::sessionStarted(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void ChargerPort::sessionEnded(const QString & _t1, double _t2, double _t3, double _t4, double _t5, double _t6, const QString & _t7, int _t8, double _t9)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t4))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t5))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t6))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t7))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t8))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t9))) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void ChargerPort::authChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void ChargerPort::faultOccurred(const QString & _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 9, _a);
}
struct qt_meta_stringdata_OCPPManager_t {
    const uint offsetsAndSize[60];
    char stringdata0[402];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_OCPPManager_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_OCPPManager_t qt_meta_stringdata_OCPPManager = {
    {
QT_MOC_LITERAL(0, 11), // "OCPPManager"
QT_MOC_LITERAL(12, 17), // "connectionChanged"
QT_MOC_LITERAL(30, 0), // ""
QT_MOC_LITERAL(31, 19), // "authorizationResult"
QT_MOC_LITERAL(51, 8), // "accepted"
QT_MOC_LITERAL(60, 5), // "idTag"
QT_MOC_LITERAL(66, 19), // "meterValuesReceived"
QT_MOC_LITERAL(86, 11), // "connectorId"
QT_MOC_LITERAL(98, 6), // "values"
QT_MOC_LITERAL(105, 18), // "transactionStarted"
QT_MOC_LITERAL(124, 13), // "transactionId"
QT_MOC_LITERAL(138, 18), // "transactionStopped"
QT_MOC_LITERAL(157, 22), // "sendStatusNotification"
QT_MOC_LITERAL(180, 6), // "status"
QT_MOC_LITERAL(187, 15), // "sendMeterValues"
QT_MOC_LITERAL(203, 6), // "energy"
QT_MOC_LITERAL(210, 5), // "power"
QT_MOC_LITERAL(216, 9), // "authorize"
QT_MOC_LITERAL(226, 18), // "simulateDisconnect"
QT_MOC_LITERAL(245, 9), // "reconnect"
QT_MOC_LITERAL(255, 20), // "sendAuthorizeRequest"
QT_MOC_LITERAL(276, 20), // "sendStartTransaction"
QT_MOC_LITERAL(297, 19), // "sendStopTransaction"
QT_MOC_LITERAL(317, 9), // "meterStop"
QT_MOC_LITERAL(327, 9), // "connected"
QT_MOC_LITERAL(337, 7), // "csmsUrl"
QT_MOC_LITERAL(345, 11), // "chargeBoxId"
QT_MOC_LITERAL(357, 8), // "protocol"
QT_MOC_LITERAL(366, 17), // "heartbeatInterval"
QT_MOC_LITERAL(384, 17) // "reconnectAttempts"

    },
    "OCPPManager\0connectionChanged\0\0"
    "authorizationResult\0accepted\0idTag\0"
    "meterValuesReceived\0connectorId\0values\0"
    "transactionStarted\0transactionId\0"
    "transactionStopped\0sendStatusNotification\0"
    "status\0sendMeterValues\0energy\0power\0"
    "authorize\0simulateDisconnect\0reconnect\0"
    "sendAuthorizeRequest\0sendStartTransaction\0"
    "sendStopTransaction\0meterStop\0connected\0"
    "csmsUrl\0chargeBoxId\0protocol\0"
    "heartbeatInterval\0reconnectAttempts"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_OCPPManager[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       6,  139, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   92,    2, 0x06,    7 /* Public */,
       3,    2,   93,    2, 0x06,    8 /* Public */,
       6,    2,   98,    2, 0x06,   11 /* Public */,
       9,    2,  103,    2, 0x06,   14 /* Public */,
      11,    1,  108,    2, 0x06,   17 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      12,    2,  111,    2, 0x02,   19 /* Public */,
      14,    3,  116,    2, 0x02,   22 /* Public */,
      17,    1,  123,    2, 0x02,   26 /* Public */,
      18,    0,  126,    2, 0x02,   28 /* Public */,
      19,    0,  127,    2, 0x02,   29 /* Public */,
      20,    1,  128,    2, 0x02,   30 /* Public */,
      21,    1,  131,    2, 0x02,   32 /* Public */,
      22,    2,  134,    2, 0x02,   34 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Bool, QMetaType::QString,    4,    5,
    QMetaType::Void, QMetaType::Int, QMetaType::QJsonObject,    7,    8,
    QMetaType::Void, QMetaType::Int, QMetaType::QString,    7,   10,
    QMetaType::Void, QMetaType::Int,   10,

 // methods: parameters
    QMetaType::Void, QMetaType::Int, QMetaType::QString,    7,   13,
    QMetaType::Void, QMetaType::Int, QMetaType::Double, QMetaType::Double,    7,   15,   16,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    5,
    QMetaType::Void, QMetaType::Int,    7,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,   10,   23,

 // properties: name, type, flags
      24, QMetaType::Bool, 0x00015001, uint(0), 0,
      25, QMetaType::QString, 0x00015401, uint(-1), 0,
      26, QMetaType::QString, 0x00015401, uint(-1), 0,
      27, QMetaType::QString, 0x00015401, uint(-1), 0,
      28, QMetaType::Int, 0x00015401, uint(-1), 0,
      29, QMetaType::Int, 0x00015001, uint(0), 0,

       0        // eod
};

void OCPPManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<OCPPManager *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->connectionChanged(); break;
        case 1: _t->authorizationResult((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 2: _t->meterValuesReceived((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QJsonObject>>(_a[2]))); break;
        case 3: _t->transactionStarted((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 4: _t->transactionStopped((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 5: _t->sendStatusNotification((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2]))); break;
        case 6: _t->sendMeterValues((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3]))); break;
        case 7: _t->authorize((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 8: _t->simulateDisconnect(); break;
        case 9: _t->reconnect(); break;
        case 10: _t->sendAuthorizeRequest((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 11: _t->sendStartTransaction((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 12: _t->sendStopTransaction((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (OCPPManager::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&OCPPManager::connectionChanged)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (OCPPManager::*)(bool , const QString & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&OCPPManager::authorizationResult)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (OCPPManager::*)(int , const QJsonObject & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&OCPPManager::meterValuesReceived)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (OCPPManager::*)(int , const QString & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&OCPPManager::transactionStarted)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (OCPPManager::*)(int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&OCPPManager::transactionStopped)) {
                *result = 4;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<OCPPManager *>(_o);
        (void)_t;
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< bool*>(_v) = _t->connected(); break;
        case 1: *reinterpret_cast< QString*>(_v) = _t->csmsUrl(); break;
        case 2: *reinterpret_cast< QString*>(_v) = _t->chargeBoxId(); break;
        case 3: *reinterpret_cast< QString*>(_v) = _t->protocol(); break;
        case 4: *reinterpret_cast< int*>(_v) = _t->heartbeatInterval(); break;
        case 5: *reinterpret_cast< int*>(_v) = _t->reconnectAttempts(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject OCPPManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_OCPPManager.offsetsAndSize,
    qt_meta_data_OCPPManager,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_OCPPManager_t
, QtPrivate::TypeAndForceComplete<bool, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<int, std::true_type>, QtPrivate::TypeAndForceComplete<int, std::true_type>, QtPrivate::TypeAndForceComplete<OCPPManager, std::true_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<bool, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<const QJsonObject &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>

, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>

>,
    nullptr
} };


const QMetaObject *OCPPManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *OCPPManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_OCPPManager.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int OCPPManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 13)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 13;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void OCPPManager::connectionChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void OCPPManager::authorizationResult(bool _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void OCPPManager::meterValuesReceived(int _t1, const QJsonObject & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void OCPPManager::transactionStarted(int _t1, const QString & _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void OCPPManager::transactionStopped(int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 4, _a);
}
struct qt_meta_stringdata_ChargerBackend_t {
    const uint offsetsAndSize[72];
    char stringdata0[408];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(offsetof(qt_meta_stringdata_ChargerBackend_t, stringdata0) + ofs), len 
static const qt_meta_stringdata_ChargerBackend_t qt_meta_stringdata_ChargerBackend = {
    {
QT_MOC_LITERAL(0, 14), // "ChargerBackend"
QT_MOC_LITERAL(15, 18), // "currentTimeChanged"
QT_MOC_LITERAL(34, 0), // ""
QT_MOC_LITERAL(35, 20), // "ocppConnectedChanged"
QT_MOC_LITERAL(56, 21), // "sessionHistoryChanged"
QT_MOC_LITERAL(78, 18), // "onPortSessionEnded"
QT_MOC_LITERAL(97, 8), // "portName"
QT_MOC_LITERAL(106, 9), // "sessionId"
QT_MOC_LITERAL(116, 6), // "energy"
QT_MOC_LITERAL(123, 4), // "cost"
QT_MOC_LITERAL(128, 8), // "avgPower"
QT_MOC_LITERAL(137, 8), // "startSoc"
QT_MOC_LITERAL(146, 6), // "endSoc"
QT_MOC_LITERAL(153, 6), // "status"
QT_MOC_LITERAL(160, 8), // "duration"
QT_MOC_LITERAL(169, 6), // "maxPwr"
QT_MOC_LITERAL(176, 12), // "stopCharging"
QT_MOC_LITERAL(189, 4), // "port"
QT_MOC_LITERAL(194, 19), // "startChargingOnPort"
QT_MOC_LITERAL(214, 16), // "authenticatePort"
QT_MOC_LITERAL(231, 6), // "method"
QT_MOC_LITERAL(238, 4), // "cred"
QT_MOC_LITERAL(243, 11), // "currentTime"
QT_MOC_LITERAL(255, 11), // "currentDate"
QT_MOC_LITERAL(267, 13), // "ocppConnected"
QT_MOC_LITERAL(281, 5), // "portA"
QT_MOC_LITERAL(287, 12), // "ChargerPort*"
QT_MOC_LITERAL(300, 5), // "portB"
QT_MOC_LITERAL(306, 4), // "ocpp"
QT_MOC_LITERAL(311, 12), // "OCPPManager*"
QT_MOC_LITERAL(324, 11), // "stationInfo"
QT_MOC_LITERAL(336, 14), // "sessionHistory"
QT_MOC_LITERAL(351, 12), // "todayHistory"
QT_MOC_LITERAL(364, 16), // "totalEnergyToday"
QT_MOC_LITERAL(381, 13), // "sessionsToday"
QT_MOC_LITERAL(395, 12) // "revenueToday"

    },
    "ChargerBackend\0currentTimeChanged\0\0"
    "ocppConnectedChanged\0sessionHistoryChanged\0"
    "onPortSessionEnded\0portName\0sessionId\0"
    "energy\0cost\0avgPower\0startSoc\0endSoc\0"
    "status\0duration\0maxPwr\0stopCharging\0"
    "port\0startChargingOnPort\0authenticatePort\0"
    "method\0cred\0currentTime\0currentDate\0"
    "ocppConnected\0portA\0ChargerPort*\0portB\0"
    "ocpp\0OCPPManager*\0stationInfo\0"
    "sessionHistory\0todayHistory\0"
    "totalEnergyToday\0sessionsToday\0"
    "revenueToday"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ChargerBackend[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
      12,   93, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    0,   56,    2, 0x06,   13 /* Public */,
       3,    0,   57,    2, 0x06,   14 /* Public */,
       4,    0,   58,    2, 0x06,   15 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       5,   10,   59,    2, 0x0a,   16 /* Public */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
      16,    1,   80,    2, 0x02,   27 /* Public */,
      18,    1,   83,    2, 0x02,   29 /* Public */,
      19,    3,   86,    2, 0x02,   31 /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::QString, QMetaType::Int, QMetaType::Double,    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,   17,
    QMetaType::Void, QMetaType::QString,   17,
    QMetaType::Void, QMetaType::QString, QMetaType::Int, QMetaType::QString,   17,   20,   21,

 // properties: name, type, flags
      22, QMetaType::QString, 0x00015001, uint(0), 0,
      23, QMetaType::QString, 0x00015001, uint(0), 0,
      24, QMetaType::Bool, 0x00015001, uint(1), 0,
      25, 0x80000000 | 26, 0x00015409, uint(-1), 0,
      27, 0x80000000 | 26, 0x00015409, uint(-1), 0,
      28, 0x80000000 | 29, 0x00015409, uint(-1), 0,
      30, QMetaType::QVariantMap, 0x00015401, uint(-1), 0,
      31, QMetaType::QVariantList, 0x00015001, uint(2), 0,
      32, QMetaType::QVariantList, 0x00015001, uint(2), 0,
      33, QMetaType::Double, 0x00015001, uint(2), 0,
      34, QMetaType::Int, 0x00015001, uint(2), 0,
      35, QMetaType::Double, 0x00015001, uint(2), 0,

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
        case 2: _t->sessionHistoryChanged(); break;
        case 3: _t->onPortSessionEnded((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[6])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[7])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[8])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[9])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[10]))); break;
        case 4: _t->stopCharging((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 5: _t->startChargingOnPort((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 6: _t->authenticatePort((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[3]))); break;
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
        {
            using _t = void (ChargerBackend::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ChargerBackend::sessionHistoryChanged)) {
                *result = 2;
                return;
            }
        }
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 4:
        case 3:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< ChargerPort* >(); break;
        case 5:
            *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< OCPPManager* >(); break;
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
        case 5: *reinterpret_cast< OCPPManager**>(_v) = _t->ocpp(); break;
        case 6: *reinterpret_cast< QVariantMap*>(_v) = _t->stationInfo(); break;
        case 7: *reinterpret_cast< QVariantList*>(_v) = _t->sessionHistory(); break;
        case 8: *reinterpret_cast< QVariantList*>(_v) = _t->todayHistory(); break;
        case 9: *reinterpret_cast< double*>(_v) = _t->totalEnergyToday(); break;
        case 10: *reinterpret_cast< int*>(_v) = _t->sessionsToday(); break;
        case 11: *reinterpret_cast< double*>(_v) = _t->revenueToday(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
    } else if (_c == QMetaObject::ResetProperty) {
    } else if (_c == QMetaObject::BindableProperty) {
    }
#endif // QT_NO_PROPERTIES
}

const QMetaObject ChargerBackend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ChargerBackend.offsetsAndSize,
    qt_meta_data_ChargerBackend,
    qt_static_metacall,
    nullptr,
qt_incomplete_metaTypeArray<qt_meta_stringdata_ChargerBackend_t
, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<QString, std::true_type>, QtPrivate::TypeAndForceComplete<bool, std::true_type>, QtPrivate::TypeAndForceComplete<ChargerPort*, std::true_type>, QtPrivate::TypeAndForceComplete<ChargerPort*, std::true_type>, QtPrivate::TypeAndForceComplete<OCPPManager*, std::true_type>, QtPrivate::TypeAndForceComplete<QVariantMap, std::true_type>, QtPrivate::TypeAndForceComplete<QVariantList, std::true_type>, QtPrivate::TypeAndForceComplete<QVariantList, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<int, std::true_type>, QtPrivate::TypeAndForceComplete<double, std::true_type>, QtPrivate::TypeAndForceComplete<ChargerBackend, std::true_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>
, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<double, std::false_type>
, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<void, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>, QtPrivate::TypeAndForceComplete<int, std::false_type>, QtPrivate::TypeAndForceComplete<const QString &, std::false_type>

>,
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
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 7;
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 12;
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

// SIGNAL 2
void ChargerBackend::sessionHistoryChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE

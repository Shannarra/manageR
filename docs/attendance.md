# Attendances

Attendances are being taken based on the [class](./classes.md).

Attendances are represented via the following attributes:

Attribute | Meaning |
| --- | --- |
**attendance_type** | One of the attendance types listed below |
**teacher** | The teacher taking the attendance |
**student** | The student the attendance is being taken for |
**i_class** | The class for which attendance is being taken for |
**partial** | Is the attendance partial? Used for multi-step taking attendance of a whole class |

### Attendance types
Type | Usage
| --- | --- |
present | The student is present |
absent | The student is absent |
unknown | An unknown attendance, used to denote invalid data, not visible to end-users |

## Access
All access to attendances are subject to the rules described in the [authorization](./users/authorization.md) document.

An user will be able to access attendances via the `/attendances/` url if they have the correct access rights (are a teacher or higher). They will be able to take attendance on a single user, or a class.

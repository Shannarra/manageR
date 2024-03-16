# Authentication in manageR

Basic authentication in the project is handled via the gem Devise.

It provides structured a very easy and structured way of creating, scaling and modifying different authentication managements (called `devises`) for different needs.

## Basic User overview
A `User` is being represented via the following attributes *

Attribute | Meaning
--- | --- |
**email** | self-explanatory |
**name** | self-explanatory |
**gender** | self-explanatory |
**phone** | self-explanatory |
**image** | A profile picture for the user |
**access_type** | See table below for more info |
**institution_code** | The code for the User's institution. Used for verification of the profile. |
**bio** | A "tell me about yourself", short bio for personal profile. |

### Access types
Decides what access does the user have, allowing or disallowing them from seeing specific pages or flows.
Can be one of the following:

Type | Access
--- | --- |
admin | An administrator. Can manage Users, institutions and classes, delete reports, etc. Has [Admin profile](./admin.md) |
director | A director of an institution. Can do almost everything an admin can, but does not see/access anything outside their institution and does not have an admin profile. |
teacher | A teacher within the institution. Can grade, add/delete subjects, etc. Can only create subjects, grades and exams. |
student | A student within the institution. Can edit only their own profile and see content related to it. |
unassigned | Used as a default stub. No user should be having this access type when used in reality, a sign on bad data or invalid user.|

> \* Some of the attributes have been omitted for clarity.

## Profiles and registrations
User profiles can be created my administrators or directors.

User **registrations have been _disabled_** for _all_ users. Reason being the business logic of the application:
A user should not be able to register off their own volition, as their profile is constraint based on the [Institution](../institution.md) they are a part of. This means that in order to register a user must know information for the institution they are a part of, which will not be accessible without them already having a profile.

Therefore, a user's profile can be accessed by logging in or created via the user management admin tab or [mass user imports](../future_development.md).

The first time a user logs in they will be asked to verify their profile by entering the code for their institution. In a real environment the institution code, will be sent to them, as well as a basic password set on their account that they can change however they please.

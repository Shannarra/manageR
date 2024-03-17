# Institutions
Institutions are a very simple concept in `manageR`.

They are basically represented by the following fields:

Attribute | Meaning
-- | -- |
**name** | The institution's name |
**location** | The institution's location |
**code** | A unique 20-symbol random code that the institution uses for user verification. |

## Usage
Each `Institution` object represents a different physical institution.

It has its own users, classes and corresponding subjects (collected through the classses). This means that a teacher in institution X would not be able to see classes, students and subjects for institution Y and vice versa.

There is a case in which a user will be able to access all classes, subjects, instututions and users however, and it is when the user is an `admin`, for more info see [admin docs](./users/admin.md). This is done simply for convenience, if you just want to look up some info without having to go to the admin panel.

## Access
All access to institutions and the information, constraint to them are subject to the rules described in the [authorization](./users/authorization.md) document.

Normally a user will be able to access only their own institution via the `/institutions` url, but an admin can access all others via the `administration` dropdown in the url or the admin panel.

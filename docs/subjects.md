# Subjects
Subjects in `manageR` are represented with the `Subject` class.

Subjects are represented via the following attributes:

Attribute | Meaning |
--- | --- |
**name** | The name of the subject |
**year** | The year the subject is being thaught |
**description** | A decription of the subject |

Subjects are constraint to the [iclass](./classes.md) they belong to.
They also have a property called `user`, this is the user that is responsible for the subject (the teacher leading it).
For now, all users that are a part of a class are a partaking into the classes' subjects as well. Subject enrollment is part of the plans for [future development](./future_development.md).

## Access
All access to subjects and the information, constraint to them are subject to the rules described in the [authorization](./users/authorization.md) document.

Subjects are scoped to the class they are a part of, so for example, let's say we're part of institution with id = 56, and a class with id = 83, the way to access the classes' subjects would be `institutions/1/classes/1/subjects/`, the page will display all subjects related to the class. If you would want to see a specific subject, you can go to `institutions/:institution_id/classes/:class_id/subjects/:subject_id`.

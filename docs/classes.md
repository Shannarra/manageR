# Classes
Classes in `manageR` are represented with the `IClass` class and will be referred to as "iclasses" (short form of "institution classes") from here on now.

Iclassess are represented via the following attributes:
Attribute | Meaning |
--- | --- |
**name** | The name of the class |
**year** | The year the class is being thought. |
**description** | An overall description of the class. |

## Usage
Each `IClass` object represents a different class within the current user's institution.

An iclass can contain many subjects, with exams and grades collected through those.

## Access
All access to classes and the information, constraint to them are subject to the rules described in the [authorization](./users/authorization.md) document.

IClasses are scoped to the institution they are a part of, so for example, let's say we're part of institution with id = 56, the way to access the institution's classes would be `institutions/56/`, the page will display all classes related to the institution. If you would want to see a specific class, you can go to `institutions/:institution_id/classes/:class_id`.

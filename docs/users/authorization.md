# Authorization in manageR

Authorization is defined as the process of giving someone permission to have access to something.

This definition fully describes what authorization means in the context of the `manageR` application - the process and tools used to allow/deny access of certain users to certain pages.

## Technical overview
All authorization has been done via a gem called [Pundit](https://github.com/varvet/pundit) (hilariously meaning A pundit a learned person who offers opinion in an authoritative manner on a particular subject area ([Wikipedia](https://en.wikipedia.org/wiki/Pundit))).

The decision to use Pundit came from the fact that it is a very simple library that provides minimal authorization through OO design and pure Ruby classes (Pundit Git description). This means that it suites the needs of the project perfectly, as the aim is to create a simple management system for users and developers alike.

Furthermore, the decision to use it over other gems like [CanCan](https://github.com/ryanb/cancan) came from the fact that Pundit is still in active development/support, with thriving community behind it and, most importantly - Pundit allows you to specify authorizations (called `policies`) for specific models/controllers as they are needed in their own separate files. The same mechanism in CanCan for example requires you to do it all in a single file (comically being called a "Bible file"), which leads to large and hard to read (and understand) code files in the application.

## Authorization levels and user accesses
By default, any action is __disallowed__ for any controller.
This means that for any `policy` created all actions are disallowed unless specifically overwritten and allowed via a certain condition.

### Policies
There are a couple of policies defined:

**`attendances`**
**`exams`**
**`grades`**
**`institution classes`**
**`institutions`**
**`subjects`**
**`users`**

They describe the access to each action in the controller with the same name based on the current user logged in and the record that the user is trying to access.

For further information on a specific policy you can always check [the policies folder](../../app/policies/).
Each method ending with a `?` (e.g. `index?`, `show?`, etc.) is essentially a predicate that allows or disallows the
access to the given method witin the described controller.

### Authorization levels
There are 3 main authorization levels:

1. Elevated privileges
Basically an `admin` or `director` user (see [user access types](./authentication.md) for more info).
Able to access any information.
2. Grader
A User that can grade other users.
Usually a teacher, but can also be a director or admin.
Able to create/edit grades, exams, attendances, subjects.
3. Basic user
Usually a student.
Able to access their own grades and profile, subjects and exams that have been assigned to them only.

# Exams

Exams in `manageR` are represented via the `Exam` class and are constricted to a specific subject.
Exams are represented via the following attributes:

Attribute | Meaning |
--- | --- |
**exam_type** | Either "online" or "physical" |
**schedule** | A schedule for when the exam will be held. Must be at least 1 day in advance. |
**name** | A name for the exam |
**attachment** | An optional attachment if needed |
**subject** | The subject the exam is related to |
**user** | The teacher that created the exam |
**description** | A description for the exam |


## Access
All access to exams are subject to the rules described in the [authorization](./users/authorization.md) document.

An user will be able to access exams via the `/exams/` url.
They will be able to see a list of exams, constraint to the subjects in their institution.

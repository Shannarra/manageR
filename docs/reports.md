# Reports

From end-user perspective, reports are a name and fields from 3 select menus.

## Usage
When a user with sufficient authority goes to create a new report a new `Report` object gets created in the database. By default it is in the state of being `requested`.

The `Report` object is represented via the following fields:
Attribute | Meaning |
--- | --- |
**name** | The name of the report. This will create a report with this name.* |
**institution** | The institution for which the report will be creted. |
**by** | The user that requested the generation of the report. |
**creation_scope** | One of `creation scopes` bellow. |
**state** | One of `states` bellow. |
**format** | One of `formats` bellow. |

* \* if a name has not been provided, a default name for the file will be set. It follows the following convention: `report_[REPORT_DATE]_[CREATION_SCOPE]-[BY_USERNAME].[FORMAT]`

### creation scopes
Scope | Meaning
| --- | --- |
institution | Include all of the information for the institution, plus all the classes info. |
classes | Include all classes information + all within the subjects. |
subjects | Include everything up to subjects - attendances, exams, grades. |
unknown | An unknown scope, used to denote invalid data, and default state, not visible to users. |

### states
State | Meaning
| --- | --- |
completed | A completed, already generated report, ready for download. |
in progress | A report that is currently in the process of being generated. |
requested | A report that has been requested and waits to be picked up and start generating. |

### formats
Format | Meaning
| --- | --- |
pdf | The report is to be generated as a PDF file. |
json | The report is to be generated as a JSON file. |
csv | The report is to be generated as a CSV file. |

## I've requested it, so what next?
Once a `Report` has been requested, it will be picked up on the next scheduled reports creation.

By default, new report requests are being done once every ten minutes for ALL institutions.
Once a report is in processing, it may spend some time `in progress` depending on the format and scope.
When the report is done, it's state will automatically be changed to `completed` and the user will see a link, from which they will be able to download the newly generated file.

Report files will be kept for either limited or indefinite amount of time, depending on the settings and contract the institution has with the system (see [future development plans](./future_development.md) for more info).

## Generate a report locally
If you don't want to setup the crontab that runs the reports generation job, you can always run them locally via the following command:

```sh
docker compose run --rm web rake reports:run
```
This command will automatically run the report generation background worker on the spot for all newly requested reports.

## Access
All access to subjects and the information, constraint to them are subject to the rules described in the [authorization](./users/authorization.md) document.

Reports are scoped to the institution they are a part of. This means that If you would want to see a list of all reports for your institution, you can go to `institutions/:institution_name/reports/`.
Reports can be created and seen by users with `grader` privileges or higher.

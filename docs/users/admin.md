# Admin tab and functionalities

Admin tab has been created using a gem called [ActiveAdmin](https://github.com/activeadmin/activeadmin).

## Access
One can try to access the admin tab by accessing the `/admin` endpoint on the application.
Upon reaching it, the user will be asked to enter their credentials in order to access the administration tab.
> Note that ActiveAdmin uses Devise internally (as mentioned in [authentication](./authentication.md))
> meaning that there is a separate `devise` for normal users and `AdminUser`s.

Users with `admin` access type will be granted an `AdminUser` account, allowing them to access the administration
tab after contacting the tech administrators.
> This can also be done authomatically via scheduled/delayed jobs in the background, but is not a good idea.

## Functionalities
Using the admin pages, the admin users can do a lot of stuff that normal users can not:
1. Creating/Editing `Institution`s
2. Creating/Editing `GradingSystem`s (more info on those can be found [here](../grading.md))
3. Creating/Editing `AdminUser`s and normal `User`s
4. Creating/Editing `User` profiles
5. Generating exports for __*ALL*__ tabs, containing serious amount of information.

As one can see, access to those pages can lead to very serious issues if given to the wrong people.
This is why administrator access is to be given only to a select few people that will play a role as a technical support team.

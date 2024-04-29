# First time logging in manageR

The first time you log in, you will be asked to provide the security code of your institution. 
It consists of 20-digit alphanumeric string that the institution provides to the users. The code is different for each institution.

Let's say you want to log in as the admin to the system, you can do that by navigating to http://localhost:3000/users/sign_in and providing the following credentials:
Credential | Value
--|--
Email | "admin@example.com"
Password | 123456

![login](https://github.com/Shannarra/manageR/assets/26832131/42cf1b0f-fee3-44da-b878-644feb8f844a)

Once you log in you will be greeted by the "Verify your institution" screen. You will need to enter the institution's code and your profile's password to verify your user.
![verify](https://github.com/Shannarra/manageR/assets/26832131/0ce7e8c5-ccda-4846-8ea0-3ddf00cb3816)

##### Getting the code
Code will be sent via email in a real environment, but for the purpose of development, you can directly check for the code of the current user's institution in the database via the following command:

```console
docker compose run --rm web rails c
```

And inside the prompt, enter the following:
```ruby
User.where(email: "admin@example.com").first.institution.code
```
You will get an output similar to this one:
```
  User Load (1.2ms)  SELECT "users".* FROM "users" WHERE "users"."email" = $1 ORDER BY "users"."id" ASC LIMIT $2  [["email", "admin@example.com"], ["LIMIT", 1]]
  Institution Load (0.4ms)  SELECT "institutions".* FROM "institutions" WHERE "institutions"."id" = $1 LIMIT $2  [["id", 1], ["LIMIT", 1]]
=> "LR9dWXG7Q0jYft6NsiZq"
```
![code](https://github.com/Shannarra/manageR/assets/26832131/7970cc2c-aa51-40a2-a8ab-8b7f25fd830b)

See that last piece of string? This is the institution's code!
We can now copy it and paste it into the verification form.

![confirmed](https://github.com/Shannarra/manageR/assets/26832131/3850b279-5d61-433f-9cee-5f413c6fc8a4)

And that's it, you have been verified! Your admin user now has a free reign over the entire system!

All of this is required only once. When the user gets verified, the system will never ask for the institution code again and you can freely access the system.

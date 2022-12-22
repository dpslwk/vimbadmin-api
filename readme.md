# ViMbAdimn API

This is a quick and dirty Lumen base API for the ViMbAdmin database

ViMbAdminis a web based virtual mailbox administration system for dovecote and posftix

The down side of ViMdAdmin is that it has no APi front end and at Nottingham Hackspace we needed to change our mailbox aliase from the Hackspace Mangment System (HMS) as the systems run on two diffrent server this quick REST api was thrown together for comsumption by HMS 2.0.

* http://www.vimbadmin.net 
* http://nottinghack.org.uk
* https://github.com/NottingHack/hms2

# Setup Notes

Two database conections are used, first to the app's own DB (this looks after the API oauth stuff), second to the ViMbAdmin DB, details for both need to be defined in the .env file as below.
Along with the location to the ViMbAdmin aplliction config file

```
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=vimbadmin-api
DB_USERNAME=homestead
DB_PASSWORD=secret

VBA_CONNECTION=mysql
VBA_HOST=127.0.0.1
VBA_PORT=3306
VBA_DATABASE=mailserver
VBA_USERNAME=homestead
VBA_PASSWORD=secret

VBA_CONFIG_FILE=../../vimbadmin/application/configs/application.ini
```

Create a new set of client credentials with
`php artisan passport:client --personal`
This will give you a `Client ID` & `Client Secret` these will be need by your client

Use the ID and Secret to request a `client_credentials` grant_type
http://vimbadmin-api.dev/oauth/token

Scopes not yet implmented


## License

This project is open-sourced software licensed under the MIT license

The Lumen framework is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)

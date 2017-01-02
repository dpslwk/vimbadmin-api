# ViMbAdimn API

This is a quick and dirty Lumen base API for the ViMbAdmin database

ViMbAdminis a web based virtual mailbox administration system for dovecote and posftix

The down side of ViMdAdmin is that it has no APi front end and at Nottingham Hackspace we needed to change our mailbox aliase from the Hackspace Mangment System (HMS) as the systems run on two diffrent server this quick REST api was thrown together for comsumption by HMS 2.0.

* http://www.vimbadmin.net 
* http://nottinghack.org.uk
* https://github.com/NottingHack/hms2

# Setup Notes

Two database conections are used, first to the app's own DB (this looks after the API oauth stuff), second to the ViMbAdmin DB, details for both need to be defined in the .env file as below

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
```


# Lumen PHP Framework

[![Build Status](https://travis-ci.org/laravel/lumen-framework.svg)](https://travis-ci.org/laravel/lumen-framework)
[![Total Downloads](https://poser.pugx.org/laravel/lumen-framework/d/total.svg)](https://packagist.org/packages/laravel/lumen-framework)
[![Latest Stable Version](https://poser.pugx.org/laravel/lumen-framework/v/stable.svg)](https://packagist.org/packages/laravel/lumen-framework)
[![Latest Unstable Version](https://poser.pugx.org/laravel/lumen-framework/v/unstable.svg)](https://packagist.org/packages/laravel/lumen-framework)
[![License](https://poser.pugx.org/laravel/lumen-framework/license.svg)](https://packagist.org/packages/laravel/lumen-framework)

Laravel Lumen is a stunningly fast PHP micro-framework for building web applications with expressive, elegant syntax. We believe development must be an enjoyable, creative experience to be truly fulfilling. Lumen attempts to take the pain out of development by easing common tasks used in the majority of web projects, such as routing, database abstraction, queueing, and caching.

## Official Documentation

Documentation for the framework can be found on the [Lumen website](http://lumen.laravel.com/docs).

## Security Vulnerabilities

If you discover a security vulnerability within Laravel, please send an e-mail to Taylor Otwell at taylor@laravel.com. All security vulnerabilities will be promptly addressed.

## License

The Lumen framework is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)

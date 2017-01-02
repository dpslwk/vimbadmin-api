<?php


/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$app->get('/', function () use ($app) {
    return $app->version();
});

$app->group([], function () use ($app){

    $app->get('domains', [
        'uses' => 'DomainController@index',
        'as' => 'domains.index'
    ]);
    $app->get('domains/{domain}', [
        'uses' => 'DomainController@show',
        'as' => 'domains.show'
    ]);

    // Mailboxes
    $app->get('{domainName}/mailboxes/', [
        'uses' => 'MailboxController@index',
        'as' => 'mailboxes.index'
    ]);
    $app->get('{domainName}/mailboxes/{mailbox}', [
        'uses' => 'MailboxController@show',
        'as' => 'mailboxes.show'
    ]);
    $app->post('{domainName}/mailboxes/{mailbox}', [
        'uses' => 'MailboxController@store',
        'as' => 'mailboxes.store'
    ]);
    $app->put('{domainName}/mailboxes/{mailbox}', [
        'uses' => 'MailboxController@update',
        'as' => 'mailboxes.update'
    ]);
    $app->patch('{domainName}/mailboxes/{mailbox}', [
        'uses' => 'MailboxController@update',
        'as' => 'mailboxes.update'
    ]);

    // Aliases
    $app->get('{domainName}/aliases/', [
        'uses' => 'AliasController@index',
        'as' => 'aliases.index'
    ]);
    $app->get('{domainName}/aliases/{alias}', [
        'uses' => 'AliasController@show',
        'as' => 'aliases.show'
    ]);
    $app->post('{domainName}/aliases/', [
        'uses' => 'AliasController@store',
        'as' => 'aliases.store'
    ]);
    $app->patch('{domainName}/aliases/{alias}', [
        'uses' => 'AliasController@update',
        'as' => 'aliases.update'
    ]);

});
<?php

/** @var \Laravel\Lumen\Routing\Router $router */

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

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->group(['middleware' => 'client_credentials'], function () use ($router) {
    $router->get('domains', [
        'uses' => 'DomainController@index',
        'as'   => 'domains.index',
    ]);
    $router->get('domains/{domain}', [
        'uses' => 'DomainController@show',
        'as'   => 'domains.show',
    ]);
    $router->get('domains/{domain}/mailboxes', [
        'uses' => 'MailboxController@showForDomain',
        'as'   => 'domain.mailboxes',
    ]);
    $router->get('domains/{domain}/relationships/mailboxes', [
        'uses' => 'MailboxController@showRelationships',
        'as'   => 'domains.relationships.mailboxes',
    ]);
    $router->get('domains/{domain}/aliases', [
        'uses' => 'AliasController@showForDomain',
        'as'   => 'domain.aliases',
    ]);
    $router->get('domains/{domain}/relationships/aliases', [
        'uses' => 'AliasController@showRelationships',
        'as'   => 'domains.relationships.aliases',
    ]);

    // Mailboxes
    $router->get('{domainName}/mailboxes/', [
        'uses' => 'MailboxController@index',
        'as'   => 'mailboxes.index',
    ]);
    $router->get('{domainName}/mailboxes/{mailbox}', [
        'uses' => 'MailboxController@show',
        'as'   => 'mailboxes.show',
    ]);
    $router->post('{domainName}/mailboxes/', [
        'uses' => 'MailboxController@store',
        'as'   => 'mailboxes.store',
    ]);
    $router->patch('{domainName}/mailboxes/{mailbox}', [
        'uses' => 'MailboxController@update',
        'as'   => 'mailboxes.update',
    ]);
    $router->get('{domainName}/mailboxes/{mailbox}/domain', [
        'uses' => 'DomainController@showForMailbox',
        'as'   => 'mailbox.domain',
    ]);
    $router->get('{domainName}/mailboxes/{mailbox}/relationships/domain', [
        'uses' => 'DomainController@showMailboxRelationships',
        'as'   => 'mailboxes.relationships.domain',
    ]);

    // Aliases
    $router->get('{domainName}/aliases/', [
        'uses' => 'AliasController@index',
        'as'   => 'aliases.index',
    ]);
    $router->get('{domainName}/aliases/{alias}', [
        'uses' => 'AliasController@show',
        'as'   => 'aliases.show',
    ]);
    $router->post('{domainName}/aliases/', [
        'uses' => 'AliasController@store',
        'as'   => 'aliases.store',
    ]);
    $router->patch('{domainName}/aliases/{alias}', [
        'uses' => 'AliasController@update',
        'as'   => 'aliases.update',
    ]);
    $router->get('{domainName}/aliases/{mailbox}/domain', [
        'uses' => 'DomainController@showForAlias',
        'as'   => 'aliases.domain',
    ]);
    $router->get('{domainName}/aliases/{alias}/relationships/domain', [
        'uses' => 'DomainController@showAliasRelationships',
        'as'   => 'aliases.relationships.domain',
    ]);
});

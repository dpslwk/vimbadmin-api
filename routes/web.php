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

$app->group(['middleware' => 'client_credentials'], function () use ($app) {
    $app->get('domains', [
        'uses' => 'DomainController@index',
        'as'   => 'domains.index',
    ]);
    $app->get('domains/{domain}', [
        'uses' => 'DomainController@show',
        'as'   => 'domains.show',
    ]);
    $app->get('domains/{domain}/mailboxes', [
        'uses' => 'MailboxController@showForDomain',
        'as'   => 'domain.mailboxes',
    ]);
    $app->get('domains/{domain}/relationships/mailboxes', [
        'uses' => 'MailboxController@showRelationships',
        'as'   => 'domains.relationships.mailboxes',
    ]);
    $app->get('domains/{domain}/aliases', [
        'uses' => 'AliasController@showForDomain',
        'as'   => 'domain.aliases',
    ]);
    $app->get('domains/{domain}/relationships/aliases', [
        'uses' => 'AliasController@showRelationships',
        'as'   => 'domains.relationships.aliases',
    ]);

    // Mailboxes
    $app->get('{domainName}/mailboxes/', [
        'uses' => 'MailboxController@index',
        'as'   => 'mailboxes.index',
    ]);
    $app->get('{domainName}/mailboxes/{mailbox}', [
        'uses' => 'MailboxController@show',
        'as'   => 'mailboxes.show',
    ]);
    $app->post('{domainName}/mailboxes/', [
        'uses' => 'MailboxController@store',
        'as'   => 'mailboxes.store',
    ]);
    $app->patch('{domainName}/mailboxes/{mailbox}', [
        'uses' => 'MailboxController@update',
        'as'   => 'mailboxes.update',
    ]);
    $app->get('{domainName}/mailboxes/{mailbox}/domain', [
        'uses' => 'DomainController@showForMailbox',
        'as'   => 'mailbox.domain',
    ]);
    $app->get('{domainName}/mailboxes/{mailbox}/relationships/domain', [
        'uses' => 'DomainController@showMailboxRelationships',
        'as'   => 'mailboxes.relationships.domain',
    ]);

    // Aliases
    $app->get('{domainName}/aliases/', [
        'uses' => 'AliasController@index',
        'as'   => 'aliases.index',
    ]);
    $app->get('{domainName}/aliases/{alias}', [
        'uses' => 'AliasController@show',
        'as'   => 'aliases.show',
    ]);
    $app->post('{domainName}/aliases/', [
        'uses' => 'AliasController@store',
        'as'   => 'aliases.store',
    ]);
    $app->patch('{domainName}/aliases/{alias}', [
        'uses' => 'AliasController@update',
        'as'   => 'aliases.update',
    ]);
    $app->get('{domainName}/aliases/{mailbox}/domain', [
        'uses' => 'DomainController@showForAlias',
        'as'   => 'aliases.domain',
    ]);
    $app->get('{domainName}/aliases/{alias}/relationships/domain', [
        'uses' => 'DomainController@showAliasRelationships',
        'as'   => 'aliases.relationships.domain',
    ]);
});

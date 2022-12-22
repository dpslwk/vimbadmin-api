<?php

namespace App\Transformers;

use App\VbaModels\Domain;
use League\Fractal\TransformerAbstract;

class DomainTransformer extends TransformerAbstract
{
    /**
     * List of resources to automatically include.
     *
     * @var array
     */
    protected $defaultIncludes = [
        //
    ];

    /**
     * List of resources possible to include.
     *
     * @var array
     */
    protected $availableIncludes = [
        'mailboxes',
        'aliases',
    ];

    /**
     * defines how to transform the model.
     *
     * @param Domain $domain
     *
     * @return array
     */
    public function transform(Domain $domain)
    {
        return [
            'id'     => $domain->id,
            'domain' => $domain->domain,
        ];
    }

    /**
     * Include Mailboxes.
     *
     * @return League\Fractal\ItemResource
     */
    public function includeMailboxes(Domain $domain)
    {
        $mailboxes = $domain->mailboxes->all();

        return $this->collection($mailboxes, new MailboxTransformer(), 'mailboxes');
    }

    /**
     * Include Aliases.
     *
     * @return League\Fractal\ItemResource
     */
    public function includeAliases(Domain $domain)
    {
        $aliases = $domain->aliases->all();

        return $this->collection($aliases, new AliasTransformer(), 'aliases');
    }
}

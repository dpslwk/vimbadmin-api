<?php

namespace App\Transformers;

use App\VbaModels\Mailbox;
use League\Fractal\TransformerAbstract;

class MailboxTransformer extends TransformerAbstract
{
    /**
     * List of resources to always include.
     *
     * @var array
     */
    protected $defaultIncludes = [
        'domain',
    ];

    /**
     * List of resources possible to include
     *
     * @var array
     */
    protected $availableIncludes = [
        //
    ];

    /**
     * defines how to transform the model.
     *
     * @param Mailbox $domain
     *
     * @return array
     */
    public function transform(Mailbox $mailbox)
    {
        return [
            'id'       => $mailbox->id,
            'username' => $mailbox->username,
            'name'     => $mailbox->name,
        ];
    }

    /**
     * Include Domain.
     *
     * @return League\Fractal\ItemResource
     */
    public function includeDomain(Mailbox $mailbox)
    {
        $domain = $mailbox->domain;

        return $this->item($domain, new DomainTransformer(), 'domains');
    }
}

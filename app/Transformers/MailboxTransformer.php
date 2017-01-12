<?php namespace App\Transformers;

use App\VbaModels\Mailbox;
use App\Transformers\DomainTransformer;
use League\Fractal\Resource\Collection;
use League\Fractal\TransformerAbstract;

class MailboxTransformer extends TransformerAbstract
{

    /**
     * List of resources to always include.
     *
     * @var array
     */
    protected $defaultIncludes = [
        'domain'
    ];

    /**
     * defines how to transform the model.
     * @param  Mailbox $domain
     * @return array
     */
    public function transform(Mailbox $mailbox)
    {
        return [
            "id" => $mailbox->id,
            "username" => $mailbox->username,
            "name" => $mailbox->name,
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

        return $this->item($domain, new DomainTransformer, 'domains');
    }
}
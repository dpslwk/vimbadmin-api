<?php namespace App\Transformers;

use App\VbaModels\Domain;
use App\Transformers\AliasTransformer;
use App\Transformers\MailboxTransformer;
use League\Fractal\Resource\Collection;
use League\Fractal\TransformerAbstract;

class DomainTransformer extends TransformerAbstract {

    /**
     * List of resources possible to include
     *
     * @var array
     */
    protected $availableIncludes = [
        'mailboxes',
        'aliases'
    ];

    public function transform(Domain $domain)
    {
        return [
            'id' => $domain->id,
            'domain' => $domain->domain,
            'links'   => [
                [
                    'rel' => 'self',
                    'uri' => '/domains/'.$domain->id,
                ]
            ]
        ];
    }

    /**
     * Include Mailboxes
     *
     * @return League\Fractal\ItemResource
     */
    public function includeMailboxes(Domain $domain)
    {
        $mailboxes = $domain->mailboxes->all();

        return $this->collection($mailboxes, new MailboxTransformer, 'mailbox');
    }

    /**
     * Include Aliases
     *
     * @return League\Fractal\ItemResource
     */
    public function includeAliases(Domain $domain)
    {
        $aliases = $domain->aliases->all();

        return $this->collection($aliases, new AliasTransformer, 'alias');
    }

}
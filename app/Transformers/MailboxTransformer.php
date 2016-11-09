<?php namespace App\Transformers;

use App\VbaModels\Mailbox;
use App\Transformers\DomainTransformer;
use League\Fractal\Resource\Collection;
use League\Fractal\TransformerAbstract;

class MailboxTransformer extends TransformerAbstract {

    protected $defaultIncludes = [
        'domain'
    ];

    public function transform(Mailbox $mailbox)
    {
        return [
            "id" => $mailbox->id,
            "username" => $mailbox->username,
            "name" => $mailbox->name,
            'links'   => [
                [
                    'rel' => 'self',
                    'uri' => '/'.$mailbox->domain->domain.'/mailboxes/'.$mailbox->id,
                ]
            ]
        ];
    }

    public function includeDomain(Mailbox $mailbox)
    {

        $domain = $mailbox->domain;

        return $this->item($domain, new DomainTransformer, 'domain');
    }

}
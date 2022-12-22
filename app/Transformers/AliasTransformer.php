<?php

namespace App\Transformers;

use App\VbaModels\Alias;
use League\Fractal\TransformerAbstract;

class AliasTransformer extends TransformerAbstract
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
     * @param Alias $domain
     *
     * @return array
     */
    public function transform(Alias $alias)
    {
        return [
            'id'      => $alias->id,
            'address' => $alias->address,
            'goto'    => explode(',', $alias->goto),
        ];
    }

    /**
     * Include Domain.
     *
     * @return League\Fractal\ItemResource
     */
    public function includeDomain(Alias $alias)
    {
        $domain = $alias->domain;

        return $this->item($domain, new DomainTransformer(), 'domains');
    }
}

<?php namespace App\Transformers;

use App\VbaModels\Alias;
use App\Transformers\DomainTransformer;
use League\Fractal\Resource\Collection;
use League\Fractal\TransformerAbstract;

class AliasTransformer extends TransformerAbstract
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
     * @param  Alias $domain
     * @return array
     */
    public function transform(Alias $alias)
    {
        return [
            "id" => $alias->id,
            "address" => $alias->address,
            "goto" => explode(',', $alias->goto),
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
        
        return $this->item($domain, new DomainTransformer, 'domain');
    }
}
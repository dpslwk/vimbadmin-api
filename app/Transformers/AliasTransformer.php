<?php namespace App\Transformers;

use App\VbaModels\Alias;
use App\Transformers\DomainTransformer;
use League\Fractal\Resource\Collection;
use League\Fractal\TransformerAbstract;

class AliasTransformer extends TransformerAbstract {

    protected $defaultIncludes = [
        'domain'
    ];

    public function transform(Alias $alias)
    {
        return [
            "id" => $alias->id,
            "address" => $alias->address,
            "goto" => explode(',', $alias->goto),
        ];
    }

    public function includeDomain(Alias $alias)
    {
        $domain = $alias->domain;
        
        return $this->item($domain, new DomainTransformer);
    }

}
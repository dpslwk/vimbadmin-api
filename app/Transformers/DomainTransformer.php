<?php namespace App\Transformers;

use App\VbaModels\Domain;
use League\Fractal\Resource\Collection;
use League\Fractal\TransformerAbstract;

class DomainTransformer extends TransformerAbstract {

    public function transform(Domain $domain)
    {
        return [
            'id' => $domain->id,
            'domain' => $domain->domain,  
        ];
    }

}
<?php 

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use League\Fractal\Manager;
use League\Fractal\Resource\Item;
use League\Fractal\Resource\Collection;
use League\Fractal\TransformerAbstract;
use Illuminate\Http\Response as IlluminateResponse;

class ApiController extends Controller 
{
    
    protected $domain;
    protected $fractal;

    public function __construct(Domain $domain, Manager $fractal)
    {
        $this->domain = $domain;
        $this->fractal = $fractal;
    }

    /**
     * Helper to grab the domain object
     * 
     * @param  string $domainName
     * @return App\VbaModels\Domain
     */
    protected function getDomain($domainName)
    {
        return $this->domain->where('domain', $domainName)->first();
    }

    protected function transformCollection($items, TransformerAbstract $transformer)
    {
        $collection = new Collection($items, $transformer);

        return $this->fractal->createData($collection)->toArray();
    }
    
    protected function transformItem($item, TransformerAbstract $transformer)
    {
        $item = new Item($item, $transformer);

        return $this->fractal->createData($item)->toArray();
    }

    protected $statusCode = IlluminateResponse::HTTP_OK;

    public function getStatusCode()
    {
        return $this->statusCode;
    }

    public function setStatusCode($statusCode)
    {
        $this->statusCode = $statusCode;

        return $this;
    }

    public function respond($data, $headers = [])
    {
        return response()->json($data, $this->getStatusCode(), $headers);
    }

}
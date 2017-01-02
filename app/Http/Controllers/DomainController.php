<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use League\Fractal\Manager;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Transformers\DomainTransformer;

class DomainController extends ApiController
{
    /**
     * @var string Type to use with Transformer
     */
    protected $type = 'domains';

    /**
     * @param Domain            $domain
     * @param DomainTransformer $domainTransformer
     * @param Manager           $fractal
     */
    public function __construct(Domain $domain, DomainTransformer $domainTransformer, Manager $fractal)
    {
        parent::__construct($domain, $domainTransformer, $fractal);
    }
    
    /**
     * Display a listing all domains.
     * Or serach for one.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if ($request->has('include')) {
            $this->fractal->parseIncludes($request->input('include'));
            $this->domain->load($request->input('include'));
        }

        if ($request->input('q')) {
            $domains = $this->domain->where('domain', $request->input('q'))->get();
        } else {
            $domains = $this->domain->all();
        }

        $data = $this->transformCollection($domains);

        return $this->respond($data);
    }

    /**
     * Display the specified domain.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $domainId
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request, $domainId)
    {
        if ($request->has('include')) {
            $this->fractal->parseIncludes($request->input('include'));
            $this->domain->load($request->input('include'));
        }
        
        $domain = $this->domain->findOrFail($domainId);

        $data = $this->transformItem($domain);

        return $this->respond($data);
    }
}

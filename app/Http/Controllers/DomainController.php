<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use League\Fractal\Manager;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Transformers\DomainTransformer;

class DomainController extends ApiController
{

    protected $domainTransformer;

    public function __construct(Domain $domain, DomainTransformer $domainTransformer, Manager $fractal)
    {
        parent::__construct($domain, $fractal);
        $this->domainTransformer = $domainTransformer;
    }
    
    /**
     * Display a listing all domains.
     * Or serach for one.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if ($request->has('include')) {
            $this->fractal->parseIncludes($request->input('include'));
            // TODO: set eager loading
        }

        if ($request->input('q')) {
            $domains = $this->domain->where('domain', $request->input('q'))->get();
        } else {
            $domains = $this->domain->all();
        }

        $data = $this->transformCollection($domains, $this->domainTransformer, 'domain');

        return $this->respond($data);
    }

    /**
     * Display the specified domain.
     *
     * @param  int  $domainId
     * @return \Illuminate\Http\Response
     */
    public function show($domainId)
    {
        if ($request->has('include')) {
            $this->fractal->parseIncludes($request->input('include'));
            // TODO: set eager loading
        }
        
        $domain = $this->domain->findOrFail($domainId);

        $data = $this->transformItem($domain, $this->domainTransformer, 'domain');

        return $this->respond($data);
    }
}

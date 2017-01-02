<?php

namespace App\Http\Controllers;

use App\VbaModels\Alias;
use App\VbaModels\Domain;
use League\Fractal\Manager;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Transformers\AliasTransformer;

class AliasController extends ApiController
{
    /**
     * @var string Type to use with Transformer
     */
    protected $type = 'aliases';

    /**
     * @param Domain           $domain
     * @param AliasTransformer $aliasTransformer
     * @param Manager          $fractal
     */
    public function __construct(Domain $domain, AliasTransformer $aliasTransformer, Manager $fractal)
    {
        parent::__construct($domain, $aliasTransformer, $fractal);
    }

    /**
     * All aliases for domain.
     * or serach for a single alias in that domain.
     * 
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, $domainName)
    {
        $domain = $this->getDomain($domainName);
        if ($request->input('q')) {
            $aliases = $domain->aliases()->where('address', $request->input('q'))->with(['domain'])->get();
        } else {
            $aliases = $domain->aliases()->with(['domain'])->get();
        }
        $data = $this->transformCollection($aliases);

        return $this->respond($data);
    }

    /**
     * Store a newly created alias.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request, $domainName)
    {
        $domain = $this->getDomain($domainName);

        if ($request->isMethod('patch')) {
            // need to merge with request with existing record
        } elseif ($request->isMethod('put')) {
            // need to replace the existing record??
        }
    }

    /**
     * Display the specified alias.
     *
     * @param  int  $aliasId
     * @return \Illuminate\Http\Response
     */
    public function show($domainName, $aliasId)
    {
        $domain = $this->getDomain($domainName);
        $alias = $domain->aliases()->with(['domain'])->find($aliasId);
        $data = $this->transformItem($alias);

        return $this->respond($data);
    }

    /**
     * Update the specified alias.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $aliasId
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $domainName, $aliasId)
    {
        $domain = $this->getDomain($domainName);
    }

}
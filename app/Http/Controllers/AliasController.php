<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use App\VbaModels\Alias;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;


class AliasController extends Controller
{

    /**
     * Helper to grab the domain object
     * 
     * @param  string $domainName
     * @return App\VbaModels\Domain
     */
    protected function getDomain($domainName)
    {
        return Domain::where('domain', $domainName)->first();
    }
    
    
    /**
     * All aliases for doamin.
     * or serach for a single alias in that domain.
     * 
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, $domainName)
    {
        $domain = $this->getDomain($domainName);
        if ($request->input('q')) {
            $aliases = $domain->aliases()->where('username', $request->input('q'))->get();
        } else {
            $aliases = $domain->aliases()->get();
        }
        return response()->json($aliases);
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
        $alias = $domain->aliases()->find($aliasId);
        return response()->json($alias);
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
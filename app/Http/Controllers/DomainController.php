<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;


class DomainController extends Controller
{
    
    /**
     * Display a listing all doamins.
     * Or serach for one.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if ($request->input('q')) {
            $doamins = Domain::where('domain', $request->input('q'))->get();
        } else {
            $doamins = Domain::all();
        }
        return response()->json($doamins);
    }

    /**
     * Display the specified domain.
     *
     * @param  int  $domainId
     * @return \Illuminate\Http\Response
     */
    public function show($domainId)
    {
        $doamin = Domain::find($domainId);
        return response()->json($doamin);
    }

}
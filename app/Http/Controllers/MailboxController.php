<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use App\VbaModels\Mailbox;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;


class MailboxController extends Controller
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
     * All mailboxes for doamin.
     * or serach for a single mailbox in that domain.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, $domainName)
    {
        $domain = $this->getDomain($domainName);
        if ($request->input('q')) {
            $mailboxes = $domain->mailboxes()->where('username', $request->input('q'))->get();
        } else {
            $mailboxes = $domain->mailboxes()->get();
        }
        return response()->json($mailboxes);
    }

    /**
     * Store a newly created mailbox.
     * Note we may automaticly create a new alias base on setting file
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request, $domainName)
    {
        $domain = $this->getDomain($domainName);
    }

    /**
     * Display the specified mailbox.
     *
     * @param  int  $mailboxId
     * @return \Illuminate\Http\Response
     */
    public function show($domainName, $mailboxId)
    {
        $domain = $this->getDomain($domainName);
        $mailbox = $domain->mailboxes()->find($mailboxId);
        return response()->json($mailbox);
    }

    /**
     * Update the specified mailbox.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $mailboxId
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $domainName, $mailboxId)
    {
        $domain = $this->getDomain($domainName);
    }

}
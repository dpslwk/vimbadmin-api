<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use App\VbaModels\Mailbox;
use League\Fractal\Manager;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Transformers\MailboxTransformer;


class MailboxController extends ApiController
{
    protected $mailboxTransformer;

    public function __construct(Domain $domain, MailboxTransformer $mailboxTransformer, Manager $fractal)
    {
        parent::__construct($domain, $fractal);
        $this->mailboxTransformer = $mailboxTransformer;
    }
    
    /**
     * All mailboxes for domain.
     * or serach for a single mailbox in that domain.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, $domainName)
    {
        $domain = $this->getDomain($domainName);
        if ($request->input('q')) {
            $mailboxes = $domain->mailboxes()->where('username', $request->input('q'))->with(['domain'])->get();
        } else {
            $mailboxes = $domain->mailboxes()->with(['domain'])->get();
        }

        $data = $this->transformCollection($mailboxes, $this->mailboxTransformer);

        return $this->respond($data);
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

        if ($request->isMethod('patch')) {
            // need to merge with request with existing record
        } elseif ($request->isMethod('put')) {
            // need to replace the existing record??
        }
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
        $mailbox = $domain->mailboxes()->with(['domain'])->find($mailboxId);

        $data = $this->transformItem($mailbox, $this->mailboxTransformer);

        return $this->respond($data);
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
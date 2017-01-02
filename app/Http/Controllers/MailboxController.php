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
    /**
     * @var string Type to use with Transformer
     */
    protected $type = 'mailboxes';

    /**
     * @param Domain             $domain
     * @param MailboxTransformer $mailboxTransformer
     * @param Manager            $fractal
     */
    public function __construct(Domain $domain, MailboxTransformer $mailboxTransformer, Manager $fractal)
    {
        parent::__construct($domain, $mailboxTransformer, $fractal);
    }
    
    /**
     * All mailboxes for domain.
     * or serach for a single mailbox in that domain.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  string $domainName
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, string $domainName)
    {
        $domain = $this->getDomain($domainName);
        if ($request->input('q')) {
            $mailboxes = $domain->mailboxes()->where('username', $request->input('q'))->with(['domain'])->get();
        } else {
            $mailboxes = $domain->mailboxes()->with(['domain'])->get();
        }

        $data = $this->transformCollection($mailboxes);

        return $this->respond($data);
    }

    /**
     * Store a newly created mailbox.
     * Note we may automaticly create a new alias base on setting file
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  string $domainName
     * @return \Illuminate\Http\Response
     */
    // public function store(Request $request, string $domainName)
    // {
    //     $domain = $this->getDomain($domainName);

    //     $this->validate($request, [
    //         'data' => 'required|array',
    //         'data.type' => 'required|in:'.$this->type,
    //         'data.id' => 'required|integer|in:'.$mailboxId,
    //         'data.attributes' => 'required|array',
    //         // 'data.attributes.username' => 'sometimes|required|email',
    //         // 'data.attributes.name' => 'sometimes|required|string',
    //         'data.relationships' => 'sometimes|required|array',
    //         'data.relationships.domain.data.type' => 'required_with:data.relationships|in:domain',
    //         'data.relationships.domain.data.id' => 'required_with:data.relationships|in:'.$domain->id,
    //     ]);

    //     $requestData = $request->all();

    //     // do extra work to check domain counts allow this

    //     // create the new mailbox
    //     $mailbox = $domain->mailboxes()->create([
            
    //     ]);

    //     // need to create a new alias as well


    //     // do extra work to update the domain counts??

    //     $data = $this->transformItem($mailbox);

    //     return $this->respondCreated($data);

    // }

    /**
     * Display the specified mailbox.
     *
     * @param  string $domainName
     * @param  int  $mailboxId
     * @return \Illuminate\Http\Response
     */
    public function show(string $domainName, int $mailboxId)
    {
        $domain = $this->getDomain($domainName);
        $mailbox = $domain->mailboxes()->with(['domain'])->findOrFail($mailboxId);

        $data = $this->transformItem($mailbox);

        return $this->respond($data);
    }

    /**
     * Update the specified mailbox.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  string $domainName
     * @param  int  $mailboxId
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, string $domainName, int $mailboxId)
    {
        $domain = $this->getDomain($domainName);
        $mailbox = $domain->mailboxes()->with(['domain'])->findOrFail($mailboxIdl);

        $this->validate($request, [
            'data' => 'required|array',
            'data.type' => 'required|in'.$this->type,
            'data.id' => 'required|integer|in:'.$mailboxId,
            'data.attributes' => 'required|array',
            'data.attributes.name' => 'sometimes|required|string',
            'data.relationships' => 'sometimes|required|array',
            'data.relationships.domain.data.type' => 'required_with:data.relationships|in:domain',
            'data.relationships.domain.data.id' => 'required_with:data.relationships|in:'.$domain->id,
        ]);

        $requestData = $request->all();

        if (isset($requestData['data']['attributes']['name'])) {
            $mailbox->name = $requestData['data']['attributes']['name'];
        }

        $domain->mailboxes()->save($mailbox);

        return $this->respond([]);
    }

}
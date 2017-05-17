<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use App\VbaModels\Mailbox;
use League\Fractal\Manager;
use Illuminate\Http\Request;
use Exceptions\ForbidenException;
use App\Transformers\MailboxTransformer;
use League\Fractal\Serializer\JsonApiSerializer;

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
     * @param \Illuminate\Http\Request $request
     * @param string                   $domainName
     *
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
     * All mailboxes for domain.
     *
     * @param \Illuminate\Http\Request $request
     * @param int                      $domainId
     *
     * @return \Illuminate\Http\Response
     */
    public function showForDomain(Request $request, int $domainId)
    {
        $domain = $this->domain->findOrFail($domainId);
        $mailboxes = $domain->mailboxes()->with(['domain'])->get();

        $data = $this->transformCollection($mailboxes);

        return $this->respond($data);
    }

    /**
     * Store a newly created mailbox.
     * Note we may automaticly create a new alias base on setting file.
     *
     * @param \Illuminate\Http\Request $request
     * @param string                   $domainName
     *
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request, string $domainName)
    {
        $domain = $this->getDomain($domainName);

        $this->validate($request, [
            'data' => 'required|array',
            'data.type' => 'required|in:'.$this->type,
            'data.id' => 'sometimes|client_generated_id_forbiden',
            'data.attributes' => 'required|array',
            'data.attributes.username' => 'required|email|unique:vba.mailbox,username|unique:vba.alias,address|regex:/'.$domain['domain'].'/',
            'data.attributes.name' => 'required|string',
            'data.relationships' => 'sometimes|required|array',
            'data.relationships.domain.data.type' => 'required_with:data.relationships|in:domain',
            'data.relationships.domain.data.id' => 'required_with:data.relationships|in:'.$domain->id,
        ]);

        $requestData = $request->all();

        // do extra work to check domain counts allow this
        if ($domain['max_mailboxes'] != 0 && $domain['mailbox_count'] >= $domain['max_mailboxes']) {
            throw new ForbidenException('You have used all of your allocated mailboxes.');
        }

        // create the new mailbox
        $mailbox = $domain->mailboxes()->create([
            'username' => $requestData['data']['attributes']['username'],
            'password' => 'doiahoidsa',
            'name' => $requestData['data']['attributes']['name'],
            'alt_email' => '',
            'quota' => $domain['quota'],
            'local_part' => explode('@', $requestData['data']['attributes']['username'])[0],
            'active' => 1,
            'access_restriction' => 'ALL',
            'homedir' => $this->substitute($requestData['data']['attributes']['username'], config('vba.defaults.mailbox.homedir')),
            'maildir' => $this->substitute($requestData['data']['attributes']['username'], config('vba.defaults.mailbox.maildir')),
            'uid' => config('vba.defaults.mailbox.uid'),
            'gid' => config('vba.defaults.mailbox.gid'),
            'delete_pending' => false,
        ]);

        // hash the password
        
        if (config('vba.mailboxAliases') == 1) {
            // need to create a new alias as well
            $domain->aliases()->create([
                'address' => $requestData['data']['attributes']['username'],
                'goto'    => $requestData['data']['attributes']['username'],
            ]);
        }

        // // do extra work to update the domain counts??
        $domain['mailbox_count'] += 1;

        // TODO: some quota check thing 
        
        // save the chanegs 
        $domain->save();

        $data = $this->transformItem($mailbox);

        return $this->respondCreated($data);

    }

    /**
     * Display the specified mailbox.
     *
     * @param string $domainName
     * @param int    $mailboxId
     *
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
     * @param \Illuminate\Http\Request $request
     * @param string                   $domainName
     * @param int                      $mailboxId
     *
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, string $domainName, int $mailboxId)
    {
        $domain = $this->getDomain($domainName);
        $mailbox = $domain->mailboxes()->with(['domain'])->findOrFail($mailboxIdl);

        $this->validate($request, [
            'data'                                => 'required|array',
            'data.type'                           => 'required|in'.$this->type,
            'data.id'                             => 'required|integer|in:'.$mailboxId,
            'data.attributes'                     => 'required|array',
            'data.attributes.name'                => 'sometimes|required|string',
            'data.relationships'                  => 'sometimes|required|array',
            'data.relationships.domain.data.type' => 'required_with:data.relationships|in:domain',
            'data.relationships.domain.data.id'   => 'required_with:data.relationships|in:'.$domain->id,
        ]);

        $requestData = $request->all();

        if (isset($requestData['data']['attributes']['name'])) {
            $mailbox->name = $requestData['data']['attributes']['name'];
        }

        $domain->mailboxes()->save($mailbox);

        return $this->respond([]);
    }

    /**
     * Show just the repaltionships.
     *
     * @param Request $request
     * @param int     $domainId
     *
     * @return \Illuminate\Http\Response
     */
    public function showRelationships(Request $request, int $domainId)
    {
        $domain = $this->domain->findOrFail($domainId);
        $mailboxes = $domain->mailboxes()->get();
        // TODO: handle empty response
        $this->fractal->setSerializer(new JsonApiSerializer(url()));
        $data = $this->transformCollection($mailboxes);
        $newdata = [];
        foreach ($data['data'] as $item) {
            unset($item['attributes']);
            unset($item['relationships']);
            array_push($newdata, $item);
        }
        $data['data'] = $newdata;
        unset($data['included']);
        $related = url($domain->domain.'/mailboxes');

        return $this->respondRelated($data, $related);
    }
}

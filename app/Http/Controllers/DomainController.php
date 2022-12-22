<?php

namespace App\Http\Controllers;

use App\Transformers\DomainTransformer;
use App\VbaModels\Domain;
use Illuminate\Http\Request;
use League\Fractal\Manager;
use League\Fractal\Serializer\JsonApiSerializer;

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
     * @param \Illuminate\Http\Request $request
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
        if ($request->has('include')) {
            $includes = explode(',', rawurldecode($request->input('include')));
            $this->fractal->parseIncludes($includes);
            $this->domain->load($includes);
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
     * @param \Illuminate\Http\Request $request
     * @param int                      $domainId
     *
     * @return \Illuminate\Http\Response
     */
    public function show(Request $request, $domainId)
    {
        if ($request->has('include')) {
            $includes = explode(',', rawurldecode($request->input('include')));
            $this->fractal->parseIncludes($includes);
            $this->domain->load($includes);
        }

        $domain = $this->domain->findOrFail($domainId);

        $data = $this->transformItem($domain);

        return $this->respond($data);
    }

    /**
     * Display the specified domain for mailbox.
     *
     * @param \Illuminate\Http\Request $request
     * @param string                   $domainName
     * @param int                      $mailboxId
     *
     * @return \Illuminate\Http\Response
     */
    public function showForMailbox(Request $request, $domainName, $mailboxId)
    {
        $domain = $this->getDomain($domainName);

        $data = $this->transformItem($domain);

        return $this->respond($data);
    }

    /**
     * Display the specified domain for alias.
     *
     * @param \Illuminate\Http\Request $request
     * @param string                   $domainName
     * @param int                      $aliasId
     *
     * @return \Illuminate\Http\Response
     */
    public function showForAlias(Request $request, $domainName, $aliasId)
    {
        $domain = $this->getDomain($domainName);

        $data = $this->transformItem($domain);

        return $this->respond($data);
    }

    /**
     * Show just the mailbox relationships.
     *
     * @param Request $request
     * @param string  $domainName
     * @param int     $mailboxId
     *
     * @return \Illuminate\Http\Response
     */
    public function showMailboxRelationships(Request $request, string $domainName, int $mailboxId)
    {
        $domain = $this->getDomain($domainName);
        $mailbox = $domain->mailboxes()->findOrFail($mailboxId);
        $this->fractal->setSerializer(new JsonApiSerializer(url()));
        $data = $this->transformItem($domain);
        unset($data['data']['attributes']);
        $related = $data['data']['links']['self'];

        return $this->respondRelated($data, $related);
    }

    /**
     * Show just the alias relationships.
     *
     * @param Request $request
     * @param string  $domainName
     * @param int     $aliasId
     *
     * @return \Illuminate\Http\Response
     */
    public function showAliasRelationships(Request $request, string $domainName, int $aliasId)
    {
        $domain = $this->getDomain($domainName);
        $alias = $domain->aliases()->findOrFail($aliasId);
        $this->fractal->setSerializer(new JsonApiSerializer(url()));
        $data = $this->transformItem($domain);
        unset($data['data']['attributes']);
        $data['data']['links']['self'];
        $related = $data['data']['links']['self'];

        return $this->respondRelated($data, $related);
    }
}

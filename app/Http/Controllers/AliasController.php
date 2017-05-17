<?php

namespace App\Http\Controllers;

use App\VbaModels\Alias;
use App\VbaModels\Domain;
use League\Fractal\Manager;
use Illuminate\Http\Request;
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
     * @param Request $request
     * @param string  $domainName
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request, string $domainName)
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
     * All aliases for domain.
     *
     * @param \Illuminate\Http\Request $request
     * @param int                      $domainId
     *
     * @return \Illuminate\Http\Response
     */
    public function showForDomain(Request $request, int $domainId)
    {
        $domain = $this->domain->findOrFail($domainId);
        $aliases = $domain->aliases()->with(['domain'])->get();

        $data = $this->transformCollection($aliases);

        return $this->respond($data);
    }

    /**
     * Store a newly created alias.
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
            'data'                                => 'required|array',
            'data.type'                           => 'required|in:'.$this->type,
            'data.id'                             => 'sometimes|null',
            'data.attributes'                     => 'required|array',
            'data.attributes.address'             => 'required|email|unique:vba.alias,address|unique:vba.mailbox,username',
            'data.attributes.goto'                => 'required|array',
            'data.attributes.goto.*'              => 'required_with:data.attributes.goto|email',
            'data.relationships'                  => 'required|array',
            'data.relationships.domain.data.type' => 'required_with:data.relationships|in:domain',
            'data.relationships.domain.data.id'   => 'required_with:data.relationships|in:'.$domain->id,
        ]);

        $requestData = $request->all();

        // do extra work to check domain counts allow this
        if ($domain['max_aliases'] != 0 && $domain['alias_count'] >= $domain['max_aliases']) {
            throw new ForbidenException('You have used all of your allocated aliases.');
        }

        // create the new alias
        $alias = $domain->aliases()->create([
            'address' => $requestData['data']['attributes']['address'],
            'goto'    => implode(',', $requestData['data']['attributes']['goto']),
        ]);

        // do extra work to update the domain counts??
        $domain['alias_count'] += 1;

        // save the chanegs
        $domain->save();

        $data = $this->transformItem($alias);

        return $this->respondCreated($data);
    }

    /**
     * Display the specified alias.
     *
     * @param int    $aliasId
     * @param string $domainName
     *
     * @return \Illuminate\Http\Response
     */
    public function show(string $domainName, int $aliasId)
    {
        $domain = $this->getDomain($domainName);
        $alias = $domain->aliases()->with(['domain'])->findOrFail($aliasId);
        $data = $this->transformItem($alias);

        return $this->respond($data);
    }

    /**
     * Update the specified alias.
     *
     * @param \Illuminate\Http\Request $request
     * @param string                   $domainName
     * @param int                      $aliasId
     *
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, string $domainName, int $aliasId)
    {
        $domain = $this->getDomain($domainName);
        $alias = $domain->aliases()->with(['domain'])->findOrFail($aliasId);

        $this->validate($request, [
            'data'                                => 'required|array',
            'data.type'                           => 'required|in:'.$this->type,
            'data.id'                             => 'required|integer|in:'.$aliasId,
            'data.attributes'                     => 'required|array',
            'data.attributes.address'             => 'sometimes|required|email',
            'data.attributes.goto'                => 'sometimes|required|array',
            'data.attributes.goto.*'              => 'required_with:data.attributes.goto|email',
            'data.relationships'                  => 'sometimes|required|array',
            'data.relationships.domain.data.type' => 'required_with:data.relationships|in:domain',
            'data.relationships.domain.data.id'   => 'required_with:data.relationships|in:'.$domain->id,
        ]);

        $requestData = $request->all();

        if (isset($requestData['data']['attributes']['address'])) {
            $alias->address = $requestData['data']['attributes']['address'];
        }

        if (isset($requestData['data']['attributes']['goto'])) {
            $alias->goto = implode(',', $requestData['data']['attributes']['goto']);
        }

        $domain->aliases()->save($alias);

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
        $aliases = $domain->aliases()->get();
        // TODO: handle empty response
        $this->fractal->setSerializer(new JsonApiSerializer(url()));
        $data = $this->transformCollection($aliases);
        $newdata = [];
        foreach ($data['data'] as $item) {
            unset($item['attributes']);
            unset($item['relationships']);
            array_push($newdata, $item);
        }
        $data['data'] = $newdata;
        unset($data['included']);
        $related = url($domain->domain.'/aliases');

        return $this->respondRelated($data, $related);
    }
}

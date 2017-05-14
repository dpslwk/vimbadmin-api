<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use Illuminate\Http\Response as IlluminateResponse;
use League\Fractal\Manager;
use League\Fractal\Resource\Collection;
use League\Fractal\Resource\Item;
use League\Fractal\Serializer\JsonApiSerializer;
use League\Fractal\TransformerAbstract;

class ApiController extends Controller
{
    /**
     * @var Domain
     */
    protected $domain;

    /**
     * @var TransformerAbstract
     */
    protected $transformer;

    /**
     * @var Manager
     */
    protected $fractal;

    /**
     * Default status code for a resonse.
     *
     * @var int
     */
    protected $statusCode = IlluminateResponse::HTTP_OK;

    /**
     * @param Domain              $domain
     * @param TransformerAbstract $transformer
     * @param Manager             $fractal
     */
    public function __construct(Domain $domain, TransformerAbstract $transformer, Manager $fractal)
    {
        $this->domain = $domain;
        $this->transformer = $transformer;
        $this->fractal = $fractal;
        $domainName = $this->routeParameter('domainName');
        $baseUrl = url(is_null($domainName) ? '' : '/'.$domainName);
        $fractal->setSerializer(new JsonApiSerializer($baseUrl));
    }

    /**
     * Helper to grab the domain object.
     *
     * @param string $domainName
     *
     * @return App\VbaModels\Domain
     */
    protected function getDomain($domainName)
    {
        return $this->domain->where('domain', $domainName)->firstOrFail();
    }

    /**
     * Transform a colletion of objects.
     *
     * @param mixed $items
     *
     * @return array
     */
    protected function transformCollection($items)
    {
        $collection = new Collection($items, $this->transformer, $this->type);

        return $this->fractal->createData($collection)->toArray();
    }

    /**
     * Transform a single Item.
     *
     * @param mixed $item
     *
     * @return array
     */
    protected function transformItem($item)
    {
        $item = new Item($item, $this->transformer, $this->type);

        return $this->fractal->createData($item)->toArray();
    }

    /**
     * Get the status code for this request.
     *
     * @return int
     */
    public function getStatusCode()
    {
        return $this->statusCode;
    }

    /**
     * Set the status code for this response.
     *
     * @param int $statusCode
     */
    public function setStatusCode($statusCode)
    {
        $this->statusCode = $statusCode;

        return $this;
    }

    /**
     * [respond description].
     *
     * @param array $data
     * @param array $headers
     *
     * @return \Illuminate\Http\Response
     */
    public function respond($data, $headers = [])
    {
        $data['links'] = [
            'self' => app('request')->fullUrl(),
        ];

        return response()->json($data, $this->getStatusCode(), $headers);
    }

    /**
     * [respond description].
     *
     * @param array  $data
     * @param string $related
     * @param array  $headers
     *
     * @return \Illuminate\Http\Response
     */
    public function respondRelated($data, $related, $headers = [])
    {
        $data['links'] = [
            'self'    => app('request')->fullUrl(),
            'related' => $related,
        ];

        return response()->json($data, $this->getStatusCode(), $headers);
    }

    /**
     * [respondCreated description].
     *
     * @param array $data
     *
     * @return \Illuminate\Http\Response
     */
    public function respondCreated($data)
    {
        return $this->setStatusCode(IlluminateResponse::HTTP_CREATED)->respond($data, $headers);
    }

    /**
     * [respondNotFound description].
     *
     * @param string $message
     *
     * @return \Illuminate\Http\Response
     */
    public function respondNotFound($message = 'Not Found')
    {
        return $this->setStatusCode(IlluminateResponse::HTTP_NOT_FOUND)->respondWithError($message);
    }

    /**
     * [respondWithError description].
     *
     * @param string $message
     *
     * @return \Illuminate\Http\Response
     */
    public function respondWithError($message)
    {
        return $this->respond([
            'errors' => [
                'title'  => $message,
                'status' => $this->getStatusCode(),
            ],
        ]);
    }

    /**
     * Get a given parameter from the route.
     * https://gist.github.com/irazasyed/8ce3b004177ce23af5ef.
     *
     * @param $name
     * @param null $default
     *
     * @return mixed
     */
    protected function routeParameter($name, $default = null)
    {
        $routeInfo = app('request')->route();

        return array_get($routeInfo[2], $name, $default);
    }
}

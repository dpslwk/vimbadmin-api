<?php

namespace App\Http\Controllers;

use App\VbaModels\Domain;
use Illuminate\Support\Arr;
use League\Fractal\Manager;
use League\Fractal\Resource\Item;
use League\Fractal\Resource\Collection;
use League\Fractal\TransformerAbstract;
use League\Fractal\Serializer\JsonApiSerializer;
use Illuminate\Http\Response as IlluminateResponse;

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
        $baseUrl = url(is_null($domainName) ? '' : '/' . $domainName);
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
        return $this->setStatusCode(IlluminateResponse::HTTP_CREATED)->respond($data);
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

        return Arr::get($routeInfo[2], $name, $default);
    }

    /**
     * Replaces the following characters in the $str parameter:.
     *
     * %u - the local part of the username (email address)
     * %d - the domain part of the username (email address)
     * %m - the username (email address)
     *
     * @param string $email An email address used to extract the domain name
     * @param string $str   The format string
     *
     * @return string The newly created maildir (also set in the object)
     */
    protected function substitute($email, $str)
    {
        [$un, $dn] = explode('@', $email);

        $str = str_replace('%atmail', substr($email, 0, 1) . '/' . substr($email, 1, 1) . '/' . $email, $str);
        $str = str_replace('%u', $un, $str);
        $str = str_replace('%d', $dn, $str);
        $str = str_replace('%m', $email, $str);

        return $str;
    }

    /**
     * A reimplmentation of Open Solutions' password hash helpers
     * https://github.com/opensolutions/OSS-Framework/blob/master/src/OSS/Auth/Password.php
     * https://github.com/opensolutions/ViMbAdmin/blob/master/library/ViMbAdmin/Dovecot.php.
     *
     * As the frameworks helper calls back into the projects code base :(
     *
     * @param string $username
     * @param string $password
     * @return string
     */
    protected function hashPassword($username, $password)
    {
        if (substr(config('vba.defaults.mailbox.password_scheme'), 0, 8) != 'dovecot:') {
            throw new \Exception('Password hasing only supports dovecot', 500);
        }
        $scheme = substr(config('vba.defaults.mailbox.password_scheme'), 8);
        $cmd = $binary = config('vba.defaults.mailbox.dovecot_pw_binary');

        if (strpos($cmd, ' ')) {
            $binary = substr($cmd, 0, strpos($cmd, ' '));
        }

        if (! file_exists($binary) || ! is_executable($binary)) {
            throw new \Exception('Dovecot binary does not exist or is not executable', 500);
        }

        $cmd .= ' -s ' . escapeshellarg($scheme) . ' -u ' . escapeshellarg($username) . ' -p ' . escapeshellarg($password);
        $a = exec($cmd, $output, $retval);

        if ($retval != 0) {
            throw new \Exception('Error executing Dovecot password command.', 500);
        }

        return trim(substr($a, strlen($scheme) + 2));
    }
}

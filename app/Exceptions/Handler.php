<?php

namespace App\Exceptions;

use Exception;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Validation\ValidationException;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\Response as IlluminateResponse;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Laravel\Lumen\Exceptions\Handler as ExceptionHandler;
use Symfony\Component\HttpKernel\Exception\HttpException;

class Handler extends ExceptionHandler
{
    /**
     * A list of the exception types that should not be reported.
     *
     * @var array
     */
    protected $dontReport = [
        AuthorizationException::class,
        HttpException::class,
        ModelNotFoundException::class,
        ValidationException::class,
    ];

    /**
     * Report or log an exception.
     *
     * This is a great spot to send exceptions to Sentry, Bugsnag, etc.
     *
     * @param  \Exception  $e
     * @return void
     */
    public function report(Exception $e)
    {
        parent::report($e);
    }

    /**
     * Render an exception into an HTTP response.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Exception  $e
     * @return \Illuminate\Http\Response
     */
    public function render($request, Exception $e)
    {
        if ($e instanceof ModelNotFoundException) {
            $data = [
                'errors' => [
                    [
                        'status' => IlluminateResponse::HTTP_NOT_FOUND,
                        'title' => 'Not Found',
                        'detail' => 'The requested resource does not exist.',
                    ]
                ]
            ];

            return response()->json($data, IlluminateResponse::HTTP_NOT_FOUND);
        }

        if ($e instanceof ValidationException) {
            $data = [
                'errors' => [
                    [
                        'status' => IlluminateResponse::HTTP_CONFLICT,
                        'title' => 'Validation Confilict',
                        'detail' => 'The requested does not pass the Validation.',
                        'meta' => $e->getResponse()->getData(),
                    ]
                ]
            ];

            return response()->json($data, IlluminateResponse::HTTP_CONFLICT);
        }

        if ($e instanceof AuthenticationException) {
            $data = [
                'errors' => [
                    [
                        'status' => IlluminateResponse::HTTP_UNAUTHORIZED,
                        'title' => 'Unauthorized',
                        'detail' => 'You are not Authorized to perform this request.',
                    ]
                ]
            ];
            // var_dump($e);
            return response()->json($data, IlluminateResponse::HTTP_UNAUTHORIZED);
        }

        


        return parent::render($request, $e);
    }
}

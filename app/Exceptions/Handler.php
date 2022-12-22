<?php

namespace App\Exceptions;

use Illuminate\Auth\AuthenticationException;
use Illuminate\Validation\ValidationException;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Http\Response as IlluminateResponse;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Laravel\Lumen\Exceptions\Handler as ExceptionHandler;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Throwable;

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
     * @param  \Throwable  $exception
     * @return void
     *
     * @throws \Exception
     */
    public function report(Throwable $exception)
    {
        parent::report($exception);
    }

    /**
     * Render an exception into an HTTP response.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Throwable  $exception
     * @return \Illuminate\Http\Response|\Illuminate\Http\JsonResponse
     *
     * @throws \Throwable
     */
    public function render($request, Throwable $exception)
    {
        if ($exception instanceof ModelNotFoundException) {
            $data = [
                'errors' => [
                    [
                        'status' => IlluminateResponse::HTTP_NOT_FOUND,
                        'title'  => 'Not Found',
                        'detail' => 'The requested resource does not exist.',
                    ],
                ],
            ];

            return response()->json($data, IlluminateResponse::HTTP_NOT_FOUND);
        }

        if ($exception instanceof ValidationException) {
            $data = [
                'errors' => [
                    [
                        'status' => IlluminateResponse::HTTP_CONFLICT,
                        'title'  => 'Validation Confilict',
                        'detail' => 'The requested does not pass the Validation.',
                        'meta'   => $exception->getResponse()->getData(),
                    ],
                ],
            ];

            return response()->json($data, IlluminateResponse::HTTP_CONFLICT);
        }

        if ($exception instanceof AuthenticationException) {
            $data = [
                'errors' => [
                    [
                        'status' => IlluminateResponse::HTTP_UNAUTHORIZED,
                        'title'  => 'Unauthorized',
                        'detail' => 'You are not Authorized to perform this request.',
                    ],
                ],
            ];
            // var_dump($exception);
            return response()->json($data, IlluminateResponse::HTTP_UNAUTHORIZED);
        }

        if ($exception instanceof ForbidenException) {
            $data = [
                'errors' => [
                    [
                        'status' => IlluminateResponse::HTTP_FORBIDDEN,
                        'title'  => 'Forbiden',
                        'detail' => 'This request is forbiden.',
                        'meta'   => $exception->getMessage(),
                    ],
                ],
            ];

            return response()->json($data, IlluminateResponse::HTTP_FORBIDDEN);
        }

        return parent::render($request, $exception);
    }
}

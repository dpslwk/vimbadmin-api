<?php

namespace App\VbaModels;

use Illuminate\Database\Eloquent\Model;

class Domain extends Model
{
    /**
     * The connection name for the model.
     *
     * @var string
     */
    protected $connection = 'vba';

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'domain';

    /**
     * Overide the timesatmp column names.
     */
    const CREATED_AT = 'created';
    const UPDATED_AT = 'modified';

    /**
     * Get the route key for the model.
     *
     * @return string
     */
    public function getRouteKeyName()
    {
        return 'domain';
    }

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'description',
        'domain',
        'max_aliases',
        'max_mailboxes',
        'max_quota',
        'transport',
        'backupmx',
        'active',
        'homedir',
        'maildir',
        'uid',
        'gid',
    ];

    /**
     * Get the mailboxes for this domain.
     */
    public function mailboxes()
    {
        return $this->hasMany('App\VbaModels\Mailbox', 'Domain_id');
    }

    /**
     * Get the aliases for this domain.
     */
    public function aliases()
    {
        return $this->hasMany('App\VbaModels\Alias', 'Domain_id');
    }
}

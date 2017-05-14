<?php

namespace App\VbaModels;

use Illuminate\Database\Eloquent\Model;

class Mailbox extends Model
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
    protected $table = 'mailbox';

    /**
     * Overide the timesatmp column names.
     */
    const CREATED_AT = 'created';
    const UPDATED_AT = 'modified';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'username',
        'password',
        'name',
        'alt_email',
        'quota',
        'local_part',
        'active',
        'access_restriction',
        'homedir',
        'maildir',
        'uid',
        'gid',
        'homedir_size',
        'maildir_size',
        'size_at',
        'delete_pending',
        'Domain_id',
    ];

    /**
     * Get the Domain that owns this mailbox.
     */
    public function domain()
    {
        return $this->belongsTo('App\VbaModels\Domain', 'Domain_id');
    }
}

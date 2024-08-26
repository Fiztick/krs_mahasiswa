<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Enrollment extends Model
{
    use HasFactory;

    public $timestamps = false;
    
    protected $table = 'enrollment';

    public $guarded = [];

    public function mahasiswa(): BelongsTo
    {
        return $this->belongsto(Mahasiswa::class, 'id_mhs');
    }

    public function mata_kuliah(): BelongsTo
    {
        return $this->belongsto(Mata_Kuliah::class, 'id_matkul');
    }
}

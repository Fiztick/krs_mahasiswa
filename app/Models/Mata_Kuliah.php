<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mata_Kuliah extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $table = 'mata_kuliah';

    protected $guarded = [];

    public function enrollments()
    {
        return $this->hasMany(Enrollment::class, 'id_matkul');
    }
}

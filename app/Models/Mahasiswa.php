<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mahasiswa extends Model
{
    use HasFactory;

    public $timestamps = false;

    protected $table = 'mahasiswa';

    protected $fillable = ['npm', 'nama', 'prodi'];

    public function enrollments()
    {
        return $this->hasMany(Enrollment::class, 'id_mhs');
    }
}

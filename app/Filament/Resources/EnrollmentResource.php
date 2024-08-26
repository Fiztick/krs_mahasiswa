<?php

namespace App\Filament\Resources;

use App\Filament\Resources\EnrollmentResource\Pages;
use App\Filament\Resources\EnrollmentResource\RelationManagers;
use App\Models\Enrollment;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class EnrollmentResource extends Resource
{
    protected static ?string $model = Enrollment::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static ?string $navigationLabel = 'Enrollment';

    protected static ?string $pluralModelLabel = 'Enrollment';

    protected static ?string $slug = 'enrollment';

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('id_mhs')
                    ->label('Mahasiswa')
                    ->options(function () {
                        return \App\Models\Mahasiswa::pluck('nama', 'id')->toArray();
                    })
                    ->required(),
                Forms\Components\Select::make('id_matkul')
                    ->label('Mata Kuliah')
                    ->options(function () {
                        return \App\Models\Mata_Kuliah::pluck('nama', 'id')->toArray();
                    })
                    ->required(),
                Forms\Components\TextInput::make('nilai')
                    ->label('Nilai')
                    ->type('number')
                    ->default(0),
                Forms\Components\TextInput::make('tahun_ajaran')
                    ->label('Tahun Ajaran')
                    ->type('number')
                    ->required(),
                Forms\Components\Select::make('ket')
                    ->label('Keterangan')
                    ->options([
                        'baru' => 'Baru',
                        'lama' => 'Lama',
                    ])
                    ->required(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id'),
                Tables\Columns\TextColumn::make('mahasiswa.nama')
                ->label('Mahasiswa')
                ->sortable()
                ->searchable(),
                Tables\Columns\TextColumn::make('mata_kuliah.nama')->label('Mata Kuliah')
                ->sortable()
                ->searchable(),
                Tables\Columns\TextColumn::make('nilai'),
                Tables\Columns\TextColumn::make('tahun_ajaran'),
                Tables\Columns\TextColumn::make('ket'),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListEnrollments::route('/'),
            'create' => Pages\CreateEnrollment::route('/create'),
            'edit' => Pages\EditEnrollment::route('/{record}/edit'),
        ];
    }
}

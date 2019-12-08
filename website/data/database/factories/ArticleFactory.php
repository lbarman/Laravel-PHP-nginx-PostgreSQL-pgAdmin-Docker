<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */
use App\Article;
use App\Section;
use App\User;
use Faker\Generator as Faker;

$factory->define(Article::class, function (Faker $faker) {
    return [
        'name' => $faker->sentence($nbWords = 2),
        'user_id' => \App\User::all()->random()->id,
        'section_id' => \App\Section::all()->random()->id,
    ];
});
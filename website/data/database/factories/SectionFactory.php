<?php

/** @var \Illuminate\Database\Eloquent\Factory $factory */
use App\Section;
use Faker\Generator as Faker;

$factory->define(Section::class, function (Faker $faker) {
    return [
        'name' => $faker->sentence($nbWords = 4),
        'display_order' => random_int(0, 100),
        'picture_width' => random_int(0, 100),
        'picture_height' => random_int(0, 100),
    ];
});
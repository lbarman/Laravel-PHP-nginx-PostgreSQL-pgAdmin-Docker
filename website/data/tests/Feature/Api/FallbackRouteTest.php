<?php

namespace Tests\Feature\Api;

use Tests\TestCase;

class FallbackRouteTest extends TestCase
{
    /** @test */
    public function missing_api_routes_should_return_a_json_404()
    {
        $this->withoutExceptionHandling();
        $response = $this->get('/api/missing/route');

        $response->assertStatus(404);
        $response->assertHeader('Content-Type', 'application/json');
        $response->assertJson([
            'message' => 'Not Found.',
        ]);
    }
}
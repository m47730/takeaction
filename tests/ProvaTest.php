<?php declare(strict_types=1);

use PHPUnit\Framework\TestCase;

final class ProvaTest extends TestCase
{
    public function testSuccessful(): void
    {
        $this->assertEquals(true, true);
    }

    public function testFailed(): void
    {
        $this->assertEquals(true, true);
    }
}
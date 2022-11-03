<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class CrawlingController extends AbstractController
{
    #[Route('/crawling/crawl', name: 'crawling_crawl')]
    public function crawl(): JsonResponse
    {
        return $this->json([
            'url'    => 'url',
            'status' => 'status',
        ]);
    }

    #[Route('/crawling/reset', name: 'crawling_reset')]
    public function reset(): JsonResponse
    {
        return $this->json([
            'url'    => 'url',
            'status' => 'status',
        ]);
    }
}

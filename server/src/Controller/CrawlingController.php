<?php

namespace App\Controller;

use AndrewSvirin\ResourceCrawlerBundle\Crawler\ResourceCrawler;
use App\Responses\Crawling\CrawlingCrawlResponse;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;

class CrawlingController extends AbstractController
{
    #[Route('/crawling/crawl', name: 'crawling_crawl')]
    public function crawl(ResourceCrawler $resourceCrawler): JsonResponse
    {
        $url       = 'https://data.fivethirtyeight.com/';
        $pathMasks = ['+fivethirtyeight.com/', '-embed'];

        $task = $resourceCrawler->crawlWebResource($url, $pathMasks);

//        dump($task);
        // TODO: Is in for_processing. but should be in_process

        $response = new CrawlingCrawlResponse($task);

        return $this->json($response->toJson());
    }

    #[Route('/crawling/reset', name: 'crawling_reset')]
    public function reset(ResourceCrawler $resourceCrawler): JsonResponse
    {
        $url = 'https://data.fivethirtyeight.com/';

        $resourceCrawler->resetWebResource($url);

        return $this->json([
            'url'    => $url,
            'status' => 'success',
        ]);
    }
}

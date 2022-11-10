<?php

namespace App\Controller;

use AndrewSvirin\ResourceCrawlerBundle\Crawler\ResourceCrawler;
use App\Responses\Crawling\CrawlingCrawlResponse;
use LogicException;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class CrawlingController extends AbstractController
{
    #[Route('/crawling/crawl', name: 'crawling_crawl')]
    public function crawl(ResourceCrawler $resourceCrawler, Request $request): JsonResponse
    {
        $requestData = $request->toArray();

        $pathMasks = ['+fivethirtyeight.com/', '-embed'];

        if ($requestData['resource_type'] === 'web') {
            $task = $resourceCrawler->crawlWebResource($requestData['resource_path'], $pathMasks);
        } elseif ($requestData['resource_type'] === 'disk') {
            $task = $resourceCrawler->crawlDiskResource($requestData['resource_path'], $pathMasks);
        } else {
            throw new LogicException('Incorrect type');
        }

        $response = new CrawlingCrawlResponse($task);

        return $this->json($response->toJson());
    }

    #[Route('/crawling/reset', name: 'crawling_reset')]
    public function reset(ResourceCrawler $resourceCrawler, Request $request): JsonResponse
    {
        $requestData = $request->toArray();

        if ($requestData['resource_type'] === 'web') {
            $resourceCrawler->resetWebResource($requestData['resource_path']);
        } elseif ($requestData['resource_type'] === 'disk') {
            $resourceCrawler->resetDiskResource($requestData['resource_path']);
        } else {
            throw new LogicException('Incorrect type');
        }

        return $this->json([
            'url'    => $requestData['resource_path'],
            'status' => 'success',
        ]);
    }
}

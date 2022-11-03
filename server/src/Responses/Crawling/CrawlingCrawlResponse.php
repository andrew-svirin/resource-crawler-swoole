<?php

namespace App\Responses\Crawling;

use AndrewSvirin\ResourceCrawlerBundle\Process\Task\CrawlingTask;

class CrawlingCrawlResponse
{
    public function __construct(private readonly ?CrawlingTask $task = null)
    {
    }

    private function emptyJson(): array
    {
        return [
            'status' => 'finished',
        ];
    }

    public function toJson(): array
    {
        if (null === $this->task) {
            return $this->emptyJson();
        }

        return [
            'url'             => $this->task->getProcess()->getResource()->getRoot()->getUri()->getPath(),
            'path_expression' => $this->task->getProcess()->getResource()->pathRegex()->getExpression(),
            'task'            => [
                'path'   => $this->task->getNode()->getUri()->getPath(),
                'status' => $this->task->getStatus(),
            ],
            'status'          => 'success',
        ];
    }
}

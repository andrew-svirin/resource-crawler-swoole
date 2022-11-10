export class Api {
  readonly basePath: string = 'http://localhost:80';

  public crawl (request: CrawlRequest): Promise<Response> {
    return this.request('/crawling/crawl', 'POST', request);
  }

  public reset (request: ResetRequest): Promise<Response> {
    return this.request('/crawling/reset', 'POST', request);
  }

  private request (path: string, method: string, data?: object): Promise<Response> {
    return fetch(this.basePath + path, {
      method: method,
      body: JSON.stringify(data),
      headers: {
        'Content-Type': 'application/json'
      },
    })
      .then((response) => {
        if (response.status != 200) {
          return {
            'status': 'response_status',
            'response': response,
          };
        } else {
          return response.json();
        }
      }).catch((error) => {
          return {
            'status': 'request_error',
            'error': error,
          };
        }
      );
  }
}

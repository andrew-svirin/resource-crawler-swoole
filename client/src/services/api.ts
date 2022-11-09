export class Api {
  readonly basePath: string = 'http://localhost:80';

  public crawl (): Promise<Response> {
    return this.request('/crawling/crawl', 'GET');
  }

  private request (path: string, method: string): Promise<Response> {
    return fetch(this.basePath + path, {
      method: method,
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

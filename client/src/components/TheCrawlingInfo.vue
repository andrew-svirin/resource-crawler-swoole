<template>
  <h2>{{ componentTitle }}</h2>

  <the-crawling-form @formChanged="onFormChanged" />

  <v-btn variant="outlined" @click="onClickStart">{{ btnTitles.start }}</v-btn>
  <v-btn variant="outlined" @click="onClickClear">{{ btnTitles.clear }}</v-btn>
</template>

<script setup lang="ts">
import TheCrawlingForm from '@/components/TheCrawlingForm';
import { Api } from '@/services/api';

const api: Api = new Api();

const componentTitle = 'Crawling Info';
const btnTitles = {
  start: 'Start',
  clear: 'Clear',
};

let crawlingForm: CrawlingForm = {};

const onFormChanged = (newForm: CrawlingForm) => {
  Object.assign(crawlingForm, newForm);
};

const onClickStart = async () => {
  let statistic: CrawlingStatistic = {
    iteration: 0,
    total_requests: 0,
    processed_requests: 0,
    start_time: getCurrentTime(),
    end_time: getCurrentTime(),
  };

  for (let i = 0; i < crawlingForm.parallel_connections_amount; i++) {
    iterateRequest(api, (data: CrawlResponse): void => {
      statistic.total_requests++;

      if (data.task?.status === 'processed') {
        statistic.processed_requests++;

        statistic.iteration++;
      }

      if (statistic.iteration <= crawlingForm.requests_amount) {
        statistic.end_time = getCurrentTime();

        emit('statisticChanged', statistic);
      }
    }, () => {
      return statistic.iteration >= crawlingForm.requests_amount;
    });
  }
};

const getCurrentTime = (): number => {
  return new Date().getTime() / 1000;
};

const iterateRequest = (api: Api, dataHandler: (data: object) => void, exitSignalHandler: () => boolean): void => {
  api.crawl({
    resource_type: crawlingForm.resource_type,
    resource_path: crawlingForm.resource_path,
  }).then((data: object) => {
    dataHandler(data);

    if (!exitSignalHandler()) {
      iterateRequest(api, dataHandler, exitSignalHandler);
    }
  });
};

const onClickClear = (): void => {
  api.reset({
    resource_type: crawlingForm.resource_type,
    resource_path: crawlingForm.resource_path,
  });
};

const emit = defineEmits(['statisticChanged']);
</script>

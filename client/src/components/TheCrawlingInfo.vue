<template>
  <h2>{{ componentTitle }}</h2>

  <the-crawling-form @formChanged="onFormChanged" />

  <v-btn variant="outlined" @click="onClickStart">{{ startTitle }}</v-btn>
</template>

<script setup lang="ts">
import TheCrawlingForm from '@/components/TheCrawlingForm';
import { Api } from '@/services/api';

const componentTitle = 'Crawling Info';
const startTitle = 'Start';

let crawlingForm: CrawlingForm = {};

const onFormChanged = (newForm: CrawlingForm) => {
  crawlingForm = newForm;
};

const onClickStart = async () => {
  let iteration = 20;
  const api: Api = new Api();
  const startTime: number = getCurrentTime();

  for (let i = 0; i < 4; i++) {
    iterateRequest(api, dataHandler, () => {
      iteration--;

      console.log('iteration, thread, spentTime', iteration, i, getCurrentTime() - startTime);

      return exitSignalHandler(iteration);
    });
  }

  console.log('click', crawlingForm);
};

const getCurrentTime = (): number => {
  return new Date().getTime() / 1000;
};

const dataHandler = (data: object): void => {
  console.log('data,thread', data);
};

const exitSignalHandler = (iteration: number): boolean => {
  return iteration <= 0;
};

const iterateRequest = (api: Api, dataHandler: (data: object) => void, exitSignalHandler: () => boolean) => {
  api.crawl().then((data: object) => {
    dataHandler(data);

    if (!exitSignalHandler()) {
      return iterateRequest(api, dataHandler, exitSignalHandler);
    }
  });
};

</script>

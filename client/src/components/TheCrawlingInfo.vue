<template>
  <h2>{{ componentTitle }}</h2>

  <the-crawling-form @formChanged="onFormChanged" />

  <v-btn variant="outlined" @click="onClickStart">{{ startTitle }}</v-btn>
</template>

<script setup lang="ts">
import TheCrawlingForm from '@/components/TheCrawlingForm';

const componentTitle = 'Crawling Info';
const startTitle = 'Start';

let crawlingForm: CrawlingForm = {};

const onFormChanged = (newForm: CrawlingForm) => {
  crawlingForm = newForm;
};

const onClickStart = () => {
  console.log('click', crawlingForm);
};

</script>

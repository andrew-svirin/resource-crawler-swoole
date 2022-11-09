<template>
  <v-app>
    <v-main>
      <v-container fluid>
        <v-row>
          <v-col>
            <the-crawling-info @statisticChanged="onStatisticChanged" />
          </v-col>
        </v-row>
        <v-row>
          <v-col>
            <the-crawling-statistic :statistic="statistic" />
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<script setup lang="ts">
import TheCrawlingInfo from '@/components/TheCrawlingInfo';
import TheCrawlingStatistic from '@/components/TheCrawlingStatistic.vue';
import { shallowReactive } from 'vue';

let statistic: CrawlingStatistic = shallowReactive({
  iteration: 0,
  total_requests: 0,
  processed_requests: 0,
  start_time: 0,
  end_time: 0,
});

const onStatisticChanged = (newStatistic: CrawlingStatistic) => {
  Object.assign(statistic, newStatistic);
};
</script>

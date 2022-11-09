<template>
  <h2>{{ componentTitle }}</h2>
  <v-table>
    <thead>
    <tr>
      <th>
        {{ tableHeaderLabels.label }}
      </th>
      <th>
        {{ tableHeaderLabels.value }}
      </th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>{{ tableRowLabels.total_requests }}</td>
      <td>{{ statistic.total_requests }}</td>
    </tr>
    <tr>
      <td>{{ tableRowLabels.processed_requests }}</td>
      <td>{{ statistic.processed_requests }}</td>
    </tr>
    <tr>
      <td>{{ tableRowLabels.spent_time }}</td>
      <td>{{ spentTime(statistic.start_time, statistic.end_time) }}</td>
    </tr>
    </tbody>
  </v-table>
</template>

<script setup lang="ts">
import type { PropType } from 'vue';

const componentTitle: string = 'Crawling Statistic';

const tableHeaderLabels: object = {
  label: 'Label',
  value: 'Value',
};

const tableRowLabels: object = {
  iteration: 'Iteration',
  total_requests: 'Total requests',
  processed_requests: 'Processed requests',
  spent_time: 'Spent time (sec)',
};

defineProps({
  statistic: {type: Object as PropType<CrawlingStatistic>, required: true},
});

const spentTime = (startTime: number, endTime: number): number => {
  return Math.round(endTime - startTime);
};
</script>

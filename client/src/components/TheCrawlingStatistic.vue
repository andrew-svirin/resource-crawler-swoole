<template>
  <h2>{{ componentTitle }}</h2>
  <v-table>
    <thead>
    <tr>
      <th>
        {{ tableHeaderLabels.status }}
      </th>
      <th>
        {{ tableHeaderLabels.amount }}
      </th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>{{ tableRowLabels.in_process }}</td>
      <td>{{ props.in_process }}</td>
    </tr>
    <tr>
      <td>{{ tableRowLabels.processed }}</td>
      <td>{{ props.processed }}</td>
    </tr>
    <tr>
      <td>{{ tableRowLabels.errored }}</td>
      <td>{{ props.errored }}</td>
    </tr>
    <tr>
      <td>{{ tableRowLabels.ignored }}</td>
      <td>{{ props.ignored }}</td>
    </tr>
    </tbody>
  </v-table>
</template>

<script setup lang="ts">
const componentTitle: string = 'Crawling Statistic';

const tableHeaderLabels: object = {
  status: 'Status',
  amount: 'Amount',
};

const tableRowLabels: object = {
  in_process: 'In Process',
  processed: 'Processed',
  errored: 'Errored',
  ignored: 'Ignored',
};

const props = defineProps({
  in_process: {type: Number, default: 0},
  processed: {type: Number, default: 0},
  errored: {type: Number, default: 0},
  ignored: {type: Number, default: 0},
});
</script>

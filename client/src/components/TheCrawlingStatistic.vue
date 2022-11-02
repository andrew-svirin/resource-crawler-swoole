<template>
  <h2>{{ componentTitle }}</h2>
  <v-table>
    <thead>
    <tr>
      <th>
        Name
      </th>
      <th>
        Value
      </th>
    </tr>
    </thead>
    <tbody>
    <tr>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <td>1</td>
      <td>2</td>
    </tr>
    </tbody>
  </v-table>
</template>

<script setup lang="ts">
const componentTitle = 'Crawling Statistic';
</script>

<template>
  <v-app>
    <v-container>
      <v-row>
        <v-col>
          <the-crawling-info />
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <the-crawling-statistic />
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <the-crawling-chart />
        </v-col>
      </v-row>
    </v-container>
  </v-app>
</template>

<script setup lang="ts">
import TheCrawlingInfo from '@/components/TheCrawlingInfo';
import TheCrawlingStatistic from '@/components/TheCrawlingStatistic.vue';
import TheCrawlingChart from '@/components/TheCrawlingChart.vue';
</script>

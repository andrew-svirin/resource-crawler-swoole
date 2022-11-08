<template>
  <v-form>
    <v-container fluid class="pa-0">
      <v-row>

        <v-col
          md="4"
        >
          <v-select
            v-model="form.resource_type"
            :items="resourceTypeItems"
            :label="labels.resourceType"
            required
          ></v-select>
        </v-col>

        <v-col
          md="4"
        >
          <v-text-field
            v-model="form.resource_path"
            :label="labels.resourcePath"
            required
          ></v-text-field>
        </v-col>

        <v-col
          md="4"
        >
          <v-text-field
            v-model="form.parallel_connections_amount"
            :label="labels.parallelConnectionsAmount"
            required
          ></v-text-field>
        </v-col>

      </v-row>
    </v-container>
  </v-form>
</template>

<script setup lang="ts">
import { reactive, toRaw, watch } from 'vue';

const labels: object = {
  resourceType: 'Type',
  resourcePath: 'Path',
  parallelConnectionsAmount: 'Parallel connections amount',
};

let form: CrawlingForm = reactive({
  parallel_connections_amount: 4,
  resource_path: 'https://data.fivethirtyeight.com/',
  resource_type: 'disk'
});

const resourceTypeItems = [
  {
    value: 'disk',
    title: 'Disk',
  },
  {
    value: 'web',
    title: 'Web',
  },
];

const emit = defineEmits(['formChanged']);

watch(form, (newForm: CrawlingForm) => {
  emit('formChanged', toRaw(newForm));
}, {immediate: true});
</script>

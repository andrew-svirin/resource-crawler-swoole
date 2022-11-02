<template>
  <v-form>
    <v-container fluid class="pa-0">
      <v-row>

        <v-col
          cols="12"
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
          cols="12"
          md="4"
        >
          <v-text-field
            v-model="form.resource_path"
            :label="labels.resourcePath"
            required
          ></v-text-field>
        </v-col>

      </v-row>
    </v-container>
  </v-form>
</template>

<script setup lang="ts">
import { reactive, toRaw, watch } from 'vue';

const labels = {
  resourceType: 'Type',
  resourcePath: 'Path',
};
let form: CrawlingForm = reactive({});
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
});
</script>

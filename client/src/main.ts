// Components
import App from './App.vue';

// Composables
import { createApp } from 'vue';

// Plugins
import { registerPlugins } from './plugins';
import vuetify from './plugins/vuetify';

// Styles
import './assets/main.css';

const app = createApp(App);

registerPlugins(app);

app
  .use(vuetify)
  .mount('#app');

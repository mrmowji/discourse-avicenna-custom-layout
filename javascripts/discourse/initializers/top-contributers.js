import { apiInitializer } from 'discourse/lib/api';
import TopContributers from '../components/top-contributers';

export default apiInitializer('1.14.0', (api) => {
  api.renderInOutlet(settings.plugin_outlet.trim(), TopContributers);
});

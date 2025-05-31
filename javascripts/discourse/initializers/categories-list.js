import { apiInitializer } from 'discourse/lib/api';
import CategoriesList from '../components/categories-list';

export default apiInitializer('1.14.0', (api) => {
  api.renderInOutlet(settings.plugin_outlet.trim(), CategoriesList);
});

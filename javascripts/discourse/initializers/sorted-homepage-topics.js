import { withPluginApi } from "discourse/lib/plugin-api";
import PreloadStore from "discourse/lib/preload-store";
import { setDefaultHomepage } from "discourse/lib/utilities";

export default {
  name: "discourse-custom-homepage",
  initialize() {
    withPluginApi("0.11.4", (api) => {
        setDefaultHomepage('latest?order=created&');
        PreloadStore.remove("topic_list");
    });
  },
};
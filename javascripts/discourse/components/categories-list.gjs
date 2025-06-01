import { getOwner } from "@ember/application";
import { tracked } from "@glimmer/tracking";
import { inject as service } from '@ember/service';
import Component from "@glimmer/component";
import { hbs } from 'ember-cli-htmlbars';
import { defaultHomepage } from 'discourse/lib/utilities';

export default class CategoriesList extends Component {
  @service router;
  @tracked categories = [];

  <template>
    {{#if this.showOnRoute}}
        <div class="custom-category-list">
        {{#each this.categories as |category|}}
            <a href="/c/{{category.slug}}/{{category.id}}" class="custom-category-list__item">
            {{#if category.uploaded_logo.url}}
                <img src="{{category.uploaded_logo.url}}" alt="{{category.name}} logo" class="custom-category-list__logo" />
            {{/if}}
            <div>
                <h2 class="custom-category-list__title">{{category.name}}</h2>
                <p class="custom-category-list__description">{{category.description_text}}</p>
            </div>
            </a>
        {{/each}}
        </div>
    {{/if}}
  </template>

  constructor() {
    super(...arguments);
    this.loadCategories();
  }

  async loadCategories() {
    let response = await fetch('/categories.json');
    let data = await response.json();
    this.categories = data.category_list.categories;
  }

  get showOnRoute() {
    const currentRoute = this.router.currentRouteName;
    return currentRoute === `discovery.${defaultHomepage()}`;
  }
}

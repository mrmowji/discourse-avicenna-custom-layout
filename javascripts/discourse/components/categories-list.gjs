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
            <a href="/t/ask-ai/2" class="custom-category-list__item ask-ai">
              <img src="https://forum.avicennaresearch.com/uploads/default/original/1X/2d4303f64fda0f6dbcfb87a32d65b357d9e93f3a.png" alt="Chat Bot" class="custom-category-list__logo" />
              <div>
                <h2 class="custom-category-list__title">Ask AI</h2>
                <p class="custom-category-list__description">Download our documentation, upload it to an AI tool like Google AI Studio, and engage in personalized Q&A sessions.</p>
            </div>
            </a>
            <a href="/t/ask-ai/1211" class="custom-category-list__item faq">
              <img src="https://forum.avicennaresearch.com/uploads/default/original/1X/f8ee0011198dba1c4e4a8d878c73441b1e6346e4.png" alt="Frequently Asked Questions" class="custom-category-list__logo" />
              <div>
                <h2 class="custom-category-list__title">FAQ</h2>
                <p class="custom-category-list__description">Find answers to common questions about Avicenna Research here. Check this page before submitting a ticket or contacting us.</p>
            </div>
            </a>
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

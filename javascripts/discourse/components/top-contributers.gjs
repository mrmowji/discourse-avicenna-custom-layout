import { getOwner } from "@ember/application";
import { tracked } from "@glimmer/tracking";
import { inject as service } from '@ember/service';
import Component from "@glimmer/component";
import { hbs } from 'ember-cli-htmlbars';
import { defaultHomepage } from 'discourse/lib/utilities';
import avatar from "discourse/helpers/avatar";

export default class TopContributers extends Component {
  @service router;
  @tracked contributors = [];

  <template>
    {{#if this.showOnRoute}}
      <div class="contribution">
        <div class="contributors-list">
          <h2>Top Contributors</h2>
          <ul>
            {{#each this.contributors as |item|}}
              <li class="contributor">
                {{avatar
                  item.user
                  avatarTemplatePath="avatar_template"
                  usernamePath="username"
                  namePath="name"
                  imageSize="large"
                }}
                <div class="name">
                  <div class="main">@{{item.user.username}}</div>
                  <div>{{item.user.name}}</div>
                </div>
                <div class="scores">
                  <div>Topics: {{item.topic_count}}</div>
                  <div>Posts: {{item.post_count}}</div>
                </div>
              </li>
            {{/each}}
          </ul>
        </div>
        <div class="contribution-promo">
          <h2>Contribute and Get Recognized!</h2>
          <p>
            Join our top contributors by sharing your knowledge and helping others. Your contributions make our community stronger!
          </p>
        </div>
      </div>
    {{/if}}
  </template>

  constructor() {
    super(...arguments);
    this.loadContributors();
  }

  async loadContributors() {
    let response = await fetch('/directory_items.json?period=quarterly&order=topic_count&exclude_groups=admins|moderators&limit=5');
    let data = await response.json();
    this.contributors = data.directory_items;
  }

  get showOnRoute() {
    const currentRoute = this.router.currentRouteName;
    return currentRoute === `discovery.${defaultHomepage()}`;
  }
}

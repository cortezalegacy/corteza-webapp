/* file is generated, do not modify by hand */

const state = {
  // local error state
  errors: [],

  // custom section state
{foreach $endpoints as $endpoint}{foreach $endpoint.apis as $api}
  {$api.callShort}: {},
{/foreach}{/foreach}
}

const getters = {}

const actions = {
{foreach $endpoints as $endpoint}{foreach $endpoint.apis as $api}
  async {$api.callShort|ucfirst} ({ldelim} commit {rdelim}{if !empty($api.arguments)}, {ldelim} {$api.arguments} {rdelim}{/if}) {
    try {
      commit('error', '')
      commit('{$api.callSection}', {})
      const response = this._vm.$crm.{$api.call}({if !empty($api.arguments)}{ldelim} {$api.arguments} {rdelim}{/if})
      commit('{$api.callSection}', response)
    } catch (e) {
      commit('error', e.message)
      throw e
    }
  },
{/foreach}{/foreach}
}

const mutations = {
  // common modifiers
  error (state, err) {
    state.errors = [err]
  },
  errors (state, errs) {
    state.errors = errs
  },

  // custom section modifiers
{foreach $endpoints as $endpoint}{foreach $endpoint.apis as $api}
  {$api.callSection} (state, response) {
    state['{$api.callShort}'] = response
  },
{/foreach}{/foreach}
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}



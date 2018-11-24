import axios from 'axios'

// If you want to edit this file, talk to @titpetric before :)

// As this file is generated, any mock calls should go into
// the related *_mock.js file; please don't modify this file.

class {class} {
  constructor (baseLink) {
    this.baseLink = baseLink || 'https://{class|strtolower}.api.latest.rustbucket.io'
    this.headers = {
      'Content-Type': 'application/json',
    }
  }

  baseURL () {
    return this.baseLink
  }

  stdReject (reject) {
    return (error) => {
      reject(error)
    }
  }

  stdResolve (resolve, reject) {
    return (response) => {
      if (response.data.error) {
        reject(response.data.error)
      } else {
        resolve(response.data.response)
      }
    }
  }
{foreach $endpoints as $endpoint}{foreach $endpoint.apis as $api}

  async {$api.call} ({if !empty($api.arguments)}{ldelim} {$api.arguments} {rdelim}{/if}) {
    const endpoint = `${ldelim}this.baseLink{rdelim}/{api.link}`
    return new Promise((resolve, reject) => {
      axios({
        method: '{api.method|strtoupper}',
        url: endpoint,
        withCredentials: true,
        headers: this.headers,{if !empty($api.params)}
        params: {
{foreach $api.params as $name}
          '{name}': {name|camel},
{/foreach}
        },{else}
        params: {ldelim}{rdelim},{/if}{if !empty($api.data)}
        data: {
{foreach $api.data as $name}
          '{name}': {name|camel},
{/foreach}
        },
{else}
        data: {ldelim}{rdelim},
{/if}
      }).then(this.stdResolve(resolve, reject), this.stdReject(reject))
    })
  }
{/foreach}{/foreach}
}

export default {
  install (Vue, store) {
    const client = new {class}(window.CrustConfig.{class|strtolower}.baseUrl)

    Vue.prototype.${class|strtolower} = client
  },
}

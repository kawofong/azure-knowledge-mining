'use strict';
const https = require ('https');
const request = require('request-promise');

const subscriptionKey = '<bing-entity-search-key>';
const host = 'api.cognitive.microsoft.com';
const path = '/bing/v7.0/entities';
const mkt = 'en-US';

async function bing_entity_search (entity) {
  const query = '?mkt=' + mkt + '&q=' + encodeURI(entity);
  const url = 'https://' + host + path + query;
  const opt = {
    'url': url,
    'headers': {
      'Ocp-Apim-Subscription-Key' : subscriptionKey
    }
  }

  let res = await request.get(opt);

  if (res.err) {
    console.log('error');
  }
  else {
    return JSON.parse(res);
  }
};

const test_data = [
  {
    "recordId": "e1",
    "data": {
      "locations": [
        "Kensington",
        "London",
        "London, UK",
        "Cromwell Road"
      ]
    }
  },
  {
    "recordId": "e2",
    "data": {
      "locations": [
        "Boston",
        "Massachusetts"
      ]
    }
  }
];

let values = JSON.parse(JSON.stringify(test_data));

(async function () {
  for await (const record of values) {
    const locations = record.data.locations;

    record.data = {
      "entities": []
    };

    await (async function () {

      for await (const location of locations) {
        const res = await bing_entity_search (location);

        if (res && res['entities'] && res['entities']['value']) {
          record.data.entities.push({
            "entity_name": res['entities']['value'][0]['name'],
            "entity_desc": res['entities']['value'][0]['description'],
            "entity_search_url": res['entities']['value'][0]['webSearchUrl']
          });
        }
      }
    })();
  }

  console.log(JSON.stringify(values));
})();
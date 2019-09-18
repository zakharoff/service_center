import axios from 'axios'

let token = document.getElementsByName('csrf-token')[0].getAttribute('content');
axios.defaults.headers.common['X-CSRF-Token'] = token;
axios.defaults.headers.common['Accept'] = 'application/json';

const adapter = axios.create({
  baseURL: '/'
});

const backend = {
  client: {
    current: () => adapter.get('/clients/home/user')
  },
  staff: {
    current: () => adapter.get('/staffs/home/user'),
    clients: () => adapter.get('/staffs/clients'),
    createClient: (params) => adapter.post('/staffs/clients', params)
  }
};

export { backend }
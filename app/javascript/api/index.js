import axios from 'axios'

export function axiosUser(url) {
  return axios.get(url);
}

export function axiosPost(url, params) {
  return axios.post(url, params)
}

import axios from 'axios'

export function axiosUser(url) {
  return axios.get(url);
}

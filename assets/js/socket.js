import {Socket} from 'phoenix';

const socket = new Socket('/socket', {params: {email: window.email}});
socket.connect();

export default socket;
